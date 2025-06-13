# GTAOnline MacroScript

## Features

- Blocks Rockstar server IP to enable NoSave mode (solo public lobby)
- Suspends `GTA5.exe` process for 10 seconds to disconnect from other players
- Toggles Left Click Macro for looting cash, gold, diamonds etc. in Heists
- Easy toggling with keyboard shortcuts
- Requires Administrator privileges

## Usage

- **Ctrl + F9** — Enable NoSave mode (block Rockstar server IP)
- **Ctrl + F12** — Disable NoSave mode (remove firewall block)
- **Ctrl + F4** — Suspend GTA5.exe for 10 seconds (disconnect from others)
- **Ctrl + F5** — Toggles Left Click Macro (use it for looting cash, gold, diamonds etc.)
  
## Requirements

- Windows OS
- [AutoHotkey v1.1](https://www.autohotkey.com/)
- [`PsTools.zip`](https://download.sysinternals.com/files/PSTools.zip)
- Extract `PsTools.zip` to `System32` or set system PATH to it if extracted elsewhere
- Ensure [`PsSuspend.exe`](https://learn.microsoft.com/en-us/sysinternals/downloads/pssuspend) which is included in the `PsTools.zip` is either in `System32` or available in system PATH
- Run script as Administrator

## Notes

- Script cleans up firewall rules and resumes suspended process on exit.
- Confirmation prompt before suspending the process.

## License

This project is licensed under the [MIT License](LICENSE).
