<div align="center">

# Windows 11 System & Network Repair

### A focused WPF maintenance center for SFC, DISM, WMI, TCP/IP, Winsock, IP, and DNS.

[![Windows](https://img.shields.io/badge/Windows-11-0078D4?logo=windows&logoColor=white)](#requirements)
[![PowerShell](https://img.shields.io/badge/PowerShell-Administrator-5391FE?logo=powershell&logoColor=white)](#quick-start)
[![Interface](https://img.shields.io/badge/Interface-WPF-6B4FBB)](#features)
[![License](https://img.shields.io/badge/License-GPL--3.0-2EA44F)](LICENSE)

<p>
  <a href="comm-interface-v1.ps1">
    <img alt="Open the repair script" src="https://img.shields.io/badge/View-PowerShell%20Script-5391FE?style=for-the-badge&logo=powershell&logoColor=white">
  </a>
  <a href="win11-repair-scr.exe">
    <img alt="Download the executable" src="https://img.shields.io/badge/View-Windows%20EXE-107C10?style=for-the-badge&logo=windows&logoColor=white">
  </a>
  <a href="#safety">
    <img alt="Read safety notes" src="https://img.shields.io/badge/Read-Safety%20Notes-C62828?style=for-the-badge&logo=github&logoColor=white">
  </a>
</p>

**Run one targeted repair, review live output, export the log, and restart when required.**

</div>

---

## ✨ Features

| Operation | What it runs | Expected effect |
|---|---|---|
| 🧩 System files | `SFC /SCANNOW`, then `DISM /RestoreHealth` | Checks and repairs Windows protected system files and component store. |
| 🗂️ WMI | `winmgmt /verifyrepository`, optional `salvagerepository` | Verifies WMI first and repairs only when verification fails. |
| 🌐 Network stack | `netsh int ip reset`, `netsh winsock reset` | Restores TCP/IP and Winsock defaults. |
| 🔄 IP and DNS | `ipconfig /release`, `/flushdns`, `/renew` | Releases, flushes, and renews the current IP/DNS configuration. |

The interface disables operation buttons while a repair is running, displays timestamped progress in the output panel, and can export the session output plus the final 500 lines of `CBS.log`.

## 🚀 Quick start

Run the PowerShell script in an elevated session:

```powershell
.\comm-interface-v1.ps1
```

The executable `win11-repair-scr.exe` is a separate compiled wrapper. Both versions require Windows administrator access for system-wide actions.

Native commands now receive explicit exit codes and output captured through temporary files; operation buttons stay disabled until the command finishes or reaches its configured timeout.

## 🛡️ Safety

- Save your work before running SFC, DISM, WMI repair, or network resets.
- SFC/DISM can take several minutes and may require a reboot.
- WMI repair can affect management tools until the repository is fully consistent.
- Network resets and IP renewal may interrupt VPN, remote desktop, Wi-Fi, or Ethernet connectivity.
- The app schedules a 60-second restart only after the user confirms the restart prompt.

## 📋 Requirements

- Windows 11.
- Administrator privileges.
- Windows PowerShell with WPF support.
- Network access if DISM must retrieve required component files.

## 📦 Repository contents

| File | Description |
|---|---|
| [`comm-interface-v1.ps1`](comm-interface-v1.ps1) | WPF maintenance interface and native command runner. |
| [`win11-repair-scr.exe`](win11-repair-scr.exe) | Compiled executable wrapper. |
| [`LICENSE`](LICENSE) | GNU General Public License v3.0. |

---

<div align="center">

### 🛡️ Repair selectively. Review every result. Export useful diagnostics.

**SFC · DISM · WMI · TCP/IP · Winsock · DNS**

</div>

