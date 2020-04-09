@echo off
pushd "%dotfiles%"
git commit --all --message "update"
git pull --rebase
git push
popd
