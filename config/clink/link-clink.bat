@echo off
pushd "%userprofile%\scoop\persist\clink"
rmdir /s /q "profile"
mklink /d "profile" "%dotfiles%\config\clink\profile"
popd
