# Piotr Szczygieł's dotfiles for Windows

- Install App Installer from Microsoft Store

 - Execute following in PowerShell (NOT as Administrator)
```
winget install --exact --id gerardog.gsudo --silent
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb https://raw.github.com/piotrek-szczygiel/dotfiles-windows/master/bin/bootstrap.ps1 | iex
```
