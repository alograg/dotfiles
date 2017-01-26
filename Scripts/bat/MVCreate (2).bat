@echo off
REM echo %~dp0
REM echo %CD%
set artisanPath=%CD%\artisan
php %artisanPath% generate:scaffold %1 --fields=%2
call move /Y %~dp0templates\MVC\views\blank %~dp0templates\MVC\views\%1s
call xcopy %~dp0\templates\MVC\*.* %CD%\app\*.* /S/C/Y/Q
for /f %%f in ('dir /b %CD%\app\views\%1s') do call cscript %Scripts%\replace.vbs %CD%\app\views\%1s\%%f blank %1s
for /f %%g in ('dir /b %CD%\app\lang') do call move %CD%\app\lang\%%g\blank.php %CD%\app\lang\%%g\%1s.php
call move /Y %~dp0templates\MVC\views\%1s %~dp0templates\MVC\views\blank
