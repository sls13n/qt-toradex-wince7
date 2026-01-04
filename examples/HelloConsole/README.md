# Hello World Console Application

Simple Qt console application that outputs "Hello World" to stdout.

## Prerequisites

- Completed Qt 5.1.0 WinCE build (see main README.md)
- Visual Studio 2008 Command Prompt 

## Build Instructions
Run commands from `Visual Studio 2008 Command Prompt`
```cmd
cd c:\Qt\examples\HelloConsole

c:\Qt\qt-toradex-build-5.1\qtbase\bin\qmake.exe -spec wince70-toradex-armv4i-msvc2008 helloworld.pro

nmake
```

## Output

The compiled executable will be in the `release\` folder:
- `release\helloworld.exe` - ARM executable for Toradex WinCE device

## Deployment

Copy `helloworld.exe` and required Qt DLLs (`Qt5Core.dll`) to your WinCE device and run.
