@echo off
cls
setlocal ENABLEDELAYEDEXPANSION
for /l %%j in (%2, -1, %1) do (
	set /a newName = %%j +1
	if %%j EQU 9 (
		rename 0%%j.*  !newName!.*
	) else if %%j LSS 9 (
		rename 0%%j.*  0!newName!.*
	) else (
		rename %%j.*  !newName!.*
	)
)
endlocal