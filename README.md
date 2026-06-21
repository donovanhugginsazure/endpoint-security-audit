# Endpoint Security & Compliance Auditor

## Business Case
MSPs manage hundreds of client machines and must ensure they comply with basic security standards. Manually checking if firewalls are on, antivirus is active, and disks aren't full takes too much time. This automated script gathers vital machine metrics, runs a security health check, flags non-compliant settings, and outputs an audit report used to update client tickets.

## 🛠️ Technologies Used
* **Language:** PowerShell (v5.1+)
* **Modules:** CIM (Common Information Model) Cmdlets, NetSecurity.
* **Concepts:** System queries, compliance auditing, string formatting.

## How to Run and Test This Project
1. Open PowerShell as an **Administrator**.
2. Clone this repository or copy the `AuditEndpoint.ps1` script to your machine.
3. Run the script:
   ```powershell
   .\AuditEndpoint.ps1
   ```
4. Look at the text output directly in your console window.
5. Open the newly created `Endpoint_Security_Report.txt` file in the same folder to see the clean, saved audit report.

## Key Learnings
* Gained experience using CIM cmdlets to query core Windows Operating System health and security settings.
* Modeled an automated ticket-triage workflow by programmatically identifying system vulnerabilities and resource bottlenecks.
