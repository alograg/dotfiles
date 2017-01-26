@echo off
for /f %%f in ('dir /b %CD%') do call cscript %Scripts%\replace.vbs %CD%\%%f %1 %2