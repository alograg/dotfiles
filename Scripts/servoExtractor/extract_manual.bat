@ECHO OFF
"C:\Program Files\Firebird\Firebird_2_5\bin\isql.exe" -z -u sysdba -p henry -i fotoReference.sql -o fotoReference.csv SESXXI.EDB
@REM "C:\Users\Henry\Downloads\fbexport-1.90.tar\fbexport-1.90\exe\fbexport.exe" -Sc  -D D:\Trabajo\Monclair\db\SESXXI.EDB -U sysdba -P henry -F D:\Trabajo\Monclair\db\fotosReference.csv -Q "select \"Matricula\",\"Foto\" from DSE130D3;"
@REM "C:\Users\Henry\Downloads\fbexport-1.90.tar\fbexport-1.90\exe\fbexport.exe" -X  -D D:\Trabajo\Monclair\db\SESXXI.EDB -U sysdba -P henry -F D:\Trabajo\Monclair\db\extractFotos.sql