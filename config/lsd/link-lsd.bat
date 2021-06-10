@echo off
mkdir %appdata%\lsd >nul 2>&1
pushd %appdata%\lsd
del config.yaml >nul 2>&1
mklink config.yaml %dotfiles%\config\lsd\config.yaml
popd
