# Dotfiles for Windows

## Install

Install Claude Code and ask it to set up this repo (`install.ps1` adds it to PATH):

```powershell
irm https://claude.ai/install.ps1 | iex
~\.local\bin\claude.exe
```

Setup (git and pwsh are not on PATH until a new terminal):

```powershell
winget install Git.Git Microsoft.PowerShell
& "$env:ProgramFiles\Git\cmd\git.exe" clone https://github.com/piotrek-szczygiel/dotfiles-windows $env:LOCALAPPDATA\dotfiles
& "$env:ProgramFiles\PowerShell\7\pwsh.exe" $env:LOCALAPPDATA\dotfiles\install.ps1
```

## Manual

1. Add `~\.ssh\id_ed25519.pub` to https://github.com/settings/keys and https://git.szczygiel.dev/user/settings/keys.
2. 1Password: sign in, then Settings → Developer → Use the SSH agent.
3. Create a Dev Drive as `D:` (Settings → System → Storage → Disks & volumes).
4. Restart Windows Terminal and Claude Code.

## Notes

- Windows Terminal settings are copied, not linked. Copy changes back to the repo by hand.
