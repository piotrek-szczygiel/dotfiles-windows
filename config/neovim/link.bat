@echo on
cd %localappdata%
rmdir /s /q nvim
mklink /d nvim %dotfiles%\config\neovim\nvim
