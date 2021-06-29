@echo off
mkdir "%appdata%\Sublime Text\Packages\User" >nul 2>&1
pushd "%appdata%\Sublime Text\Packages\User"
del Szczygi.tmTheme
del *.sublime-* >nul 2>&1
mklink Szczygi.tmTheme "%dotfiles%\config\sublime-text\Szczygi.tmTheme"
for %%f in ("%dotfiles%\config\sublime-text\*.sublime-*") do (mklink "%%~nxf" "%%f")
popd
