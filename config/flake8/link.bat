@echo on
cd %userprofile%
del .flake8
mklink .flake8 %dotfiles%\config\flake8\.flake8
