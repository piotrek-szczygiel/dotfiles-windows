@echo off
if [%1]==[] (
    z -I .
) else (
    z -I %*
)
