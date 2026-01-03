@echo off
REM ========================================
REM Qt 5.1.0 WinCE 7 ARM - Configure Script
REM ========================================
REM This script configures Qt for Windows CE 7 ARM build
REM Must be run from Visual Studio 2008 Command Prompt!

echo ========================================
echo Qt 5.1.0 WinCE 7 ARM - Configure
echo ========================================
echo.

REM Check if we're in VS2008 Command Prompt
where cl.exe >nul 2>&1
if errorlevel 1 (
    echo ERROR: cl.exe not found in PATH!
    echo This script must be run from Visual Studio 2008 Command Prompt!
    echo.
    pause
    exit /b 1
)

REM Get Qt source directory from command line or use default
set QT_SOURCE=%1
if "%QT_SOURCE%"=="" (
    set QT_SOURCE=..\qt-everywhere-opensource-src-5.1.0
)

REM Check if source directory exists
if not exist "%QT_SOURCE%\configure.bat" (
    echo ERROR: Qt source directory not found: %QT_SOURCE%
    echo Expected to find configure.bat in that directory.
    echo.
    echo Usage: %0 [qt-source-path]
    echo Example: %0 ..\qt-everywhere-opensource-src-5.1.0
    pause
    exit /b 1
)

REM Get current directory as build directory
set BUILD_DIR=%CD%

echo Qt source: %QT_SOURCE%
echo Build directory: %BUILD_DIR%
echo.

REM Set installation prefix
set INSTALL_PREFIX=C:\Qt5.1\qt-toradex-ce7-arm-5.1.0

echo Installation prefix: %INSTALL_PREFIX%
echo.
echo Starting Qt configuration...
echo This will take 5-10 minutes...
echo.

REM Run configure
"%QT_SOURCE%\configure.bat" ^
  -opensource ^
  -confirm-license ^
  -xplatform wince70-toradex-armv4i-msvc2008 ^
  -release ^
  -prefix "%INSTALL_PREFIX%" ^
  -nomake examples ^
  -nomake tests ^
  -nomake tools ^
  -opengl es2 ^
  -qt-zlib ^
  -qt-libpng ^
  -qt-libjpeg ^
  -qt-freetype ^
  -no-accessibility ^
  -no-openssl ^
  -no-dbus ^
  -no-audio-backend ^
  -no-qml-debug

if errorlevel 1 (
    echo.
    echo ERROR: Configuration failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Configuration Complete!
echo ========================================
echo.
echo Next steps:
echo   1. Build QtBase:       cd qtbase ^&^& nmake
echo   2. Build QtJSBackend:  cd ..\qtjsbackend\src\v8 ^&^& qmake ^&^& [EDIT Makefile.Release] ^&^& nmake ^&^& cd ..\.. ^&^& nmake
echo   3. Build QtDeclarative: cd ..\qtdeclarative ^&^& nmake
echo   4. Install Qt:         cd .. ^&^& nmake install
echo.
echo IMPORTANT: QtJSBackend requires manual Makefile.Release edit!
echo See README.md for details.
echo.
pause
