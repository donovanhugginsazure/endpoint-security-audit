# MSP Endpoint Security & Compliance Audit Script
# Purpose: Inspect local system security posture and export a health report.

$ReportPath = ".\Endpoint_Security_Report.txt"
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== Starting MSP Security Audit ===" -ForegroundColor Cyan

# 1. Gather System Information
$OS = (Get-CimInstance Win32_OperatingSystem).Caption
$Antivirus = (Get-CimInstance -Namespace root\SecurityCenter2 -ClassName AntiVirusProduct).displayName
if (-not $Antivirus) { $Antivirus = "Windows Defender (Default) or None Detected" }

# 2. Check Windows Firewall Status
$Firewall = Get-NetFirewallProfile -Profile Domain,Private,Public
$FirewallStatus = "ENABLED"
foreach ($Profile in $Firewall) {
    if ($Profile.Enabled -eq $false) {
        $FirewallStatus = "WARNING: Disabled on $($Profile.Name) profile!"
    }
}

# 3. Check Available Disk Space (C: Drive)
$Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$FreeSpaceGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
$SizeGB = [math]::Round($Disk.Size / 1GB, 2)
$SpaceStatus = "OK ($FreeSpaceGB GB free of $SizeGB GB)"
if ($FreeSpaceGB -lt 20) {
    $SpaceStatus = "WARNING: Low Disk Space! Only $FreeSpaceGB GB remaining."
}

# 4. Generate the Compliance Report
$ReportContent = @"
==================================================
MSP ENDPOINT COMPLIANCE REPORT
Generated On: $Timestamp
==================================================
Operating System: $OS
Active Antivirus: $Antivirus
Firewall Status:  $FirewallStatus
C: Drive Space:   $SpaceStatus
==================================================
"@

# Output to console and save to file
Write-Host $ReportContent -ForegroundColor Yellow
$ReportContent | Out-File -FilePath $ReportPath -Force

Write-Host "=== Audit Complete. Report saved to $ReportPath ===" -ForegroundColor Cyan
