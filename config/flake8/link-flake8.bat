@echo off
pushd %userprofile%
del .flake8 >nul 2>&1
mklink .flake8 %dotfiles%\config\flake8\.flake8
popd
