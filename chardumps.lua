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
local L = LibStub('AceLocale-3.0'):GetLocale('chardumps');

CHD = {};
CHD_CLIENT = CHD_CLIENT or {};
CHD_SERVER = CHD_SERVER or {};
CHD_SERVER.taxi = CHD_SERVER.taxi or {};

local MAX_NUM_CONTINENT = 4 -- 1..4

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

function CHD_GetTableCount(t)
	local size = 0;

	if type(t) ~= "table" then
		return 0;
	end

	for _, _ in pairs(t) do
		size = size + 1
	end

	return size;
end

function CHD_SlashCmdHandler(cmd)
	local cmdlist = {strsplit(" ", cmd)};

	if cmdlist[1] == "show" then
		frmMainpanSystem:SetBackdrop(nil);
		frmMainpanSystem:SetParent(frmMain);
		frmMainpanSystem:Show();
		frmMain:Show();
	else
		CHD_Message(L.help1);
		CHD_Message(L.help2);
		CHD_Message(L.help3);
	end
end

function CHD_OnVariablesLoaded()
	-- client
	if CHD_CLIENT.glyph then
		frmMainchbGlyphsText:SetText(L.chbGlyphs .. string.format(" (%d)",
			CHD_GetTableCount(CHD_CLIENT.glyph)));
	end
	if CHD_CLIENT.currency then
		frmMainchbCurrencyText:SetText(L.chbCurrency .. string.format(" (%d)",
			CHD_GetTableCount(CHD_CLIENT.currency)));
	end
	if CHD_CLIENT.spell then
		frmMainchbSpellsText:SetText(L.chbSpells .. string.format(" (%d)",
			CHD_GetTableCount(CHD_CLIENT.spell)));
	end
	if CHD_CLIENT.mount then
		frmMainchbMountsText:SetText(L.chbMounts .. string.format(" (%d)", #CHD_CLIENT.mount))
	end
	if CHD_CLIENT.critter then
		frmMainchbCrittersText:SetText(L.chbCritters .. string.format(" (%d)", #CHD_CLIENT.critter))
	end
	if CHD_CLIENT.reputation then
		frmMainchbReputationText:SetText(L.chbReputation .. string.format(" (%d)",
			CHD_GetTableCount(CHD_CLIENT.reputation)));
	end
	if CHD_CLIENT.achievement then
		frmMainchbAchievementsText:SetText(L.chbAchievements .. string.format(" (%d)",
			#CHD_CLIENT.achievement));
	end
	if CHD_CLIENT.skill then
		frmMainchbSkillsText:SetText(L.chbSkills .. string.format(" (%d)",
			CHD_GetTableCount(CHD_CLIENT.skill)));
	end
	if CHD_CLIENT.bag then
		frmMainchbBagsText:SetText(L.chbBags .. string.format(" (%d)",
			CHD_GetTableCount(CHD_CLIENT.bag)));
	end
	if CHD_CLIENT.inventory then
		frmMainchbInventoryText:SetText(L.chbInventory .. string.format(" (%d)",
			CHD_GetTableCount(CHD_CLIENT.inventory)));
	end
	if CHD_CLIENT.equipment then
		frmMainchbEquipmentText:SetText(L.chbEquipment .. string.format(" (%d)",
			#CHD_CLIENT.equipment));
	end
	if CHD_CLIENT.questlog then
		frmMainchbQuestlogText:SetText(L.chbQuestlog .. string.format(" (%d)",
			#CHD_CLIENT.questlog));
	end
	local n = 0;
	if CHD_CLIENT.pmacro then
		n = #CHD_CLIENT.pmacro;
	end
	if CHD_CLIENT.amacro then
		n = n + #CHD_CLIENT.amacro;
	end
	frmMainchbMacroText:SetText(L.chbMacro .. string.format(" (%d)", n));

	local m = 0;
	if CHD_CLIENT.friend then
		n = #CHD_CLIENT.friend;
	end
	if CHD_CLIENT.ignore then
		m = #CHD_CLIENT.ignore;
	end
	frmMainchbFriendText:SetText(L.chbFriend .. string.format(" (%d, %d)", n, m));

	if CHD_CLIENT.arena then
		frmMainchbArenaText:SetText(L.chbArena .. string.format(" (%d)", #CHD_CLIENT.arena));
	end

	-- server
	if CHD_SERVER.taxi then
		for i = 1, MAX_NUM_CONTINENT do
			if not CHD_SERVER.taxi[i] then
				CHD_SERVER.taxi[i] = {};
			end
		end
		frmMainchbTaxiText:SetText(L.chbTaxi .. string.format(" (%d, %d, %d, %d)",
			#CHD_SERVER.taxi[1],
			#CHD_SERVER.taxi[2],
			#CHD_SERVER.taxi[3],
			#CHD_SERVER.taxi[4])
		);
	end
	if CHD_SERVER.quest then
		frmMainchbQuestsText:SetText(L.chbQuests .. string.format(" (%d)", #CHD_SERVER.quest));
	end
	if CHD_SERVER.bank then
		frmMainchbBankText:SetText(L.chbBank .. string.format(" (%d)",
			CHD_GetTableCount(CHD_SERVER.bank)));
	end
end

function CHD_OnEvent(self, event, ...)
	if "TAXIMAP_OPENED" == event then
		if frmMainchbTaxi:GetChecked() then
			CHD_SetTaxiInfo();
		end
	elseif "VARIABLES_LOADED" == event then
		CHD_OnVariablesLoaded();
	elseif "BANKFRAME_OPENED" == event then
		if frmMainchbBank:GetChecked() then
			CHD_SERVER.bank = CHD_trycall(CHD_GetBankInfo) or {};
		else
			CHD_SERVER.bank = {};
		end
		frmMainchbBankText:SetText(L.chbBank .. string.format(" (%d)",
			CHD_GetTableCount(CHD_SERVER.bank)));
	end
end

function CHD_CreateMessageBox()
	local theFrame = CreateFrame("Frame", nil, UIParent);

	theFrame:ClearAllPoints();
	theFrame:SetPoint("CENTER", UIParent);
	theFrame:SetHeight(78);
	theFrame:SetWidth(200);

	theFrame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\AddOns\\Recount\\textures\\otravi-semi-full-border", edgeSize = 32,
		insets = {left = 1, right = 1, top = 20, bottom = 1},
	});
	theFrame:SetBackdropBorderColor(1.0, 0.0, 0.0);
	theFrame:SetBackdropColor(24/255, 24/255, 24/255);

	theFrame:EnableMouse(true)
	theFrame:SetMovable(true)

	theFrame:SetScript("OnMouseDown", function(this)
		if ( ( ( not this.isLocked ) or ( this.isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then
			this:StartMoving();
			this.isMoving = true;
		end
	end);
	theFrame:SetScript("OnMouseUp", function(this)
		if ( this.isMoving ) then
			this:StopMovingOrSizing();
			this.isMoving = false;
		end
	end);
	theFrame:SetScript("OnHide", function(this)
		if ( this.isMoving ) then
			this:StopMovingOrSizing();
			this.isMoving = false;
		end
	end);

	theFrame.Title = theFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	theFrame.Title:SetPoint("TOPLEFT", theFrame, "TOPLEFT", 6, -15);
	theFrame.Title:SetTextColor(1.0,1.0,1.0,1.0);
	theFrame.Title:SetText("null");

	theFrame.Text = theFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	theFrame.Text:SetPoint("CENTER",theFrame,"CENTER",0,-3);
	theFrame.Text:SetTextColor(1.0,1.0,1.0);
	theFrame.Text:SetText(L.areyousure);

	theFrame.YesButton = CreateFrame("Button", nil, theFrame, "OptionsButtonTemplate");
	theFrame.YesButton:SetWidth(90);
	theFrame.YesButton:SetHeight(24);
	theFrame.YesButton:SetPoint("BOTTOMRIGHT", theFrame, "BOTTOM", -4, 4);
	theFrame.YesButton:SetScript("OnClick", function()
		if theFrame.OnOK then
			theFrame:OnOK();
		end
		theFrame:Hide();
	end);
	theFrame.YesButton:SetText(L.Yes);

	theFrame.NoButton = CreateFrame("Button", nil, theFrame, "OptionsButtonTemplate");
	theFrame.NoButton:SetWidth(90);
	theFrame.NoButton:SetHeight(24);
	theFrame.NoButton:SetPoint("BOTTOMLEFT", theFrame, "BOTTOM", 4, 4);
	theFrame.NoButton:SetScript("OnClick", function() theFrame:Hide() end);
	theFrame.NoButton:SetText(L.No);

	theFrame:Hide();

	CHD.MessageBox = theFrame;
end

function AddTooltip(theFrame, Title, TooltipText)
	theFrame.title = Title;
	theFrame.tooltiptext = TooltipText;
	theFrame:SetScript("OnEnter", function()
				GameTooltip:SetOwner(theFrame, "ANCHOR_TOPLEFT");
				GameTooltip:ClearLines();
				GameTooltip:SetText(theFrame.title);
				GameTooltip:AddLine(theFrame.tooltiptext, 1, 1, 1, true);
				GameTooltip:Show();
			end);
	theFrame:SetScript("OnLeave", function() GameTooltip:Hide() end);
end

function CHD_GetBackdrop()
	local backdrop = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {
			left = 5,
			right = 5,
			top = 5,
			bottom = 5
		}
	}

	return backdrop;
end

function CHD_OnLoad(self)
	SlashCmdList["CHD"] = CHD_SlashCmdHandler;
	SLASH_CHD1 = "/chardumps";
	SLASH_CHD2 = "/chd";

	-- localization
	frmMainchbGlyphsText:SetText(L.chbGlyphs);
	frmMainchbCurrencyText:SetText(L.chbCurrency);
	frmMainchbSpellsText:SetText(L.chbSpells);
	frmMainchbMountsText:SetText(L.chbMounts);
	frmMainchbCrittersText:SetText(L.chbCritters);
	frmMainchbReputationText:SetText(L.chbReputation);
	frmMainchbAchievementsText:SetText(L.chbAchievements);
	frmMainchbSkillsText:SetText(L.chbSkills);
	frmMainchbInventoryText:SetText(L.chbInventory);
	frmMainchbBagsText:SetText(L.chbBags);
	frmMainchbEquipmentText:SetText(L.chbEquipment);
	frmMainchbQuestlogText:SetText(L.chbEquipment);
	frmMainchbMacroText:SetText(L.chbMacro);
	frmMainchbFriendText:SetText(L.chbFriend);
	frmMainchbArenaText:SetText(L.chbArena);

	frmMainchbBankText:SetText(L.chbBank);
	frmMainchbQuestsText:SetText(L.chbQuests);
	frmMainbtnQuestQueryText:SetText(L.btnServerQuery);
	frmMainchbTaxiText:SetText(L.chbTaxi);

	frmMainbtnClientDumpText:SetText(L.btnClientDump);

	self:SetScript("OnEvent", CHD_OnEvent);
	self:RegisterEvent("TAXIMAP_OPENED");
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("BANKFRAME_OPENED");

	frmMain:SetBackdrop(CHD_GetBackdrop());

	local btnW = frmMainbtnHide:GetWidth();
	frmMainbtnHide:SetParent(frmMainpanSystem);
	frmMainbtnHide:ClearAllPoints();
	frmMainbtnHide:SetPoint("CENTER", frmMainpanSystem, 0, 0);
	frmMainbtnHide:SetPoint("RIGHT", frmMainpanSystem, -11, 0);
	frmMainbtnMinimize:SetParent(frmMainpanSystem);
	frmMainbtnMinimize:ClearAllPoints();
	frmMainbtnMinimize:SetPoint("CENTER", frmMainpanSystem, 0, 0);
	frmMainbtnMinimize:SetPoint("RIGHT", frmMainpanSystem, -14 - btnW, 0);

	frmMainpanSystem:ClearAllPoints();
	frmMainpanSystem:SetPoint("TOPRIGHT", frmMain);
	frmMainpanSystem:SetPoint("TOPRIGHT", 0, 0);
	frmMainpanSystem:SetWidth(5 + 5 + btnW*2 + 3*3 + 5);

	AddTooltip(frmMainchbGlyphs, L.chbGlyphs, L.ttchbGlyphs);
	AddTooltip(frmMainchbCurrency, L.chbCurrency, L.ttchbCurrency);
	AddTooltip(frmMainchbSpells, L.chbSpells, L.ttchbSpells);
	AddTooltip(frmMainchbMounts, L.chbMounts, L.ttchbMounts);
	AddTooltip(frmMainchbCritters, L.chbCritters, L.ttchbCritters);
	AddTooltip(frmMainchbReputation, L.chbReputation, L.ttchbReputation);
	AddTooltip(frmMainchbAchievements, L.chbAchievements, L.ttchbAchievements);
	AddTooltip(frmMainchbSkills, L.chbSkills, L.ttchbSkills);
	AddTooltip(frmMainchbInventory, L.chbInventory, L.ttchbInventory);
	AddTooltip(frmMainchbBags, L.chbBags, L.ttchbBags);
	AddTooltip(frmMainchbEquipment, L.chbEquipment, L.ttchbEquipment);
	AddTooltip(frmMainchbQuestlog, L.chbQuestlog, L.ttchbQuestlog);
	AddTooltip(frmMainchbMacro, L.chbMacro, L.ttchbMacro);
	AddTooltip(frmMainchbFriend, L.chbFriend, L.ttchbFriend);
	AddTooltip(frmMainchbArena, L.chbArena, L.ttchbArena);

	AddTooltip(frmMainchbBank, L.chbBank, L.ttchbBank);
	AddTooltip(frmMainchbQuests, L.chbQuests, L.ttchbQuests);
	AddTooltip(frmMainchbTaxi, L.chbTaxi, L.ttchbTaxi);

	AddTooltip(frmMainbtnHide, L.ttbtnHide, "");
	AddTooltip(frmMainbtnMinimize, L.ttbtnMinimize, "");
	AddTooltip(frmMainbtnClientDump, L.btnClientDump, L.ttbtnClientDump);
	AddTooltip(frmMainbtnQuestQuery, L.btnServerQuery, L.ttbtnServerQuery);
	AddTooltip(frmMainbtnBankDel, L.chbBank, L.ttbtnBankDel);
	AddTooltip(frmMainbtnQuestDel, L.chbQuests, L.ttbtnQuestDel);
	AddTooltip(frmMainbtnTaxiDel, L.chbTaxi, L.ttbtnTaxiDel);

	CHD_CreateMessageBox();

	CHD_Message(L.loadmessage);
end

function OnfrmMainbtnMinimizeClLick()
	if frmMain:IsVisible() then
		frmMainpanSystem:SetBackdrop(CHD_GetBackdrop());
		frmMainpanSystem:SetParent("UIParent");
		frmMain:Hide();
	else
		frmMainpanSystem:SetBackdrop(nil);
		frmMainpanSystem:SetParent(frmMain);
		frmMain:Show();
	end
end

function OnfrmMainbtnHideClLick()
	if frmMainpanSystem:IsVisible() then
		frmMainpanSystem:Hide();
	end
	frmMain:Hide();
end

function CHD_BankDel()
	CHD_SERVER.bank = nil;
	frmMainchbBankText:SetText(L.chbBank);
end;

function OnfrmMainbtnBankDelCLick()
	CHD.MessageBox.Title:SetText(L.DeleteBank);
	CHD.MessageBox.OnOK = CHD_BankDel;
	CHD.MessageBox:Show();
end

function CHD_QuestDel()
	CHD_SERVER.quest = nil;
	frmMainchbQuestsText:SetText(L.chbQuests);
end;

function OnfrmMainbtnQuestDelCLick()
	CHD.MessageBox.Title:SetText(L.DeleteQuests);
	CHD.MessageBox.OnOK = CHD_QuestDel;
	CHD.MessageBox:Show();
end

function CHD_TaxiDel()
	CHD_SERVER.taxi = nil;
	frmMainchbTaxiText:SetText(L.chbTaxi);
end;

function OnfrmMainbtnTaxiDelCLick()
	CHD.MessageBox.Title:SetText(L.DeleteTaxi);
	CHD.MessageBox.OnOK = CHD_TaxiDel;
	CHD.MessageBox:Show();
end

function CHD_OnRecieveQuestsClick()
	QueryQuestsCompleted();
	if frmMainchbQuests:GetChecked() then
		CHD_SERVER.quest       = CHD_trycall(CHD_GetQuestInfo)       or {};
		frmMainchbQuestsText:SetText(L.chbQuests .. string.format(" (%d)",
			CHD_GetTableCount(CHD_SERVER.quest)));
	else
		CHD_SERVER.quest = {};
		frmMainchbQuestsText:SetText(L.chbQuests .. " (0)");
	end
end;

--[[
	Get client data
--]]

function CHD_GetGlobalInfo()
	local res            = {};

	CHD_Message(L.GetGlobal);
	res.locale           = GetLocale();
	res.realm            = GetRealmName();
	res.realmlist        = GetCVar("realmList");
	local _, build       = GetBuildInfo();
	res.clientbuild      = build;

	return res;
end

function CHD_GetPlayerInfo()
	local res            = {};

	CHD_Message(L.GetPlayer);
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

	CHD_Message(L.GetPlyph);
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

	CHD_Message(L.GetCurrency);
	for i = 1, GetCurrencyListSize() do
		local _, _, _, _, _, count, _, _, itemID = GetCurrencyListInfo(i);
		res[itemID] = count;
	end

	return res;
end

function CHD_GetSpellInfo()
	local res = {};

	CHD_Message(L.GetSpell);
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

	CHD_Message();
	for i = 1, GetNumCompanions("MOUNT") do
		local _, _, spellID = GetCompanionInfo("MOUNT", i);
		res[i] = spellID;
	end
	sort(res);

	return res;
end

function CHD_GetCritterInfo()
	local res = {};

	CHD_Message(L.GetCritter);
	for i = 1, GetNumCompanions("CRITTER") do
		local _, _, spellID = GetCompanionInfo("CRITTER", i);
		res[i] = spellID;
	end
	sort(res);

	return res;
end

function CHD_GetRepInfo()
	local res = {};

	CHD_Message(L.GetReputation);
	for i = 1, 1200 do -- maximum 1160 for 3.3.5a
		local _, _, _, _, _, barValue = GetFactionInfoByID(i);
		if barValue and barValue ~= 0 then
			res[i] = barValue;
		end
	end

	return res;
end

function CHD_GetAchievementInfo()
	local res = {};

	CHD_Message(L.GetAchievement);

	local count = 0;
	for i = 1, 5000 do
		local IDNumber, _, _, Completed, Month, Day, Year = GetAchievementInfo(i);
		if IDNumber and Completed then
			local posixtime = time{year = 2000 + Year, month = Month, day = Day};
			if posixtime then
				count = count + 1;
				res[count] = {["I"] = IDNumber, ["T"] = posixtime};
			end
		end
	end

	return res;
end

function CHD_GetCriteriaCompleted()
	local res = {};

	for i = 1, 5000 do
		local _, _, _, Completed = GetAchievementInfo(i);
		if Completed then
			for j = 1, GetAchievementNumCriteria(i) do
				local _, _, completed, quantity, _, _, _, _, _, criteriaID = GetAchievementCriteriaInfo(i, j);
				if quantity and quantity > 0 then
					res[criteriaID] = quantity;
				end
			end
		end
	end

	return res;
end

function CHD_GetCriteriaProgress()
	local res = {};

	local count = 0;
	for i = 1, 5000 do
		local id, _, _, Completed = GetAchievementInfo(i);
		if id and not Completed then
			for j = 1, GetAchievementNumCriteria(i) do
				local _, _, completed, quantity, _, _, _, _, _, criteriaID = GetAchievementCriteriaInfo(i, j);
				if quantity and quantity > 0 then
					res[criteriaID] = quantity;
				end
			end
		end
	end

	return res;
end

function CHD_GetSkillInfo()
	local res = {};

	CHD_Message(L.GetSkill);
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

	CHD_Message(L.GetInventory);
	for i = 1, lenSlotName do
		local slotId = GetInventorySlotInfo(arrSlotName[i]);
		local itemLink = GetInventoryItemLink("player", slotId);
		if itemLink then
			local count = GetInventoryItemCount("player", slotId);
			local gem1, gem2, gem3 = GetInventoryItemGems(slotId);
			local itemID = tonumber(strmatch(itemLink, "Hitem:(%d+)"));
			res[i] = {["I"] = itemID, ["N"] = count, ["G1"] = gem1, ["G2"] = gem2, ["G3"] = gem3};
		end
	end

	return res;
end

function CHD_GetBagInfo()
	local res = {};

	CHD_Message(L.GetBag);
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
			local itemLink = GetContainerItemLink(bag, slot);
			local gem1, gem2, gem3 = GetContainerItemGems(bag, slot);
			if itemLink then
				_, itemCount = GetContainerItemInfo(bag, slot);
				local itemID = tonumber(strmatch(itemLink, "Hitem:(%d+)"));
				res[i*100 + slot] = {["I"] = itemID, ["N"] = itemCount, ["G1"] = gem1, ["G2"] = gem2, ["G3"] = gem3};
				nCount = nCount + 1;
			end
		end
		i = i + 1;
		CHD_Message(string.format(L.ScaningBagTotal, bag, nCount));
	end

	return res;
end

function CHD_GetEquipmentInfo()
	local res = {};

	CHD_Message(L.GetEquipment);
	for i = 1, GetNumEquipmentSets() do
		local name = GetEquipmentSetInfo(i);
		if name then
			res[i] = GetEquipmentSetItemIDs(name); -- return table 1..19
		end
	end

	return res;
end

function CHD_GetQuestlogInfo()
	local res = {};
	local numEntries, numQuests = GetNumQuestLogEntries();

	CHD_Message(L.GetQuestlog);
	j = 1;
	for i = 1, numEntries do
		local _, _, _, _, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(i);
		local link, _, charges = GetQuestLogSpecialItemInfo(i);
	-- - 1 - The quest was failed
	--   1 - The quest was completed
	-- nil - The quest has yet to reach a conclusion
		-- questID, isComplete, itemID
		if isHeader == nil then
			if isComplete ~= 1 then
				isComplete = 0;
			end
			local itemID = 0;
			if link then
				itemID = tonumber(strmatch(link, "Hitem:(%d+)"));
			end
			res[j] = {["Q"] = questID, ["B"] = isComplete, ["I"] = itemID};
			j = j + 1;
		end
	end

	return res;
end

function CHD_GetPMacroInfo()
	local res = {};

	CHD_Message(L.GetMacro);
	local count = 1;
	local _, numCharacterMacros = GetNumMacros();
	for i = 36 + 1, 36 + numCharacterMacros do
		local name, texture, body = GetMacroInfo(i);
		res[count] = {["N"] = name, ["T"] = texture, ["B"] = body};
		count = count + 1;
	end

	return res;
end

function CHD_GetAMacroInfo()
	local res = {};

	local count = 1;
	local numAccountMacros = GetNumMacros();
	for i = 1, numAccountMacros do
		local name, texture, body = GetMacroInfo(i);
		res[count] = {["N"] = name, ["T"] = texture, ["B"] = body};
		count = count + 1;
	end

	return res;
end

function CHD_GetFriendsInfo()
	local res = {};

	CHD_Message(L.GetFriends);
	for i = 1, GetNumFriends() do
		local name =  GetFriendInfo(i);
		res[i] = name;
	end;

	return res;
end

function CHD_GetIgnoresInfo()
	local res = {};

	CHD_Message(L.GetIgnores);
	for i = 1, GetNumIgnores() do
		local name = GetIgnoreName(i);
		res[i] = name;
	end;

	return res;
end

function CHD_GetArenaInfo()
	local res = {};

	CHD_Message(L.GetArena);
	for i = 1, 3 do
		local teamName, teamSize, teamRating, _, _, seasonTeamPlayed, seasonTeamWins, _, seasonPlayerPlayed, _, playerRating, bg_red, bg_green, bg_blue, emblem, emblem_red, emblem_green, emblem_blue, border, border_red, border_green, border_blue = GetArenaTeam(i);
		print(teamName, teamSize, teamRating);
		if teamName then
			local arena = {};
			arena.teamSize           = teamSize;
			arena.teamName           = teamName;
			arena.teamRating         = teamRating;
			arena.seasonTeamPlayed   = seasonTeamPlayed;
			arena.seasonTeamWins     = seasonTeamWins;
			arena.seasonPlayerPlayed = seasonPlayerPlayed;
			arena.playerRating       = playerRating;
			arena.bg = {["R"] = bg_red, ["G"] = bg_green, ["B"] = bg_blue};
			arena.emblem = {["S"] = emblem, ["R"] = emblem_red, ["G"] = emblem_green, ["B"] = emblem_blue};
			arena.border = {["S"] = border, ["R"] = border_red, ["G"] = border_green, ["B"] = border_blue};
			res[i] = arena;
		end
	end

	return res;
end

-- Get server data

function CHD_GetQuestInfo()
	local res = {};

	CHD_Message(L.GetQuest);

	local questTable = GetQuestsCompleted(nil);
	local count = 1;
	-- k - quest`s ID
	-- v - always true
	for k, v in pairs(questTable) do
		res[count] = k;
		count = count + 1;
	end
	sort(res);
	CHD_Message(L.CountOfCompletedQuests .. string.format(" (%d)", count - 1));

	return res;
end

function CHD_SetTaxiInfo(continent)
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

	CHD_SERVER.taxi[continent] = res;

	frmMainchbTaxiText:SetText(L.chbTaxi .. string.format(" (%d, %d, %d, %d)",
		(#CHD_SERVER.taxi[1] or 0),
		(#CHD_SERVER.taxi[2] or 0),
		(#CHD_SERVER.taxi[3] or 0),
		(#CHD_SERVER.taxi[4] or 0))
	);

	CHD_Message(L.CountOfTaxi .. tostring(#CHD_SERVER.taxi[continent]));

	return true;
end

function CHD_GetBankInfo()
	local res = {};
	-- BANK_CONTAINER is the bank window
	-- NUM_BAG_SLOTS+1 to NUM_BAG_SLOTS+NUM_BANKBAGSLOTS are your bank bags
	local arrBag = {BANK_CONTAINER};

	CHD_Message(L.GetBank);
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
		i = i + 1;
		CHD_Message(string.format(L.ScaningBankTotal, bag, nCount));
	end

	return res;
end

--[[
	Saving data
--]]

function CHD_Debug()

end

function CHD_OnClientDumpClick()
	local dump = {};

	CHD_Message(L.CreatingDump);
	dump.global      = CHD_trycall(CHD_GetGlobalInfo)      or {};
	dump.player      = CHD_trycall(CHD_GetPlayerInfo)      or {};
	if frmMainchbGlyphs:GetChecked() then
		dump.glyph         = CHD_trycall(CHD_GetGlyphInfo)       or {};
	else
		dump.glyph = {};
	end
	frmMainchbGlyphsText:SetText(L.chbGlyphs .. string.format(" (%d)",
		CHD_GetTableCount(dump.glyph)));
	if frmMainchbCurrency:GetChecked() then
		dump.currency      = CHD_trycall(CHD_GetCurrencyInfo)    or {};
	else
		dump.currency = {};
	end
	frmMainchbCurrencyText:SetText(L.chbCurrency .. string.format(" (%d)",
		CHD_GetTableCount(dump.currency)));
	if frmMainchbSpells:GetChecked() then
		dump.spell         = CHD_trycall(CHD_GetSpellInfo)       or {};
	else
		dump.spell = {};
	end
	frmMainchbSpellsText:SetText(L.chbSpells .. string.format(" (%d)",
		CHD_GetTableCount(dump.spell)));
	if frmMainchbMounts:GetChecked() then
		dump.mount         = CHD_trycall(CHD_GetMountInfo)       or {};
	else
		dump.mount = {};
	end
	frmMainchbMountsText:SetText(L.chbMounts .. string.format(" (%d)", #dump.mount))
	if frmMainchbCritters:GetChecked() then
		dump.critter       = CHD_trycall(CHD_GetCritterInfo)     or {};
	else
		dump.critter = {};
	end
	frmMainchbCrittersText:SetText(L.chbCritters .. string.format(" (%d)", #dump.critter));

	if frmMainchbReputation:GetChecked() then
		dump.reputation    = CHD_trycall(CHD_GetRepInfo)         or {};
	else
		dump.reputation = {};
	end;
	frmMainchbReputationText:SetText(L.chbReputation .. string.format(" (%d)",
		CHD_GetTableCount(dump.reputation)));

	if frmMainchbAchievements:GetChecked() then
		dump.achievement   = CHD_trycall(CHD_GetAchievementInfo)   or {};
		dump.criteria1     = CHD_trycall(CHD_GetCriteriaCompleted) or {};
		dump.criteria0     = CHD_trycall(CHD_GetCriteriaProgress)  or {};
	else
		dump.achievement = {};
		dump.criteria1 = {};
		dump.criteria0 = {};
	end
	frmMainchbAchievementsText:SetText(L.chbAchievements .. string.format(" (%d)",
		#dump.achievement));

	if frmMainchbSkills:GetChecked() then
		dump.skill         = CHD_trycall(CHD_GetSkillInfo)       or {};
	else
		dump.skill = {};
	end
	frmMainchbSkillsText:SetText(L.chbSkills .. string.format(" (%d)",
		CHD_GetTableCount(dump.skill)));
	if frmMainchbInventory:GetChecked() then
		dump.inventory     = CHD_trycall(CHD_GetInventoryInfo)   or {};
	else
		dump.inventory = {};
	end
	frmMainchbInventoryText:SetText(L.chbInventory .. string.format(" (%d)",
		CHD_GetTableCount(dump.inventory)));
	if frmMainchbBags:GetChecked() then
		dump.bag           = CHD_trycall(CHD_GetBagInfo)         or {};
	else
		dump.bag = {};
	end
	frmMainchbBagsText:SetText(L.chbBags .. string.format(" (%d)",
		CHD_GetTableCount(dump.bag)));
	if frmMainchbEquipment:GetChecked() then
		dump.equipment = CHD_trycall(CHD_GetEquipmentInfo) or {};
	else
		dump.equipment = {};
	end
	frmMainchbEquipmentText:SetText(L.chbEquipment .. string.format(" (%d)",
		#dump.equipment));
	-- TODO: returns this place
	if frmMainchbQuestlog:GetChecked() then
		dump.questlog = CHD_trycall(CHD_GetQuestlogInfo) or {};
	else
		dump.questlog = {};
	end
	frmMainchbQuestlogText:SetText(L.chbQuestlog .. string.format(" (%d)",
		#dump.questlog));

	if frmMainchbMacro:GetChecked() then
		dump.pmacro = CHD_trycall(CHD_GetPMacroInfo) or {};
		dump.amacro = CHD_trycall(CHD_GetAMacroInfo) or {};
	else
		dump.pmacro = {};
		dump.amacro = {};
	end
	frmMainchbMacroText:SetText(L.chbMacro .. string.format(" (%d)",
		#dump.pmacro + #dump.amacro));

	if frmMainchbFriend:GetChecked() then
		dump.friend = CHD_trycall(CHD_GetFriendsInfo) or {};
		dump.ignore = CHD_trycall(CHD_GetIgnoresInfo) or {};
	else
		dump.friend = {};
		dump.ignore = {};
	end
	frmMainchbFriendText:SetText(L.chbFriend .. string.format(" (%d, %d)",
		#dump.friend, #dump.ignore));

	if frmMainchbArena:GetChecked() then
		dump.arena = CHD_trycall(CHD_GetArenaInfo) or {};
	else
		dump.arena = {};
	end
	frmMainchbArenaText:SetText(L.chbArena .. string.format(" (%d)", #dump.arena));

	CHD_Message(L.CreatedDump);
	CHD_Message(L.DumpDone);

	CHD_CLIENT = dump;
	CHD_KEY   = nil;
end