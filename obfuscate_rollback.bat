@echo off
setlocal enabledelayedexpansion

for /f "tokens=*" %%i in ('dir /b *.lua.bak') do (
	echo "%%i" %%~ni
	set name=%%~ni
	del !name!
	ren "%%i" "!name!"
)

pause
