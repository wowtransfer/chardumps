@echo off
if not exist %cd%\chardumps.lua goto :L_del
	ren "%cd%\chardumps.lua" addon.lua
:L_del
del *_ob.lua
ren "%cd%\chardumps.lua.origin" chardumps.lua

ren "%cd%\chardumps.toc" chardumps.toc.new
ren "%cd%\chardumps.toc.origin" chardumps.toc
