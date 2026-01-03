@echo off
REM ============================================================================
REM Script: 4.copy-missing-sources.bat
REM Purpose: Copy missing source files from Qt source to build directory
REM Usage: Run this script from the Qt build directory (e.g., C:\QtTemp\qt-build-dir)
REM ============================================================================

setlocal enabledelayedexpansion

REM Verify we're in the build directory
if not exist "qtbase" (
    echo ERROR: This script must be run from the Qt build directory
    echo Current directory: %CD%
    echo Expected to find: qtbase subdirectory
    pause
    exit /b 1
)

REM Set source directory (assumes qt-everywhere-opensource-src-5.1.0 is in parent directory)
set SOURCE_DIR=..\qt-everywhere-opensource-src-5.1.0

if not exist "%SOURCE_DIR%\qtbase" (
    echo ERROR: Qt source directory not found at %SOURCE_DIR%
    pause
    exit /b 1
)

echo ============================================================================
echo Copying missing source files...
echo Source: %SOURCE_DIR%
echo Target: %CD%
echo ============================================================================
echo.

REM ============================================================================
REM Copy QtZlib headers
REM ============================================================================
echo [1/3] Copying QtZlib headers...

if not exist "qtbase\include\QtZlib" (
    echo   Creating directory: qtbase\include\QtZlib
    mkdir qtbase\include\QtZlib
)

echo   Copying headers from %SOURCE_DIR%\qtbase\include\QtZlib\
copy /Y "%SOURCE_DIR%\qtbase\include\QtZlib\*.h" "qtbase\include\QtZlib\" >nul
if %ERRORLEVEL% EQU 0 (
    echo   SUCCESS: QtZlib headers copied
) else (
    echo   WARNING: Failed to copy some QtZlib headers
)

echo.

REM ============================================================================
REM Copy qconfig.* files from build to source
REM ============================================================================
echo [2/3] Copying qconfig.* files from build to source...

echo   Copying qconfig files to source directory
copy /Y "qtbase\src\corelib\global\qconfig.*" "%SOURCE_DIR%\qtbase\src\corelib\global\" >nul
if %ERRORLEVEL% EQU 0 (
    echo   SUCCESS: qconfig files copied to source
) else (
    echo   WARNING: Failed to copy qconfig files
)

echo.

REM ============================================================================
REM Create qconfig.h in source include directory
REM ============================================================================
echo [3/3] Creating qconfig.h in source include directory...

set QCONFIG_INCLUDE=%SOURCE_DIR%\qtbase\include\QtCore\qconfig.h

echo   Creating %QCONFIG_INCLUDE%
echo #include "../../src/corelib/global/qconfig.h" > "%QCONFIG_INCLUDE%"
if %ERRORLEVEL% EQU 0 (
    echo   SUCCESS: qconfig.h created with include redirect
) else (
    echo   ERROR: Failed to create qconfig.h
)

echo.
echo ============================================================================
echo Copy operation completed!
echo ============================================================================
echo.

REM Add more copy operations here as needed:
REM 
REM Example for copying additional missing sources:
REM 
REM echo [2/2] Copying additional sources...
REM if not exist "target\directory" mkdir target\directory
REM copy /Y "%SOURCE_DIR%\source\path\*.*" "target\directory\" >nul
REM

pause
endlocal
