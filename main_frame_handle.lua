--[[

--]]
local L = LibStub('AceLocale-3.0'):GetLocale('chardumps');

function CHD_GetTaxiText()
	return L.chbTaxi .. string.format(" (%d, %d, %d, %d)",
		#CHD_TAXI[1] or 0,
		#CHD_TAXI[2] or 0,
		#CHD_TAXI[3] or 0,
		#CHD_TAXI[4] or 0);
end

function CHD_OnTaximapOpened(arg1, arg2, arg3)
	print(arg1, arg2, arg3);

	if not CHD_frmMainchbTaxi:GetChecked() then
		return false;
	end

	local res = {};
--[[
-1 - if showing the cosmic map or a Battleground map. Also when showing The Scarlet Enclave, the Death Knights' starting area.
0 - if showing the entire world of Azeroth
1 - if showing Kalimdor, or a zone map within it.
2 - if showing Eastern Kingdoms, or a zone map within it.
3 - if showing Outland, or a zone map within it.
4 - if showing Northrend, or a zone map within it.
5 - if showing the Maelstrom, or a zone map within it.
6 - if showing Pandaria, or a zone map within it.
--]]
	local continent = GetCurrentMapContinent();
	if (continent < 1) or (continent > MAX_NUM_CONTINENT) then
		return false;
	end

	local arrContinent = {L.Kalimdor, L.EasternKingdoms, L.Outland, L.Northrend};
	CHD_Message(L.GetTaxi .. arrContinent[continent]);
	for i = 1, NumTaxiNodes() do
		local name = TaxiNodeName(i);
		res[i] = name;
	end

	CHD_TAXI[continent] = res;

	CHD_frmMainchbTaxiText:SetText(CHD_GetTaxiText());

	CHD_Message(L.CountOfTaxi .. tostring(#CHD_TAXI[continent]));

	return true;
end

function CHD_OnVariablesLoaded()
	-- client
	CHD_CLIENT = {};

	-- server
	CHD_SERVER_LOCAL = {};

	if not CHD_TAXI then
		CHD_TAXI = {};
	end
	for i = 1, MAX_NUM_CONTINENT do
		if not CHD_TAXI[i] then
			CHD_TAXI[i] = {};
		end
	end
	CHD_SERVER_LOCAL.quest = {};
	CHD_SERVER_LOCAL.bank = {};
	CHD_SERVER_LOCAL.bank.mainbank = {};
	CHD_SERVER_LOCAL.skillspell = {};

	CHD_frmMainchbTaxiText:SetText(CHD_GetTaxiText());
	CHD_frmMainchbQuestsText:SetText(L.chbQuests);
	CHD_frmMainchbBankText:SetText(L.chbBank);

	if not CHD_trycall(CHD_SetOptions) then
		CHD_SetOptionsDef();
		CHD_trycall(CHD_SetOptions);
	end

	return true;
end

-- http://wowprogramming.com/docs/api_categories#tradeskill
function CHD_OnTradeSkillShow(flags, arg2) -- TODO: delte second param
	if not flags or not CHD_frmMainchbSkillSpell:GetChecked() then
		return;
	end
	if (string.find(flags, "trade")) then
		return;
	end

	-- Returns information about the current trade skill
	local tradeskillName, rank, maxLevel = GetTradeSkillLine();

	if ("UNKNOWN" == tradeskillName) then
		return;
	end

	local i = 1;
	while true do
		local _, skillType = GetTradeSkillInfo(i);
		if not skillType then
			break;
		end
		if skillType == "header" then
			ExpandTradeSkillSubClass(i);
		end
		i = i + 1;
	end

	CHD_Message(string.format(L.GetSkillSpell, tradeskillName));

	if (not CHD_SERVER_LOCAL.skillspell) then
		CHD_SERVER_LOCAL.skillspell = {};
	end
	CHD_SERVER_LOCAL.skillspell[tradeskillName] = {};
	local t = CHD_SERVER_LOCAL.skillspell[tradeskillName];

	for i = 1, GetNumTradeSkills() do
		local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(i);
		if (skillType and "header" ~= skillType) then
			local link = GetTradeSkillRecipeLink(i);
			--local itemID = tonumber(strmatch(link, "h[(%x+)]"));
			local spellID = tonumber(strmatch(link, "\124Henchant:(%d+)"));
			-- link = string.gsub(link, "\124", "_");
			table.insert(t, spellID);
		end
	end

	local count = #t;
	CHD_Message(string.format(L.TradeSkillFound, count));

	if count > 0 then
		local s = L.ttchbSkillSpell .. "\n";
		-- Update text on the Tooltip
		for k,v in pairs(CHD_SERVER_LOCAL.skillspell) do
			s = s .. "- " .. k .. " (" .. #v .. ")\n";
		end
		SetTooltip(CHD_frmMainchbSkillSpell, L.chbSkillSpell, s);
		CHD_frmMainchbSkillSpellText:SetText(CHD_GetSkillSpellText());
	end
end

function CHD_OnEvent(self, event, ...)
	if "BANKFRAME_OPENED" == event then
		if CHD_frmMainchbBank:GetChecked() then
			CHD_SERVER_LOCAL.bank = CHD_trycall(CHD_GetBankInfo) or {};
		else
			CHD_SERVER_LOCAL.bank = {};
		end
		CHD_frmMainchbBankText:SetText(L.chbBank .. string.format(" (%d, %d)", CHD_GetBankItemCount()));
	elseif "PLAYER_LEAVING_WORLD" == event then
		CHD_SaveOptions();
	elseif "TAXIMAP_OPENED" == event then
		CHD_OnTaximapOpened(arg1, arg2);
	elseif "VARIABLES_LOADED" == event then
		CHD_OnVariablesLoaded();
	elseif "TRADE_SKILL_SHOW" == event then
		CHD_OnTradeSkillShow(arg1, arg2);
	else
		print(event, arg1, arg2, arg3);
	end
end

function CHD_OnLoad(self)
	print("OnLoad");

	-- localization
	CHD_frmMainchbGlyphsText:SetText(L.chbGlyphs);
	CHD_frmMainchbCurrencyText:SetText(L.chbCurrency);
	CHD_frmMainchbSpellsText:SetText(L.chbSpells);
	CHD_frmMainchbMountsText:SetText(L.chbMounts);
	CHD_frmMainchbCrittersText:SetText(L.chbCritters);
	CHD_frmMainchbReputationText:SetText(L.chbReputation);
	CHD_frmMainchbAchievementsText:SetText(L.chbAchievements);
	CHD_frmMainchbActionsText:SetText(L.chbActions);
	CHD_frmMainchbSkillsText:SetText(L.chbSkills);
	CHD_frmMainchbSkillSpellText:SetText(L.chbSkillSpell);
	CHD_frmMainchbInventoryText:SetText(L.chbInventory);
	CHD_frmMainchbBagsText:SetText(L.chbBags);
	CHD_frmMainchbEquipmentText:SetText(L.chbEquipment);
	CHD_frmMainchbQuestlogText:SetText(L.chbQuestlog);
	CHD_frmMainchbMacroText:SetText(L.chbMacro);
	CHD_frmMainchbFriendText:SetText(L.chbFriend);
	CHD_frmMainchbArenaText:SetText(L.chbArena);
	CHD_frmMainchbQuestsText:SetText(L.chbQuests);
	CHD_frmMainchbPetText:SetText(L.chbPet);
	CHD_frmMainchbPet:Disable();

	CHD_frmMainchbBankText:SetText(L.chbBank);
	CHD_frmMainchbBindText:SetText(L.chbBind);
	CHD_frmMainchbTaxiText:SetText(L.chbTaxi);

	CHD_frmMainbtnQuestQuery:SetText(L.btnQuestQuery);
	CHD_frmMainbtnDump:SetText(L.btnDump);

	CHD_frmMainchbCryptText:SetText(L.chbCrypt);

	self:RegisterEvent("TAXIMAP_OPENED");
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("BANKFRAME_OPENED");
	self:RegisterEvent("PLAYER_LEAVING_WORLD");
	self:RegisterEvent("TRADE_SKILL_SHOW");

	SetTooltip(CHD_frmMainchbGlyphs, L.chbGlyphs, L.ttchbGlyphs);
	SetTooltip(CHD_frmMainchbCurrency, L.chbCurrency, L.ttchbCurrency);
	SetTooltip(CHD_frmMainchbSpells, L.chbSpells, L.ttchbSpells);
	SetTooltip(CHD_frmMainchbMounts, L.chbMounts, L.ttchbMounts);
	SetTooltip(CHD_frmMainchbCritters, L.chbCritters, L.ttchbCritters);
	SetTooltip(CHD_frmMainchbReputation, L.chbReputation, L.ttchbReputation);
	SetTooltip(CHD_frmMainchbAchievements, L.chbAchievements, L.ttchbAchievements);
	SetTooltip(CHD_frmMainchbActions, L. chbActions, L.ttchbActions);
	SetTooltip(CHD_frmMainchbSkills, L.chbSkills, L.ttchbSkills);
	SetTooltip(CHD_frmMainchbSkillSpell, L.chbSkillSpell, L.ttchbSkillSpell);
	SetTooltip(CHD_frmMainchbInventory, L.chbInventory, L.ttchbInventory);
	SetTooltip(CHD_frmMainchbBags, L.chbBags, L.ttchbBags);
	SetTooltip(CHD_frmMainchbEquipment, L.chbEquipment, L.ttchbEquipment);
	SetTooltip(CHD_frmMainchbQuestlog, L.chbQuestlog, L.ttchbQuestlog);
	SetTooltip(CHD_frmMainchbMacro, L.chbMacro, L.ttchbMacro);
	SetTooltip(CHD_frmMainchbFriend, L.chbFriend, L.ttchbFriend);
	SetTooltip(CHD_frmMainchbArena, L.chbArena, L.ttchbArena);
	SetTooltip(CHD_frmMainchbQuests, L.chbQuests, L.ttchbQuests);
	SetTooltip(CHD_frmMainchbPet, L.chbPet, L.ttchbPet);

	SetTooltip(CHD_frmMainchbBank, L.chbBank, L.ttchbBank);
	SetTooltip(CHD_frmMainchbBind, L.chbBind, L.ttchbBind);
	SetTooltip(CHD_frmMainchbTaxi, L.chbTaxi, L.ttchbTaxi);

	SetTooltip(CHD_frmMainchbCrypt, L.chbCrypt, L.ttchbCrypt);

	SetTooltip(CHD_frmMainbtnHide, L.ttbtnHide, "");
	SetTooltip(CHD_frmMainbtnMinimize, L.ttbtnMinimize, "");
	SetTooltip(CHD_frmMainbtnDump, L.btnDump, L.ttbtnDump);
	SetTooltip(CHD_frmMainbtnQuestQuery, L.btnQuestQuery, L.ttbtnQuestQuery);
	SetTooltip(CHD_frmMainbtnBankDel, L.chbBank, L.ttbtnBankDel);
	SetTooltip(CHD_frmMainbtnQuestDel, L.chbQuests, L.ttbtnQuestDel);
	SetTooltip(CHD_frmMainbtnTaxiDel, L.chbTaxi, L.ttbtnSkillSpellDel);
	SetTooltip(CHD_frmMainbtnSkillSpellDel, L.chbSkillSpell, L.ttbtnSkillSpellDel);

	SetTooltip(CHD_frmMainbtnCheckAll, L.Comboboxes, L.ttbtnCheckAll);
	SetTooltip(CHD_frmMainbtnCheckNone, L.Comboboxes, L.ttbtnCheckNone);
	SetTooltip(CHD_frmMainbtnCheckInv, L.Comboboxes, L.ttbtnCheckInv);

	CHD_CreateMessageBox();

	CHD_Message(L.loadmessage);
end
