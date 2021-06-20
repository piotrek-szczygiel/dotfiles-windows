@echo off
mkdir "%appdata%\Sublime Text\Packages\User" >nul 2>&1
pushd "%appdata%\Sublime Text\Packages\User"
del *.sublime-settings >nul 2>&1
for %%f in ("%dotfiles%\config\sublime-text\*.sublime-settings") do (mklink "%%~nxf" "%%f")
popd
