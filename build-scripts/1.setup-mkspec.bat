@echo off
REM =============================================================================
REM Setup mkspec directory for Qt 5.1.0 Windows CE 7 ARM build
REM =============================================================================
REM
REM This script creates the mkspec directory and copies required files.
REM
REM Usage:
REM   cd <qt-source-directory>
REM   <path-to>\setup-mkspec.bat
REM
REM =============================================================================

setlocal

echo.
echo ========================================
echo Qt 5.1.0 - Setup mkspec Directory
echo ========================================
echo.

REM Get the directory where this script is located
set SCRIPT_DIR=%~dp0

REM Check if we're in the Qt source directory
if not exist "configure.bat" (
    echo ERROR: This script must be run from the Qt source root directory.
    echo Expected to find configure.bat in the current directory.
    echo.
    echo Usage:
    echo   cd ^<qt-source-directory^>
    echo   %~nx0
    echo.
    pause
    exit /b 1
)

echo [1/4] Creating mkspec directory...
set MKSPEC_DIR=qtbase\mkspecs\wince70-toradex-armv4i-msvc2008

if not exist "%MKSPEC_DIR%" (
    mkdir "%MKSPEC_DIR%"
    if errorlevel 1 (
        echo ERROR: Failed to create directory %MKSPEC_DIR%
        pause
        exit /b 1
    )
    echo     SUCCESS: Created %MKSPEC_DIR%
) else (
    echo     INFO: Directory already exists: %MKSPEC_DIR%
)

echo.
echo [2/4] Copying qmake.conf...
if not exist "%SCRIPT_DIR%qmake.conf" (
    echo ERROR: Source file not found: %SCRIPT_DIR%qmake.conf
    pause
    exit /b 1
)

copy /Y "%SCRIPT_DIR%qmake.conf" "%MKSPEC_DIR%\qmake.conf" > nul
if errorlevel 1 (
    echo ERROR: Failed to copy qmake.conf
    pause
    exit /b 1
)
echo     SUCCESS: Copied qmake.conf to %MKSPEC_DIR%

echo.
echo [3/4] Copying qplatformdefs.h...
if not exist "%SCRIPT_DIR%qplatformdefs.h" (
    echo ERROR: Source file not found: %SCRIPT_DIR%qplatformdefs.h
    pause
    exit /b 1
)

copy /Y "%SCRIPT_DIR%qplatformdefs.h" "%MKSPEC_DIR%\qplatformdefs.h" > nul
if errorlevel 1 (
    echo ERROR: Failed to copy qplatformdefs.h
    pause
    exit /b 1
)
echo     SUCCESS: Copied qplatformdefs.h to %MKSPEC_DIR%

echo.
echo [4/4] Copying default_post.prf...
if not exist "%SCRIPT_DIR%default_post.prf" (
    echo ERROR: Source file not found: %SCRIPT_DIR%default_post.prf
    pause
    exit /b 1
)

copy /Y "%SCRIPT_DIR%default_post.prf" "%MKSPEC_DIR%\default_post.prf" > nul
if errorlevel 1 (
    echo ERROR: Failed to copy default_post.prf
    pause
    exit /b 1
)
echo     SUCCESS: Copied default_post.prf to %MKSPEC_DIR%

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo mkspec directory configured at:
echo   %CD%\%MKSPEC_DIR%
echo.
echo Next step: Run configure-qt.bat from your build directory
echo.

endlocal
exit /b 0
