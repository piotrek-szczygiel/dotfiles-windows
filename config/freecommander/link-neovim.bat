@echo off
pushd "%userprofile%\scoop\persist\freecommander"
rmdir /s /q "Settings"
mklink /d "Settings" "%dotfiles%\config\freecommander\Settings"
popd
