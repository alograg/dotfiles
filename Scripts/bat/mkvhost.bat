@ECHO OFF
GOTO sub_1

:sub_1
set /p id="SubDomine? "
echo 192.168.3.77	%id%.localwamp.dev>>C:\Windows\System32\drivers\etc\hosts
mkdir D:\wamp\vhosts\%id%.localwamp.dev
CHOICE /C:YN /m "An other [Y]yes or [N]No"
goto sub_%ERRORLEVEL% 

:sub_2
ipconfig /flushdns
ipconfig /registerdns
goto:eof