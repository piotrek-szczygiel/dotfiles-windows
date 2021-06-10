@echo off
mkdir %localappdata%\nvim >nul 2>&1
pushd %localappdata%\nvim
del init.vim >nul 2>&1
mklink init.vim %dotfiles%\config\neovim\init.vim
popd
