@echo off
if [%1]==[] (
    gvim
) else (
    gvim --remote-silent %*
)
