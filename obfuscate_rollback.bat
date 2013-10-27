@echo off
setlocal enabledelayedexpansion

for /f "tokens=*" %%i in ('dir /b *.lua.bak') do (
	echo "%%i" %%~ni
	set name=%%~ni
	del !name!
	ren "%%i" "!name!"
)

echo "locales\ruRU.lua"
del "locales\ruRU.lua"
ren "locales\ruRU.lua.bak" ruRU.lua
echo "locales\ruRU.lua"
del "locales\enUS.lua"
ren "locales\enUS.lua.bak" enUS.lua


pause
