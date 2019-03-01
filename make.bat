@echo off
set PATH=%PATH%%WIX%bin

echo heat ...
set NodeModules=./node_modules
heat dir ./node_modules -nologo -ag -cg modules -dr INSTALLLOCATION -var env.NodeModules -o modules.wxs

echo candle ...
candle -nologo -dbuild="%BUILD%" -dPID="%PID%" -arch x86 %PNAME%.wxs modules.wxs

echo light ...
light -nologo -b .\ -cultures:lv-LV -spdb -ext WixUIExtension %PNAME%.wixobj modules.wixobj -o %OUTPUT%\%PNAME%.msi

echo repair.cmd ...
echo msiexec /x {%PID%} /qb >%OUTPUT%\%PNAME%_repair.cmd	
echo msiexec /i %%~dp0\%PNAME%.msi /l*vx %%~dp0\%PNAME%.log /qb >>%OUTPUT%\%PNAME%_repair.cmd
