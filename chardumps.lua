--[[
	chardumps.lua
		Main module
	Chardumps
		Dump of character.
	version 1.0
	Created by SlaFF
		Gracer (Alliance)
	thanks Sun`s chardump, reforged
]]

chardumps = LibStub('AceAddon-3.0'):NewAddon('chardumps');

--[[
	Functions
--]]

function CHD_Message(...)
	local x = {...};
	for k,v in pairs(x) do
		print("\124cFF9F3FFFchardump:\124r ", tostring(v));
	end
end

function CHD_PrintTable(table)
	local t = table;
	for k,v in pairs(t) do
		print(string.format("%-20s%s", tostring(k), tostring(v)));
	end
end

function CHD_Log(str)
	print("\124c0080C0FF  "..str.."\124r");
end

function CHD_LogErr(str)
	print("\124c00FF0000"..(str or "nil").."\124r");
end

function CHD_LogWarn(str)
	print("\124c00FFFF00"..(str or "nil").."\124r");
end

function CHD_trycall(fun)
	local status, result = xpcall(fun, CHD_LogErr);

	if status then
		return result;
	end

	return nil;
end

function CHD_SlashCmdHandler(cmd)
	local cmdlist = {strsplit(" ", cmd)};

	if cmdlist[1] == "show" then
		frmMain:Show();
	else
		CHD_Message("/chardumps or /chd");
		CHD_Message("/chardumps show -- show main frame");
		CHD_Message("/chardumps -- show help");
	end
end

function CHD_OnEvent(self, event, ...) -- TODO: delete
--	print("event: ", event);
--	print("arg1: ", arg1, ", arg2: ", arg2, ", arg3: ", arg3);
	if (event == "PLAYER_ENTERING_WORLD") then
		CHD_Message(UnitName("player").." enter in word");
	elseif (event == "PLAYER_LEAVING_WORLD") then
		CHD_Message("Bay-bay "..UnitName("player"));
	end
end

function CHD_OnLoad(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("PLAYER_LEAVING_WORLD");
	self:SetScript("OnEvent", CHD_OnEvent);

	SlashCmdList["CHD"] = CHD_SlashCmdHandler;
	SLASH_CHD1 = "/chardumps";
	SLASH_CHD2 = "/chd";

	CHD_Message("chardumps created by |cff0000ffSlaFF|r is loaded");
end

--[[
	Geting data
--]]

function CHD_GetGlobalInfo()
	local res            = {};

	CHD_Message(" Get global information");
	res.locale           = GetLocale();
	res.realm            = GetRealmName();
	res.realmlist        = GetCVar("realmList");
	local _, build       = GetBuildInfo();
	res.clientbuild      = build;

	return res;
end

function CHD_GetPlayerInfo()
	local res            = {};

	CHD_Message(" Get player`s information");
	res.name             = UnitName("player");
	local _, class       = UnitClass("player");
	res.class            = class;
	res.level            = UnitLevel("player");
	local _, race        = UnitRace("player");
	res.race             = race;
	res.gender           = UnitSex("player");
	local honorableKills = GetPVPLifetimeStats()
	res.kills            = honorableKills;
	res.honor            = GetHonorCurrency();
	res.ap               = GetArenaCurrency();
	res.money            = GetMoney();
	res.specs            = GetNumTalentGroups();

	return res;
end

--[[
function CHD_GetGlyphData()
	local res = {};

	for i = 1,2 do
		res[i] = {};
		local curid = {[1] = 1,[2] = 1};
		for j = 1, GetNumGlyphSockets() do
			local _, glyphType, glyphTooltipIndex, glyphSpellID, icon = GetGlyphSocketInfo(j, i);
			if not res[i][glyphType] then
				res[i][glyphType] = {};
			end
			res[i][glyphType][ curid[glyphType] ] = glyphSpellID;
			curid[glyphType] = curid[glyphType]+1;
		end
	end

	return retTbl;
end
--]]

--[[
	Saving data
--]]

function CHD_CreateDump()
	local dump       = {};

	CHD_Message("Creating dump...");
	dump.globinfo    = CHD_trycall(CHD_GetGlobalInfo)    or {};
	dump.userinfo    = CHD_trycall(CHD_GetPlayerInfo)    or {};
	CHD_Message("Dump created successeful");

	return dump;
end

function CHD_SaveDump(data)
	CHD_Message("DONE: you can find dump here: WoW Folder /WTF/Account/%PlayerName%/SavedVariables/chardump.lua");

	CHD_DATA  = data;
	CHD_KEY   = nil;
end

function CHD_Dump()
	local res = {};

	res = CHD_CreateDump();
--	CHD_PrintTable(res.globinfo); -- debug
--	CHD_PrintTable(res.userinfo); -- debug
	CHD_SaveDump(res);
end