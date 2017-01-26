@echo off
cls
choice /C ns /N /T:9999 /D:s /M "Implementa Laravel?[n,s]"
set /a laravel=%errorlevel%-1
choice /C ns /N /T:9999 /D:s /M "Usa Git?[n,s]"
set /a useGit=%errorlevel%-1
set /p id="ID del projecto: " %=%
mkdir E:\wamp\vhosts\%id%.localwamp.dev\web
mkdir "C:\Users\Henry\Google Drive\Projectos\%id%\Archivos"
mkdir "C:\Users\Henry\Google Drive\Projectos\%id%\Documentos"
rmdir /S /Q E:\Proyectos\%id%
mkdir E:\Proyectos\%id%\Desarrollo
set ProjectPath=E:\Proyectos\%id%\Desarrollo
if %useGit% == 1 (
	set /p url="Repositorio GIT: " %=%
	git clone "%url%" %ProjectPath%
)
if %laravel% == 1 (
	choice /C ns /N /T:9999 /D:s /M "Actualizar Laravel?[n,s]"
	if errorlevel 2 (
		echo Actualizando Laravel...
		rmdir /S /Q D:\laravel
		call composer create-project laravel/laravel D:\laravel --prefer-dist
	)
	echo Instalando Laravel...
	call xcopy D:\laravel\*.* E:\Proyectos\%id%\Desarrollo\*.* /S/C/Y/q
	git reset --hard -- E:\Proyectos\%id%\Desarrollo
	mklink /J E:\wamp\vhosts\%id%.localwamp.dev\web\content %ProjectPath%\public
	mkdir %ProjectPath%\app\views\home
	mkdir %ProjectPath%\app\views\layouts
	choice /C ns /N /T:9999 /D:s /M "Crear base de datos?[n,s]"
	if errorlevel 2 (
		call %~dp0\NewDatabase.bat %id%
		set databaseFile="%1%\app\config\database.php"
		set databaseString="'database'  => 'database',"
		set databaseReplace="'database'  => '%1%',"
		call cscript %Scripts%\replace.vbs %databaseFile% %databaseString% %databaseReplace%
		choice /C ns /N /T:9999 /D:s /M "Instalar Sentry?[n,s]"
		if errorlevel 2 (
			call %~dp0\InstallSentry.bat %ProjectPath% %id%
			cd %~dp0
		)
	)
) else (
	mklink /J E:\wamp\vhosts\%id%.localwamp.dev\web\content %ProjectPath% 
)
mklink /J E:\Proyectos\%id%\Archivos "C:\Users\Henry\Google Drive\Projectos\%id%\Archivos"
mklink /J  E:\Proyectos\%id%\Documentos "C:\Users\Henry\Google Drive\Projectos\%id%\Documentos"
echo Creando SubllumeProject...
echo {"folders":[{"path": "%ProjectPath%"}]}>C:\Users\Henry\Documents\%id%.sublime-project
call cscript %~dp0\replace.vbs "C:\Users\Henry\Documents\%id%.sublime-project" "\" "/"
call echo 127.0.0.1       %id%.localwamp.dev >> C:\Windows\System32\drivers\etc\hosts
call %~dp0\FlushDNS.bat
