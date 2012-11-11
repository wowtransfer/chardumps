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

function CHD_OnLoad(self)
	SlashCmdList["CHD"] = CHD_SlashCmdHandler;
	SLASH_CHD1 = "/chardumps";
	SLASH_CHD2 = "/chd";

	frmMainchbPlayer:Disable();
	frmMainchbGlobal:Disable();

	CHD_Message("chardumps created by |cff0000ffSlaFF|r is loaded");
end

--[[
	Geting data
--]]

function CHD_GetGlobalInfo()
	local res            = {};

	CHD_Message("  Get global information");
	res.locale           = GetLocale();
	res.realm            = GetRealmName();
	res.realmlist        = GetCVar("realmList");
	local _, build       = GetBuildInfo();
	res.clientbuild      = build;

	return res;
end

function CHD_GetPlayerInfo()
	local res            = {};

	CHD_Message("  Get player`s information");
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

function CHD_GetGlyphInfo()
	local res = {};

	CHD_Message("  Get glyphs information");
	for i = 1,2 do
		res[i] = {};
		local curid = {[1] = 1,[2] = 1};
		for j = 1, GetNumGlyphSockets() do
			local _, glyphType, glyphSpellID = GetGlyphSocketInfo(j, i);
			if not res[i][glyphType] then -- glyphType 1 or 2, smal or big glyph
				res[i][glyphType] = {};
			end
			res[i][glyphType][ curid[glyphType] ] = glyphSpellID;
			curid[glyphType] = curid[glyphType] + 1;
		end
	end

	return res;
end

function CHD_GetCurrencyInfo()
	local res = {};

	CHD_Message("  Get currency information");
	for i = 1, GetCurrencyListSize() do
		local _, _, _, _, _, count, _, _, itemID = GetCurrencyListInfo(i);
		res[itemID] = count;
	end

	return res;
end

function CHD_GetSpellInfo()
	local res = {};

	CHD_Message("  Get spell information");
	for i = 1, MAX_SKILLLINE_TABS do
		local name, _, offset, numSpells = GetSpellTabInfo(i);
		if not name then
			break;
		end
		for j = offset + 1, offset + numSpells do
			local spellLink = GetSpellLink(j, BOOKTYPE_SPELL);
			if spellLink then
				local spellid = tonumber(strmatch(spellLink, "Hspell:(%d+)"));
				res[spellid] = i;
			end
		end
	end

	return res;
end

function CHD_GetMountInfo()
	local res = {};

	CHD_Message("  Get mounts information");
	for i = 1, GetNumCompanions("MOUNT") do
		local creatureID = GetCompanionInfo("MOUNT", i);
		res[i] = creatureID;
	end

	return res;
end

function CHD_GetCritterInfo()
	local res = {};

	CHD_Message("  Get critters information");
	for i = 1, GetNumCompanions("CRITTER") do
		local creatureID = GetCompanionInfo("CRITTER", i);
		res[i] = creatureID;
	end

	return res;
end

function CHD_GetRepInfo()
	local res = {};

	CHD_Message("  Get reputation information");
	for i = 1, GetNumFactions() do
	local name, _, _, _, _, earnedValue, _, canToggleAtWar, _, _, _, _, _ = GetFactionInfo(i);
		res[i] = {["N"] = name, ["V"] = earnedValue, ["F"] = (canToggleAtWar or 0)};
	end

	return res;
end

function CHD_GetAchievementInfo()
	local res = {};

	CHD_Message("  Get achievement information");
	local CategoryList = GetCategoryList();
	for _, CategoryID in pairs(CategoryList) do
		for j = 1, GetCategoryNumAchievements(CategoryID) do
			IDNumber, _, _, Completed, Month, Day, Year = GetAchievementInfo(CategoryID, j);
			if IDNumber and Completed then
				local posixtime = time{year = 2000 + Year, month = Month, day = Day};
				if posixtime then
					res[IDNumber] = posixtime;
				end
			end
		end
	end

	return res;
end

function CHD_GetSkillInfo()
	local res = {};

	CHD_Message("  Get skill information");
	for i = 1, GetNumSkillLines() do
		local skillName, _, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i);
		res[i] = {["N"] = skillName, ["R"] = skillRank, ["M"] = skillMaxRank};
	end

	return res;
end

function CHD_GetInventoryInfo()
	local res = {};
	local arrSlotName = {"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot",
		"ShirtSlot", "TabardSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot",
		"FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
		"MainHandSlot", "SecondaryHandSlot", "RangedSlot", "AmmoSlot", "Bag0Slot",
		"Bag1Slot", "Bag2Slot", "Bag3Slot"};
	local lenSlotName = #arrSlotName; -- 24

	CHD_Message("  Get inventory information");
	for i = 1, lenSlotName do
		local slotId = GetInventorySlotInfo(arrSlotName[i]);
		local itemLink = GetInventoryItemLink("player", slotId);
		if itemLink then
			local count = GetInventoryItemCount("player", slotId);
