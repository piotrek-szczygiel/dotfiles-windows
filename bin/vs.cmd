@echo off

if "%1" == "" (
    set arch=x64
) else (
    set arch=%1
)

for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -property installationPath`) do (
    if exist "%%i" (
        set vcvarsall=%%i\VC\Auxiliary\Build\vcvarsall.bat
    )
)

if "%vcvarsall%" == "" (
    echo Unable to find Visual Studio installation
    exit /b 1
)

cmd.exe /k set prompt=(%arch%) $P$G ^&^& call "%vcvarsall%" %arch%
