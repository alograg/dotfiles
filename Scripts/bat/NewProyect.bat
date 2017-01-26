@echo off
cls
set /p id="ID del projecto: " %=%
set /p name="Nombre del projecto: " %=%
mkdir E:\wamp\vhosts\%id%.localwamp.dev\web
set ProjectPath=E:\Proyectos\%id%\Desarrollo\public
mkdir %ProjectPath%
git init E:\Proyectos\%id%\Desarrollo\
mkdir E:\Proyectos\%id%\Archivos
mklink /J E:\wamp\vhosts\%id%.localwamp.dev\web\content %ProjectPath%
call echo 127.0.0.1       %id%.localwamp.dev >> C:\Windows\System32\drivers\etc\hosts
call %~dp0\FlushDNS.bat
echo [.ShellClassInfo] > E:\Proyectos\%id%\desktop.ini
echo ConfirmFileOp=0 >> E:\Proyectos\%id%\desktop.ini
echo NoSharing=1 >> E:\Proyectos\%id%\desktop.ini
echo InfoTip=%name% >> E:\Proyectos\%id%\desktop.ini
attrib +h E:\Proyectos\%id%\desktop.ini
attrib +s E:\Proyectos\%id%
