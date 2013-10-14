@echo off
setlocal enabledelayedexpansion

for /f "tokens=*" %%i in ('dir /b *_ob.lua') do (
	echo "%%i"
	set name=%%~ni
    del "!name:~0,-3!%%~xi"
	ren "%%i" "!name:~0,-3!%%~xi"
)

pause
