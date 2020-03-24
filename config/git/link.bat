@echo on
cd %userprofile%
del .gitconfig
mklink .gitconfig %dotfiles%\config\git\.gitconfig
