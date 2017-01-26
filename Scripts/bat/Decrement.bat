@echo off
cls
setlocal ENABLEDELAYEDEXPANSION
for /l %%j in (%1, 1, %2) do (
	set /a newName = %%j -1
	if %%j EQU 10 (
		rename %%j.*  0!newName!.*
	) else if %%j LSS 10 (
		rename 0%%j.*  0!newName!.*
	) else (
		rename %%j.*  !newName!.*
	)
)
endlocal