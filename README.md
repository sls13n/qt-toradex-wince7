# Qt 5.1.0 for Toradex WinCE Build

## Requirements

- Visual Studio 2008 SP1
- Windows Embedded Compact 7 (Platform Builder)
- Windows Embedded Compact 7 updates for VS2008 [1](https://docs.toradex.com/109412-vs90sp1-kb2483802-x86.exe), [2](https://docs.toradex.com/109413-visualstudiodevicewindowsembeddedcompact7.msi) 
- Toradex CE7 SDK https://docs.toradex.com/102481 
- Qt 5.1.0 source code, download from https://download.qt.io/archive/qt/5.1/5.1.0/single/qt-everywhere-opensource-src-5.1.0.zip 
- Perl for Windows, download from https://strawberryperl.com/   

## Folder structure preparation

- Create folder `C:\Qt`
- Place a contents of this repo in `C:\Qt`
- Place in `C:\Qt` contents of `qt-everywhere-opensource-src-5.1.0.zip` archive
- Create build folder `C:\Qt\qt-toradex-build-5.1`

Should end up with folowing folder structure:

```
C:\Qt
├── build-scripts
├── patches
├── qt-everywhere-opensource-src-5.1.0
│   ├── gnuwin32
│   ├── qtactiveqt
│   ├── qtbase
│   ├── qtdeclarative
│   ├── ...
└── qt-toradex-build-5.1
```

## Apply patches and configuration

> following and later commands should be run only from **Visual Studio 2008 Command Prompt**

```cmd
cd c:\Qt\qt-everywhere-opensource-src-5.1.0

..\build-scripts\1.setup-mkspec.bat

..\build-scripts\2.apply-patches.bat ..\patches

cd ..\qt-toradex-build-5.1

..\build-scripts\3.configure-qt.bat

..\build-scripts\4.copy-missing-sources.bat
```

## Build Qt5Core, Qt5V8, Qt5Quick
```cmd
nmake module-qbase
```

```cmd
nmake module-qtjsbackend
```
```cmd
nmake module-qtdeclarative
```

