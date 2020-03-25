@echo off
mkdir %userprofile%\scoop\persist\clink\profile
pushd %userprofile%\scoop\persist\clink\profile
del settings >nul 2>&1
mklink settings %dotfiles%\config\clink\settings
popd
