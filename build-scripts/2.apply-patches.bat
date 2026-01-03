@echo off
setlocal enabledelayedexpansion
REM ========================================
REM Qt 5.1.0 WinCE 7 ARM - Complete Setup
REM ========================================
REM This script applies all patches and sets up mkspec files
REM Run this script from the Qt source root directory

echo ========================================
echo Qt 5.1.0 WinCE 7 ARM - Complete Setup
echo ========================================
echo.

REM Check if we're in the right directory
if not exist "configure.bat" (
    echo ERROR: This script must be run from the Qt source root directory!
    echo Expected to find configure.bat in current directory.
    echo.
    echo Usage:
    echo   1. Extract Qt 5.1.0 source to a directory
    echo   2. cd to that directory
    echo   3. Run: path\to\build-scripts\apply-patches.bat path\to\patches
    echo.
    echo Example:
    echo   cd C:\Qt5.1\qt-everywhere-opensource-src-5.1.0
    echo   ..\patches\build-scripts\apply-patches.bat ..\patches
    pause
    exit /b 1
)

REM Get the patches directory from command line argument
set PATCHES_DIR=%1
if "%PATCHES_DIR%"=="" (
    echo ERROR: Please provide the path to the patches directory!
    echo.
    echo Usage: %0 path\to\patches
    echo Example: %0 ..\patches
    pause
    exit /b 1
)

REM Convert to absolute path if needed
if not exist "%PATCHES_DIR%" (
    echo ERROR: Patches directory not found: %PATCHES_DIR%
    pause
    exit /b 1
)

echo Patches directory: %PATCHES_DIR%
echo.

REM ========================================
echo Step 1/1: Applying source code patches
echo ========================================
echo.

set PATCH_COUNT=0
set FAILED_COUNT=0

REM Check if patches are in subdirectories (qtbase, qtdeclarative)
for %%d in ("%PATCHES_DIR%\qtbase" "%PATCHES_DIR%\qtdeclarative") do (
    if exist "%%d\*.patch" (
        echo Applying patches from %%~nxd...
        for %%f in ("%%d\*.patch") do (
            echo   %%~nxf...
            git apply "%%f"
            if errorlevel 1 (
                echo     FAILED
                set /a FAILED_COUNT+=1
            ) else (
                echo     OK
                set /a PATCH_COUNT+=1
            )
        )
        echo.
    )
)

REM Also check for patches directly in PATCHES_DIR
for %%f in ("%PATCHES_DIR%\*.patch") do (
    echo Applying %%~nxf...
    git apply "%%f"
    if errorlevel 1 (
        echo   FAILED: %%~nxf
        set /a FAILED_COUNT+=1
    ) else (
        echo   OK
        set /a PATCH_COUNT+=1
    )
)

echo.
echo Applied !PATCH_COUNT! patches successfully
if !FAILED_COUNT! GTR 0 (
    echo WARNING: !FAILED_COUNT! patches failed!
    echo.
    pause
    exit /b 1
)


echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Successfully completed:
echo   [x] Applied !PATCH_COUNT! source code patches
echo.
echo Next steps:
echo   1. Create a build directory (e.g., C:\Qt5.1\qt-toradex-build)
echo   2. Open Visual Studio 2008 Command Prompt
echo   3. Run configure.bat with appropriate options
echo   4. Build Qt modules (qtbase, qtjsbackend, qtdeclarative)
echo.
echo See README.md for detailed build instructions.
echo.
pause
