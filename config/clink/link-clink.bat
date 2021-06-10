@echo off
mkdir %localappdata%\clink >nul 2>&1
pushd %localappdata%\clink

setlocal enabledelayedexpansion

for %%f in (%dotfiles%\config\clink\*) do (
    if not "%%~nxf" == "link-clink.bat" (
        del "%%~nxf" >nul 2>&1
        mklink "%%~nxf" "%dotfiles%\config\clink\%%~nxf"
    )
)

popd
