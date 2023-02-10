Vs2017Path = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\Tools\\VsDevCmd"
Vs2019Path = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\Common7\\Tools\\VsDevCmd"
Vs2022Path = "C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools\\VsDevCmd"

SettingsString = [[@echo off
If "%~1" == "run" GOTO RunDebugWin64
IF "%~1" == "make" GOTO MakeDebugWin64
IF "%~1" == "make-d-w32" GOTO MakeDebugWin32
IF "%~1" == "make-d-w64" GOTO MakeDebugWin64
IF "%~1" == "make-r-w32" GOTO MakeReleaseWin32
IF "%~1" == "make-r-w64" GOTO MakeReleaseWin64
IF "%~1" == "make-s-w32" GOTO MakeShippingWin32
IF "%~1" == "make-s-w64" GOTO MakeShippingWin64

:Refress
echo "Project Refresh"
cd "./Config/Premake5"
call premake5.exe VSVERSION
cd "../../"
]]