--			if (count == 1) and (not GetInventoryItemTexture("player", slotId)) then
--				count = 0; -- for bag returns zero?
--			end
			local itemID = tonumber(strmatch(itemLink, "Hitem:(%d+)"));
			res[i] = {["I"] = itemID, ["N"] = count};
		end
	end

	return res;
end

function CHD_GetBagInfo()
	local res = {};
	CHD_Message("  Get bag`s information");
	--  0 for the backpack
	-- -2 for the keyring KEYRING_CONTAINER
	-- -4 for the tokens bag
	local arrBag = {KEYRING_CONTAINER};

	for i = 0, NUM_BAG_SLOTS do
		tinsert(arrBag, i);
	end
	i = 0;
	for k, bag in pairs(arrBag) do
		local nCount = 0;
		for slot = 1, GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot)
			if itemLink then
				_, itemCount = GetContainerItemInfo(bag, slot);
				local itemID = tonumber(strmatch(itemLink, "Hitem:(%d+)"));
				res[i*100 + slot] = {["I"] = itemID, ["N"] = itemCount};
				nCount = nCount + 1;
			end
		end
		CHD_Message("    scaning of bag: "..bag..", items: "..nCount);
	end

	return res;
end

function CHD_GetBankInfo()
	local res = {};
	-- BANK_CONTAINER is the bank window
	-- NUM_BAG_SLOTS+1 to NUM_BAG_SLOTS+NUM_BANKBAGSLOTS are your bank bags
	local arrBag = {BANK_CONTAINER};

	CHD_Message("  Get bank`s information");
	for i = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		tinsert(arrBag, i);
	end
	i = 0;
	for k, bag in pairs(arrBag) do
		local nCount = 0;
		for slot = 1, GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot)
			if itemLink then
				_, itemCount = GetContainerItemInfo(bag, slot);
				local itemID = tonumber(strmatch(itemLink, "Hitem:(%d+)"));
				res[i*100 + slot] = {["I"] = itemID, ["N"] = itemCount};
				nCount = nCount + 1;
			end
		end
		CHD_Message("    scaning of bank`s bag: "..bag..", items: "..nCount);
	end

	return res;
end

--[[
	Saving data
--]]

function CHD_Debug()

end

function CHD_CreateDump()
	local dump = {};

	CHD_Message("Creating dump...");
	dump.global      = CHD_trycall(CHD_GetGlobalInfo)      or {};
	dump.player      = CHD_trycall(CHD_GetPlayerInfo)      or {};
	if frmMainchbGlyphs:GetChecked() then
		dump.glyph         = CHD_trycall(CHD_GetGlyphInfo)       or {};
	end
	if frmMainchbCurrency:GetChecked() then
		dump.currency      = CHD_trycall(CHD_GetCurrencyInfo)    or {};
	end
	if frmMainchbSpells:GetChecked() then
		dump.spell         = CHD_trycall(CHD_GetSpellInfo)       or {};
	end
	if frmMainchbMounts:GetChecked() then
		dump.mount         = CHD_trycall(CHD_GetMountInfo)       or {};
	end
	if frmMainchbCritters:GetChecked() then
		dump.critter       = CHD_trycall(CHD_GetCritterInfo)     or {};
	end
	if frmMainchbReputation:GetChecked() then
		dump.reputation    = CHD_trycall(CHD_GetRepInfo)         or {};
	end;
	if frmMainchbAchievements:GetChecked() then
		dump.achievement   = CHD_trycall(CHD_GetAchievementInfo) or {};
	end
	if frmMainchbSkills:GetChecked() then
		dump.skill         = CHD_trycall(CHD_GetSkillInfo)       or {};
	end
	if frmMainchbInventory:GetChecked() then
		dump.inventory     = CHD_trycall(CHD_GetInventoryInfo)   or {};
	end
	if frmMainchbBag:GetChecked() then
		dump.bag           = CHD_trycall(CHD_GetBagInfo)         or {};
	end
	if frmMainchbBank:GetChecked() then
		dump.bank          = CHD_trycall(CHD_GetBankInfo)        or {};
	end

	CHD_Message("Dump create successeful");
	CHD_Message("DONE: you can find dump here: WoW Folder /WTF/Account/%PlayerName%/SavedVariables/chardumps.lua");

	CHD_DATA  = dump;
	CHD_KEY   = nil;
end


function CHD_Dump()
	CHD_CreateDump();
end