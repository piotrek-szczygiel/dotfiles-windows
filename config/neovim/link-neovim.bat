@echo off
pushd %localappdata%
rmdir /s /q nvim
mklink /d nvim %dotfiles%\config\neovim\nvim
popd
mkdir %userprofile%\.goneovim
pushd %userprofile%\.goneovim
del setting.toml >nul 2>&1
mklink setting.toml %dotfiles%\config\neovim\setting.toml
popd
