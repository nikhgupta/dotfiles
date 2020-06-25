@if (@X)==(@Y) @end /* harmless hybrid line that begins a JScript comment
::************ Batch portion ***********
@echo off

C:\Windows\System32\wsl.exe -u root /home/nikhgupta/.config/windows/scripts/init.sh
C:\Users\nikhg\PortableApps\pulseaudio\bin\pulseaudio.exe -L "module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" -L "module-waveout sink_name=output source_name=input record=0" --exit-idle-time=-1 -D

exit /b
************ JScript portion ***********/
var objShell = new ActiveXObject("WScript.shell");
objShell.run(WScript.ScriptFullName, 0);
