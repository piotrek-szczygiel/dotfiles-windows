@echo off
pushd %userprofile%
del /q .flake8
mklink .flake8 %dotfiles%\config\flake8\.flake8
popd
