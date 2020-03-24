@echo off
pushd %localappdata%
rmdir /s /q nvim
mklink /d nvim %dotfiles%\config\neovim\nvim
popd
