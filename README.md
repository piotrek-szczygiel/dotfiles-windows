# Piotr Szczygieł's dotfiles for Windows

 - Install winget from https://github.com/microsoft/winget-cli/releases
 - Execute following in Administrator PowerShell
```
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb https://raw.github.com/piotrek-szczygiel/dotfiles-windows/master/bin/bootstrap.ps1 | iex
```
