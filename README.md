# Windows System and Network Repair Tool

This repository contains a PowerShell/WPF maintenance interface and a Windows executable wrapper. The interface provides four actions:

| Action | Commands and effects |
|---|---|
| System files | Runs `sfc /scannow` and `DISM /Online /Cleanup-Image /RestoreHealth`. |
| WMI repository | Verifies the WMI repository and runs `winmgmt /salvagerepository` when the output indicates inconsistency. |
| Network stack | Resets TCP/IP and Winsock with `netsh`; a restart is recommended. |
| IP and DNS | Releases and renews the IP configuration and flushes the DNS cache; network connectivity may be interrupted. |

## Use

Run `comm-interface-v1.ps1` or `win11-repair-scr.exe` on Windows. Start the script or executable with administrator rights for system-wide repairs. Save your work first, and do not run the network actions over a connection you cannot afford to lose.

The interface displays command output but does not create a durable diagnostic log. Some operations take time, and the script does not automatically restart Windows. Review the output and restart when required.

