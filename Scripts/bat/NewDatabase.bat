@echo off
REM cls
echo Creando base de datos...
call E:\wamp\bin\mysql\mysql5.6.17\bin\mysql.exe --host=127.0.0.1 --user=root -e "CREATE SCHEMA %1% ;"
