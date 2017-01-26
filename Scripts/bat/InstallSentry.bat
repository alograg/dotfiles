@echo off
echo Instalando Sentry...
call xcopy %~dp0\templates\sentry\*.* %1%\*.* /S/C/Y/Q
set databaseFile="%1%\app\config\database.php"
set databaseString="'database'  => 'database',"
set databaseReplace="'database'  => '%2%',"
call cscript %Scripts%\replace.vbs %databaseFile% %databaseString% %databaseReplace%
call composer update -d %1%
set artisanPath=%1%\artisan
php %artisanPath% migrate:install
php %artisanPath% migrate --package=cartalyst/sentry
php %artisanPath% db:seed
php %artisanPath% config:publish cartalyst/sentry
