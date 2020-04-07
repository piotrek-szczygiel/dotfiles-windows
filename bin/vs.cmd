@if not defined _echo echo off
if "%1" == "" (
    set arch=x64
) else (
    set arch=%1
)

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" %arch%
