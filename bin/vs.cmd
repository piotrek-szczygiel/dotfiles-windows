@if not defined _echo echo off
if "%1" == "" (
    set arch=x64
) else (
    set arch=%1
)

for /f "usebackq delims=" %%i in (`vswhere.exe -prerelease -latest -property installationPath`) do (
    if exist "%%i\VC\Auxiliary\Build\vcvarsall.bat" (
        %comspec% /k "%%i\VC\Auxiliary\Build\vcvarsall.bat" %ARCH% %*
        exit /b
    )
)

rem Instance or command prompt not found
exit /b 2
