@echo off
pushd "%dotfiles%"
git pull --rebase
git commit --all --message "update"
git push
popd
