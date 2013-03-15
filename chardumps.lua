--[[
	chardumps.lua
		Main module
	Chardumps
		Dump of character.
	version 1.5
	Created by SlaFF
		Gracer (Alliance)
	thanks Sun`s chardump, reforged
--]]
local crypt_lib = crypt_lib;
chardumps = LibStub('AceAddon-3.0'):NewAddon('chardumps');
local L = LibStub('AceLocale-3.0'):GetLocale('chardumps');

local CHD = {};
local CHD_SERVER_LOCAL = {};
local CHD_gArrCheckboxes = {};
CHD_CLIENT  = {};
CHD_FIELD_COUNT = {};
CHD_OPTIONS = CHD_OPTIONS or {};

local MAX_NUM_CONTINENT = 4 -- 1..4

--[[
	Functions
--]]

function CHD_Message(...)
	local x = {...};
	for k,v in pairs(x) do
		print("\124cFF9F3FFFchardumps:\124r ", tostring(v));
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
		CHD_frmMainpanSystem:SetBackdrop(nil);
		CHD_frmMainpanSystem:SetParent(CHD_frmMain);
		CHD_frmMainpanSystem:Show();
		CHD_frmMain:Show();
	else
		CHD_Message(L.help1);
		CHD_Message(L.help2);
		CHD_Message(L.help3);
	end
end

function CHD_SetOptionsDef()
	CHD_OPTIONS = {};

	CHD_OPTIONS.chbCrypt = true;
	CHD_OPTIONS.chbActive = true;
	CHD_OPTIONS.chdMinimize = false;

	CHD_OPTIONS.chbSpells = true;
	CHD_OPTIONS.chbMounts = true;
	CHD_OPTIONS.chbCritters = true;
	CHD_OPTIONS.chbReputation = true;
	CHD_OPTIONS.chbAchievements = true;
	CHD_OPTIONS.chbEquipment = true;
	CHD_OPTIONS.chbMacro = true;
	CHD_OPTIONS.chbArena = true;

	CHD_OPTIONS.chbGlyph = true;
	CHD_OPTIONS.chbCurrency = true;
	CHD_OPTIONS.chbInventory = true;
	CHD_OPTIONS.chbBags = true;
	CHD_OPTIONS.chbSkills = true;
	CHD_OPTIONS.chbQuestlog = true;
	CHD_OPTIONS.chbFriend = true;

	CHD_OPTIONS.chbBank = true;
	CHD_OPTIONS.chbQuests = true;
	CHD_OPTIONS.chbTaxi = true;

	return true;
end

function CHD_SetOptions()
	CHD_frmMainchbGlyphs:SetChecked(CHD_OPTIONS.chbGlyph);
	CHD_frmMainchbCurrency:SetChecked(CHD_OPTIONS.chbCurrency);
	CHD_frmMainchbSpells:SetChecked(CHD_OPTIONS.chbSpells);
	CHD_frmMainchbMounts:SetChecked(CHD_OPTIONS.chbMounts);
	CHD_frmMainchbCritters:SetChecked(CHD_OPTIONS.chbCritters);
	CHD_frmMainchbReputation:SetChecked(CHD_OPTIONS.chbReputation);
	CHD_frmMainchbAchievements:SetChecked(CHD_OPTIONS.chbAchievements);
	CHD_frmMainchbSkills:SetChecked(CHD_OPTIONS.chbSkills);
	CHD_frmMainchbInventory:SetChecked(CHD_OPTIONS.chbInventory);
	CHD_frmMainchbBags:SetChecked(CHD_OPTIONS.chbBags);
	CHD_frmMainchbEquipment:SetChecked(CHD_OPTIONS.chbEquipment);
	CHD_frmMainchbQuestlog:SetChecked(CHD_OPTIONS.chbQuestlog);
	CHD_frmMainchbMacro:SetChecked(CHD_OPTIONS.chbMacro);
	CHD_frmMainchbFriend:SetChecked(CHD_OPTIONS.chbFriend);
	CHD_frmMainchbArena:SetChecked(CHD_OPTIONS.chbArena);

	CHD_frmMainchbTaxi:SetChecked(CHD_OPTIONS.chbTaxi);
	CHD_frmMainchbQuests:SetChecked(CHD_OPTIONS.chbQuests);
	CHD_frmMainchbBank:SetChecked(CHD_OPTIONS.chbBank);

	CHD_frmMainchbActive:SetChecked(CHD_OPTIONS.chbActive);
	CHD_frmMainchbCrypt:SetChecked(CHD_OPTIONS.chbCrypt);

	if (CHD_OPTIONS.chdMinimize) then
		OnCHD_frmMainbtnMinimizeClLick();
	end;

	return true;
end

function CHD_SaveOptions()
	CHD_OPTIONS.chbGlyph        = CHD_frmMainchbGlyphs:GetChecked();
	CHD_OPTIONS.chbCurrency     = CHD_frmMainchbCurrency:GetChecked();
	CHD_OPTIONS.chbSpells       = CHD_frmMainchbSpells:GetChecked();
	CHD_OPTIONS.chbMounts       = CHD_frmMainchbMounts:GetChecked();
	CHD_OPTIONS.chbCritters     = CHD_frmMainchbCritters:GetChecked();
	CHD_OPTIONS.chbReputation   = CHD_frmMainchbReputation:GetChecked();
	CHD_OPTIONS.chbAchievements = CHD_frmMainchbAchievements:GetChecked();
	CHD_OPTIONS.chbSkills       = CHD_frmMainchbSkills:GetChecked();
	CHD_OPTIONS.chbInventory    = CHD_frmMainchbInventory:GetChecked();
	CHD_OPTIONS.chbBags         = CHD_frmMainchbBags:GetChecked();
	CHD_OPTIONS.chbEquipment    = CHD_frmMainchbEquipment:GetChecked();
	CHD_OPTIONS.chbQuestlog     = CHD_frmMainchbQuestlog:GetChecked();
	CHD_OPTIONS.chbMacro        = CHD_frmMainchbMacro:GetChecked();
	CHD_OPTIONS.chbFriend       = CHD_frmMainchbFriend:GetChecked();
	CHD_OPTIONS.chbArena        = CHD_frmMainchbArena:GetChecked();

	CHD_OPTIONS.chbTaxi         = CHD_frmMainchbTaxi:GetChecked();
	CHD_OPTIONS.chbQuests       = CHD_frmMainchbQuests:GetChecked();
	CHD_OPTIONS.chbBank         = CHD_frmMainchbBank:GetChecked();

	CHD_OPTIONS.chbActive       = CHD_frmMainchbActive:GetChecked();
	CHD_OPTIONS.chbCrypt        = CHD_frmMainchbCrypt:GetChecked();

	return true;
end

function CHD_FillFieldCountClient(dump)
	if not CHD_FIELD_COUNT then
		CHD_FIELD_COUNT = {};
	end;

	if not dump then
		return false;
	end

	CHD_FIELD_COUNT.achievement = #dump.achievement;
	CHD_FIELD_COUNT.criteria1 = #dump.criteria1;
	CHD_FIELD_COUNT.criteria0 = #dump.criteria0;
	CHD_FIELD_COUNT.arena = #dump.arena;
	CHD_FIELD_COUNT.critter = #dump.critter;
	CHD_FIELD_COUNT.mount = #dump.mount;
	CHD_FIELD_COUNT.bag = CHD_GetTableCount(dump.bag);
	CHD_FIELD_COUNT.currency = #dump.currency;
	CHD_FIELD_COUNT.equipment = #dump.equipment;
	CHD_FIELD_COUNT.reputation = #dump.reputation;
	CHD_FIELD_COUNT.glyph = #dump.glyph;
	CHD_FIELD_COUNT.inventory = #dump.inventory;
	CHD_FIELD_COUNT.questlog = #dump.questlog;
	CHD_FIELD_COUNT.spell = #dump.spell;
	CHD_FIELD_COUNT.skill = #dump.skill;
	CHD_FIELD_COUNT.macro = #dump.pmacro;
	CHD_FIELD_COUNT.friend = #dump.friend;
	CHD_FIELD_COUNT.pet = 0;

	CHD_FIELD_COUNT.bank = CHD_GetTableCount(dump.bank);
	CHD_FIELD_COUNT.taxi = #dump.taxi;
	CHD_FIELD_COUNT.quest = #dump.quest;

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
	CHD_SERVER_LOCAL.taxi = CHD_TAXI;
	CHD_SERVER_LOCAL.quest = {};
	CHD_SERVER_LOCAL.bank = {};
	CHD_SERVER_LOCAL.bank.mainbank = {};

	CHD_frmMainchbTaxiText:SetText(L.chbTaxi .. string.format(" (%d, %d, %d, %d)",
		#CHD_TAXI[1],
		#CHD_TAXI[2],
		#CHD_TAXI[3],
		#CHD_TAXI[4])
	);
	CHD_frmMainchbQuestsText:SetText(L.chbQuests);
	CHD_frmMainchbBankText:SetText(L.chbBank);

	if not CHD_trycall(CHD_SetOptions) then
		CHD_SetOptionsDef();
		CHD_trycall(CHD_SetOptions);
		OnCHD_frmMainbtnHideClLick(); -- first loading, TODO: delete?
	end

	return true;
end

function OnCHD_frmMainbtnCheckAllClLick()
	for k,v in pairs(CHD_gArrCheckboxes) do
		v:SetChecked();
	end
end

function OnCHD_frmMainbtnCheckNoneClLick()
	for k,v in pairs(CHD_gArrCheckboxes) do
		v:SetChecked(nil);
	end
end

function OnCHD_frmMainbtnCheckInvClLick()
	for k,v in pairs(CHD_gArrCheckboxes) do
		local b = v:GetChecked();
		v:SetChecked(not b);
	end
end

function CHD_OnEvent(self, event, ...)
	if "BANKFRAME_OPENED" == event then
		if CHD_frmMainchbBank:GetChecked() then
			CHD_SERVER_LOCAL.bank = CHD_trycall(CHD_GetBankInfo) or {};
		else
			CHD_SERVER_LOCAL.bank = {};
		end
		CHD_frmMainchbBankText:SetText(L.chbBank .. string.format(" (%d)", CHD_GetTableCount(CHD_SERVER_LOCAL.bank) - 1));
	elseif "PLAYER_LEAVING_WORLD" == event then
		CHD_SaveOptions();
	elseif "TAXIMAP_OPENED" == event then
		if CHD_frmMainchbTaxi:GetChecked() then
			CHD_SetTaxiInfo();
		end
	elseif "VARIABLES_LOADED" == event then
		CHD_OnVariablesLoaded();
	end
end

function CHD_CreateMessageBox()
	local theFrame = CreateFrame("Frame", nil, UIParent);

	theFrame:ClearAllPoints();
	theFrame:SetPoint("CENTER", UIParent);
	theFrame:SetHeight(78);
	theFrame:SetWidth(200);

	theFrame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {left = 1, right = 1, top = 1, bottom = 1},
	});
	theFrame:SetFrameStrata("TOOLTIP");
	theFrame:EnableMouse(true);
	theFrame:SetMovable(true);

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
	theFrame.Title:SetPoint("TOPLEFT", theFrame, "TOPLEFT", 6, -10);
	theFrame.Title:SetTextColor(1.0,1.0,0.0,1.0);
	theFrame.Title:SetText("null");

	theFrame.Text = theFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	theFrame.Text:SetPoint("CENTER",theFrame,"CENTER",0,0);
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
		bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
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
	CHD_frmMainchbGlyphsText:SetText(L.chbGlyphs);
	CHD_frmMainchbCurrencyText:SetText(L.chbCurrency);
	CHD_frmMainchbSpellsText:SetText(L.chbSpells);
	CHD_frmMainchbMountsText:SetText(L.chbMounts);
	CHD_frmMainchbCrittersText:SetText(L.chbCritters);
	CHD_frmMainchbReputationText:SetText(L.chbReputation);
	CHD_frmMainchbAchievementsText:SetText(L.chbAchievements);
	CHD_frmMainchbSkillsText:SetText(L.chbSkills);
	CHD_frmMainchbInventoryText:SetText(L.chbInventory);
	CHD_frmMainchbBagsText:SetText(L.chbBags);
	CHD_frmMainchbEquipmentText:SetText(L.chbEquipment);
	CHD_frmMainchbQuestlogText:SetText(L.chbQuestlog);
	CHD_frmMainchbMacroText:SetText(L.chbMacro);
	CHD_frmMainchbFriendText:SetText(L.chbFriend);
	CHD_frmMainchbArenaText:SetText(L.chbArena);
	CHD_frmMainchbQuestsText:SetText(L.chbQuests);
	CHD_frmMainbtnQuestQueryText:SetText(L.btnServerQuery);
	CHD_frmMainchbPetText:SetText(L.chbPet);
	CHD_frmMainchbPet:Disable();

	CHD_frmMainchbBankText:SetText(L.chbBank);
	CHD_frmMainchbTaxiText:SetText(L.chbTaxi);

	CHD_frmMainchbCrypt:SetText("");
	CHD_frmMainchbActive:SetText("");

	CHD_frmMainbtnDumpText:SetText(L.btnDump);

	self:SetScript("OnEvent", CHD_OnEvent);
	self:RegisterEvent("TAXIMAP_OPENED");
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("BANKFRAME_OPENED");
	self:RegisterEvent("PLAYER_LEAVING_WORLD");
	self:SetBackdrop(CHD_GetBackdrop());
	self:SetFrameStrata("DIALOG");

	local btnW = CHD_frmMainbtnHide:GetWidth();
	CHD_frmMainbtnHide:SetParent(CHD_frmMainpanSystem);
	CHD_frmMainbtnHide:ClearAllPoints();
	CHD_frmMainbtnHide:SetPoint("CENTER", CHD_frmMainpanSystem, 0, 0);
	CHD_frmMainbtnHide:SetPoint("RIGHT", CHD_frmMainpanSystem, -11, 0);
	CHD_frmMainbtnMinimize:SetParent(CHD_frmMainpanSystem);
	CHD_frmMainbtnMinimize:ClearAllPoints();
	CHD_frmMainbtnMinimize:SetPoint("CENTER", CHD_frmMainpanSystem, 0, 0);
	CHD_frmMainbtnMinimize:SetPoint("RIGHT", CHD_frmMainpanSystem, -14 - btnW, 0);

	CHD_frmMainpanSystem:ClearAllPoints();
	CHD_frmMainpanSystem:SetPoint("TOPRIGHT", CHD_CHD_frmMain);
	CHD_frmMainpanSystem:SetPoint("TOPRIGHT", 0, 0);
	CHD_frmMainpanSystem:SetWidth(5 + 5 + btnW*2 + 3*3 + 5);

	btnW = CHD_frmMainchbCrypt:GetWidth();
	CHD_frmMainchbActive:ClearAllPoints();
	CHD_frmMainchbActive:SetPoint("TOPLEFT", self);
	CHD_frmMainchbActive:SetPoint("TOPLEFT", 8, -8);
	CHD_frmMainchbCrypt:ClearAllPoints();
	CHD_frmMainchbCrypt:SetPoint("TOPLEFT", self);
	CHD_frmMainchbCrypt:SetPoint("TOPLEFT", 8 + 3 + btnW, -8);

	AddTooltip(CHD_frmMainchbGlyphs, L.chbGlyphs, L.ttchbGlyphs);
	AddTooltip(CHD_frmMainchbCurrency, L.chbCurrency, L.ttchbCurrency);
	AddTooltip(CHD_frmMainchbSpells, L.chbSpells, L.ttchbSpells);
	AddTooltip(CHD_frmMainchbMounts, L.chbMounts, L.ttchbMounts);
	AddTooltip(CHD_frmMainchbCritters, L.chbCritters, L.ttchbCritters);
	AddTooltip(CHD_frmMainchbReputation, L.chbReputation, L.ttchbReputation);
	AddTooltip(CHD_frmMainchbAchievements, L.chbAchievements, L.ttchbAchievements);
	AddTooltip(CHD_frmMainchbSkills, L.chbSkills, L.ttchbSkills);
	AddTooltip(CHD_frmMainchbInventory, L.chbInventory, L.ttchbInventory);
	AddTooltip(CHD_frmMainchbBags, L.chbBags, L.ttchbBags);
	AddTooltip(CHD_frmMainchbEquipment, L.chbEquipment, L.ttchbEquipment);
	AddTooltip(CHD_frmMainchbQuestlog, L.chbQuestlog, L.ttchbQuestlog);
	AddTooltip(CHD_frmMainchbMacro, L.chbMacro, L.ttchbMacro);
	AddTooltip(CHD_frmMainchbFriend, L.chbFriend, L.ttchbFriend);
	AddTooltip(CHD_frmMainchbArena, L.chbArena, L.ttchbArena);
	AddTooltip(CHD_frmMainchbQuests, L.chbQuests, L.ttchbQuests);
	AddTooltip(CHD_frmMainchbPet, L.chbPet, L.ttchbPet);

	AddTooltip(CHD_frmMainchbBank, L.chbBank, L.ttchbBank);
	AddTooltip(CHD_frmMainchbTaxi, L.chbTaxi, L.ttchbTaxi);

	AddTooltip(CHD_frmMainchbActive, L.chbActive, L.ttchbActive);
	AddTooltip(CHD_frmMainchbCrypt, L.chbCrypt, L.ttchbCrypt);

	AddTooltip(CHD_frmMainbtnHide, L.ttbtnHide, "");
	AddTooltip(CHD_frmMainbtnMinimize, L.ttbtnMinimize, "");
	AddTooltip(CHD_frmMainbtnDump, L.btnDump, L.ttbtnDump);
	AddTooltip(CHD_frmMainbtnQuestQuery, L.btnServerQuery, L.ttbtnServerQuery);
	AddTooltip(CHD_frmMainbtnBankDel, L.chbBank, L.ttbtnBankDel);
	AddTooltip(CHD_frmMainbtnQuestDel, L.chbQuests, L.ttbtnQuestDel);
	AddTooltip(CHD_frmMainbtnTaxiDel, L.chbTaxi, L.ttbtnTaxiDel);

	AddTooltip(CHD_frmMainbtnCheckAll, L.Comboboxes, L.ttbtnCheckAll);
	AddTooltip(CHD_frmMainbtnCheckNone, L.Comboboxes, L.ttbtnCheckNone);
	AddTooltip(CHD_frmMainbtnCheckInv, L.Comboboxes, L.ttbtnCheckInv);

	CHD_CreateMessageBox();

	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbSpells);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbMounts);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbCritters);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbReputation);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbAchievements);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbEquipment);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbMacro);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbArena);

	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbGlyphs);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbCurrency);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbInventory);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbBags);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbSkills);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbQuestlog);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbFriend);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbQuests);
--	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbPet);

	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbBank);
	table.insert(CHD_gArrCheckboxes, CHD_frmMainchbTaxi);

	CHD_Message(L.loadmessage);
end

function OnCHD_frmMainbtnMinimizeClLick()
	if CHD_frmMain:IsVisible() then
		CHD_frmMainpanSystem:SetBackdrop(CHD_GetBackdrop());
		CHD_frmMainpanSystem:SetParent("UIParent");
		CHD_frmMain:Hide();
		CHD_OPTIONS.chdMinimize = true;
	else
		CHD_frmMainpanSystem:SetBackdrop(nil);
		CHD_frmMainpanSystem:SetParent(CHD_frmMain);
		CHD_frmMain:Show();
		CHD_OPTIONS.chdMinimize = false;
	end
end

function OnCHD_frmMainbtnHideClLick()
	if CHD_frmMainpanSystem:IsVisible() then
		CHD_frmMainpanSystem:Hide();
	end
	CHD_frmMain:Hide();
end

function CHD_BankDel()
	CHD_SERVER_LOCAL.bank = {};
	CHD_SERVER_LOCAL.bank.mainbank = {};
	CHD_frmMainchbBankText:SetText(L.chbBank);
	CHD_Message(L.DeleteBank);
end;

function OnCHD_frmMainbtnBankDelCLick()
	CHD.MessageBox.Title:SetText(L.DeleteBank);
	CHD.MessageBox.OnOK = CHD_BankDel;
	CHD.MessageBox:Show();
end

function CHD_QuestDel()
	CHD_SERVER_LOCAL.quest = {};
	CHD_frmMainchbQuestsText:SetText(L.chbQuests);
	CHD_Message(L.DeleteQuests);
end;

function OnCHD_frmMainbtnQuestDelCLick()
	CHD.MessageBox.Title:SetText(L.DeleteQuests);
	CHD.MessageBox.OnOK = CHD_QuestDel;
	CHD.MessageBox:Show();
end

function CHD_TaxiDel()
	CHD_TAXI = {};
	CHD_SERVER_LOCAL.taxi = {};
	CHD_frmMainchbTaxiText:SetText(L.chbTaxi);
	CHD_Message(L.DeleteTaxi);
end;

function OnCHD_frmMainbtnTaxiDelCLick()
	CHD.MessageBox.Title:SetText(L.DeleteTaxi);
	CHD.MessageBox.OnOK = CHD_TaxiDel;
	CHD.MessageBox:Show();
end

function CHD_OnRecieveQuestsClick()
	QueryQuestsCompleted();
	if CHD_frmMainchbQuests:GetChecked() then
		CHD_SERVER_LOCAL.quest = CHD_trycall(CHD_GetQuestInfo) or {};
		CHD_frmMainchbQuestsText:SetText(L.chbQuests .. string.format(" (%d)", #CHD_SERVER_LOCAL.quest));
	else
		CHD_SERVER_LOCAL.quest = {};
		CHD_frmMainchbQuestsText:SetText(L.chbQuests .. " (0)");
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

	local i = 1;
	while true do
		local name, isHeader = GetCurrencyListInfo(i);
		if (not name) then
			break;
		end
		if isHeader then
			ExpandCurrencyList(i, 1);
		end
		i = i + 1;
	end

	CHD_Message(L.GetCurrency);
	for i = 1, GetCurrencyListSize() do
		local _, isHeader, _, _, _, count, extraCurrencyType, _, itemID = GetCurrencyListInfo(i);
		if (not isHeader) and (extraCurrencyType == 0) then
			table.insert(res, {itemID, count});
		end
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
				table.insert(res, {spellid, i});
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
	local tblRep = {};

	CHD_Message(L.GetReputation);
	ExpandAllFactionHeaders();
	for i = 1, GetNumFactions() do
		local name = GetFactionInfo(i);
		tblRep[name] = true;
	end

	for i = 1, 1160 do -- maximum 1160 for 3.3.5a
		local name, _, _, _, _, barValue, atWarWith, canToggleAtWar, isHeader, _, _, isWatched = GetFactionInfoByID(i);
		if name and tblRep[name] then
			local flags = 1;
			if canToggleAtWar and atWarWith then
				flags = bit.bor(1, 2);
			end
			table.insert(res, {["I"] = i, ["V"] = barValue, ["F"] = flags});
		end
	end

	return res;
end

function CHD_GetAchievementInfo()
	local res = {};

	CHD_Message(L.GetAchievement);

	for i = 1, 5000 do
		local IDNumber, _, _, Completed, Month, Day, Year = GetAchievementInfo(i);
		if IDNumber and Completed then
			local posixtime = time{year = 2000 + Year, month = Month, day = Day};
			if posixtime then
				table.insert(res, {["I"] = IDNumber, ["T"] = posixtime});
			end
		end
	end

	return res;
end

function compCriteria(e1, e2)
	if e1[1] < e2[1] then
		return true;
	end
	return false;
end;

function CHD_GetCriteriaCompleted()
	local res = {};

	for i = 1, 5000 do
		local _, _, _, Completed = GetAchievementInfo(i);
		if Completed then
			for j = 1, GetAchievementNumCriteria(i) do
				local description, type, completed, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfo(i, j);
				if completed and quantity and quantity > 0 then
					table.insert(res, {criteriaID, quantity});
				end
			end
		end
	end
	table.sort(res, compCriteria);

	return res;
end

function CHD_GetCriteriaProgress()
	local res = {};

	for i = 1, 5000 do
		local id, _, _, Completed = GetAchievementInfo(i);
		if id and not Completed then
			for j = 1, GetAchievementNumCriteria(i) do
				local _, _, completed, quantity, _, _, _, _, _, criteriaID = GetAchievementCriteriaInfo(i, j);
				if quantity and quantity > 0 then
					table.insert(res, {criteriaID, quantity});
				end
			end
		end
	end
	table.sort(res, compCriteria);

	return res;
end

function CHD_GetSkillInfo()
	local res = {};

	local i = 1;
	while true do
		local name, isHeader = GetSkillLineInfo(i);
		if not name then
			break;
		end
		if isHeader then
			ExpandSkillHeader(i, 1);
		end
		i = i + 1;
	end

	CHD_Message(L.GetSkill);
	for i = 1, GetNumSkillLines() do
		local skillName, _, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i);
		res[i] = {["N"] = skillName, ["R"] = skillRank, ["M"] = skillMaxRank};
	end

	return res;
end

function CHD_GetInventoryInfo()
	local res = {};
	local index = 24;

	CHD_Message(L.GetInventory);
	-- 1..19 equipped items +
	-- 20-23 Equipped Bags +
	-- 24-39 Main Backpack +
	-- 40-67 Main Bank
	-- 68-74 Bank Bags
	-- 86-117 Keys in Keyring +

	for i = 1, 23 do
		local itemLink = GetInventoryItemLink("player", i);
		if itemLink then
			local count = GetInventoryItemCount("player", i);
			for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do 
				res[i] = {["I"] = tonumber(id), ["N"] = count, ["H"] = tonumber(enchant), ["G1"] = tonumber(gem1), ["G2"] = tonumber(gem2), ["G3"] = tonumber(gem3)};
			end
		end
	end

	local container = 0;
	for slot = 1, GetContainerNumSlots(container) do
		local itemLink = GetContainerItemLink(container, slot);
		if itemLink then
			local _, count, _, _, _, _, _ = GetContainerItemInfo(container, slot);
			for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do 
				res[index] = {["I"] = tonumber(id), ["N"] = count, ["H"] = tonumber(enchant), ["G1"] = tonumber(gem1), ["G2"] = tonumber(gem2), ["G3"] = tonumber(gem3)};
			end
		end
		index = index + 1;
	end

	container = -2;
	index = 86;
	for slot = 1, GetContainerNumSlots(container) do
		local itemLink = GetContainerItemLink(container, slot);
		if itemLink then
			local id = GetContainerItemID(container, slot);
			local _, count = GetContainerItemInfo(container, slot);
			res[index] = {["I"] = id, ["N"] = count};
		end
		index = index + 1;
	end

	return res;
end

function CHD_GetBagInfo()
	local res = {};

	CHD_Message(L.GetBag);

	i = 0;
	for bag = 1,NUM_BAG_SLOTS do
		local nCount = 0;
		for slot = 1, GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot);
			if itemLink then
				local _, count = GetContainerItemInfo(bag, slot);
				for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do 
					res[i*100 + slot] = {["I"] = tonumber(id), ["N"] = count, ["H"] = tonumber(enchant), ["G1"] = tonumber(gem1), ["G2"] = tonumber(gem2), ["G3"] = tonumber(gem3)};
				end
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
	if not CHD_TAXI then
		CHD_TAXI = {};
	end
	for i = 1, MAX_NUM_CONTINENT do
		if not CHD_TAXI[i] then
			CHD_TAXI[i] = {};
		end
	end
	CHD_TAXI[continent] = res;

	CHD_frmMainchbTaxiText:SetText(L.chbTaxi .. string.format(" (%d, %d, %d, %d)",
		(#CHD_TAXI[1] or 0),
		(#CHD_TAXI[2] or 0),
		(#CHD_TAXI[3] or 0),
		(#CHD_TAXI[4] or 0))
	);

	CHD_Message(L.CountOfTaxi .. tostring(#CHD_TAXI[continent]));

	return true;
end

function CHD_GetBankInfo()
	local res = {};
	-- BANK_CONTAINER is the bank window
	-- NUM_BAG_SLOTS+1 to NUM_BAG_SLOTS+NUM_BANKBAGSLOTS are your bank bags
	res.mainbank = {};

	for i = 40, 74 do -- main bank and 7 bank bags
		local itemLink = GetInventoryItemLink("player", i)
		if itemLink then
			count = GetInventoryItemCount("player",i)
			for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do
				res.mainbank[i] = {["I"] = tonumber(id), ["N"] = count, ["H"] = tonumber(enchant), ["G1"] = tonumber(gem1), ["G2"] = tonumber(gem2), ["G3"] = tonumber(gem3)};
			end
		end
	end

	CHD_Message(L.GetBank);
	i = 0;
	for bag = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		local nCount = 0;
		for slot = 1, GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot)
			if itemLink then
				_, count = GetContainerItemInfo(bag, slot);
				for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do
					res[i*100 + slot] = {["I"] = tonumber(id), ["N"] = count, ["H"] = tonumber(enchant), ["G1"] = tonumber(gem1), ["G2"] = tonumber(gem2), ["G3"] = tonumber(gem3)};
				end
				nCount = nCount + 1;
			end
		end
		i = i + 1;
		CHD_Message(string.format(L.ScaningBankTotal, i, nCount));
	end

	return res;
end

--[[
	Saving data
--]]

function CHD_Debug()
	CHD_SaveOptions();
end

function table.copy(t)
	local u = {};

	for k, v in pairs(t) do
		u[k] = v;
	end

	return setmetatable(u, getmetatable(t));
end

function CHD_OnDumpClick()
	local dump = {};

	CHD_Message(L.CreatingDump);
	dump.global = CHD_trycall(CHD_GetGlobalInfo) or {};
	dump.player = CHD_trycall(CHD_GetPlayerInfo) or {};
	if CHD_frmMainchbGlyphs:GetChecked() then
		dump.glyph = CHD_trycall(CHD_GetGlyphInfo) or {};
	else
		dump.glyph = {};
	end
	CHD_frmMainchbGlyphsText:SetText(L.chbGlyphs .. string.format(" (%d)",
		CHD_GetTableCount(dump.glyph)));
	if CHD_frmMainchbCurrency:GetChecked() then
		dump.currency = CHD_trycall(CHD_GetCurrencyInfo) or {};
	else
		dump.currency = {};
	end
	CHD_frmMainchbCurrencyText:SetText(L.chbCurrency .. string.format(" (%d)",
		CHD_GetTableCount(dump.currency)));
	if CHD_frmMainchbSpells:GetChecked() then
		dump.spell = CHD_trycall(CHD_GetSpellInfo) or {};
	else
		dump.spell = {};
	end
	CHD_frmMainchbSpellsText:SetText(L.chbSpells .. string.format(" (%d)", #dump.spell));
	if CHD_frmMainchbMounts:GetChecked() then
		dump.mount = CHD_trycall(CHD_GetMountInfo) or {};
	else
		dump.mount = {};
	end
	CHD_frmMainchbMountsText:SetText(L.chbMounts .. string.format(" (%d)", #dump.mount))
	if CHD_frmMainchbCritters:GetChecked() then
		dump.critter = CHD_trycall(CHD_GetCritterInfo) or {};
	else
		dump.critter = {};
	end
	CHD_frmMainchbCrittersText:SetText(L.chbCritters .. string.format(" (%d)", #dump.critter));

	if CHD_frmMainchbReputation:GetChecked() then
		dump.reputation = CHD_trycall(CHD_GetRepInfo) or {};
	else
		dump.reputation = {};
	end;
	CHD_frmMainchbReputationText:SetText(L.chbReputation .. string.format(" (%d)",
		CHD_GetTableCount(dump.reputation)));

	if CHD_frmMainchbAchievements:GetChecked() then
		dump.achievement = CHD_trycall(CHD_GetAchievementInfo) or {};
		dump.criteria1 = CHD_trycall(CHD_GetCriteriaCompleted) or {};
		dump.criteria0 = CHD_trycall(CHD_GetCriteriaProgress) or {};
	else
		dump.achievement = {};
		dump.criteria1 = {};
		dump.criteria0 = {};
	end
	CHD_frmMainchbAchievementsText:SetText(L.chbAchievements .. string.format(" (%d)",
		#dump.achievement));

	if CHD_frmMainchbSkills:GetChecked() then
		dump.skill = CHD_trycall(CHD_GetSkillInfo) or {};
	else
		dump.skill = {};
	end
	CHD_frmMainchbSkillsText:SetText(L.chbSkills .. string.format(" (%d)",
		CHD_GetTableCount(dump.skill)));
	if CHD_frmMainchbInventory:GetChecked() then
		dump.inventory = CHD_trycall(CHD_GetInventoryInfo) or {};
	else
		dump.inventory = {};
	end
	CHD_frmMainchbInventoryText:SetText(L.chbInventory .. string.format(" (%d)",
		CHD_GetTableCount(dump.inventory)));
	if CHD_frmMainchbBags:GetChecked() then
		dump.bag = CHD_trycall(CHD_GetBagInfo) or {};
	else
		dump.bag = {};
	end
	CHD_frmMainchbBagsText:SetText(L.chbBags .. string.format(" (%d)",
		CHD_GetTableCount(dump.bag)));
	if CHD_frmMainchbEquipment:GetChecked() then
		dump.equipment = CHD_trycall(CHD_GetEquipmentInfo) or {};
	else
		dump.equipment = {};
	end
	CHD_frmMainchbEquipmentText:SetText(L.chbEquipment .. string.format(" (%d)",
		#dump.equipment));
	-- TODO: returns this place
	if CHD_frmMainchbQuestlog:GetChecked() then
		dump.questlog = CHD_trycall(CHD_GetQuestlogInfo) or {};
	else
		dump.questlog = {};
	end
	CHD_frmMainchbQuestlogText:SetText(L.chbQuestlog .. string.format(" (%d)",
		#dump.questlog));

	if CHD_frmMainchbMacro:GetChecked() then
		dump.pmacro = CHD_trycall(CHD_GetPMacroInfo) or {};
		dump.amacro = CHD_trycall(CHD_GetAMacroInfo) or {};
	else
		dump.pmacro = {};
		dump.amacro = {};
	end
	CHD_frmMainchbMacroText:SetText(L.chbMacro .. string.format(" (%d)",
		#dump.pmacro + #dump.amacro));

	if CHD_frmMainchbFriend:GetChecked() then
		dump.friend = CHD_trycall(CHD_GetFriendsInfo) or {};
		dump.ignore = CHD_trycall(CHD_GetIgnoresInfo) or {};
	else
		dump.friend = {};
		dump.ignore = {};
	end
	CHD_frmMainchbFriendText:SetText(L.chbFriend .. string.format(" (%d, %d)",
		#dump.friend, #dump.ignore));

	if CHD_frmMainchbArena:GetChecked() then
		dump.arena = CHD_trycall(CHD_GetArenaInfo) or {};
	else
		dump.arena = {};
	end
	CHD_frmMainchbArenaText:SetText(L.chbArena .. string.format(" (%d)", #dump.arena));

	dump.taxi = CHD_SERVER_LOCAL.taxi;
	dump.quest = CHD_SERVER_LOCAL.quest;
	local bankTable = table.copy(CHD_SERVER_LOCAL.bank);
	for i = 40, 74 do
		dump.inventory[i] = bankTable.mainbank[i];
	end
	bankTable.mainbank = nil;
	dump.bank = bankTable;

	CHD_FillFieldCountClient(dump);
	if CHD_frmMainchbCrypt:GetChecked() then
		CHD_CLIENT = crypt_lib.encode(dump);
	else
		CHD_CLIENT = dump;
	end

	CHD_Message(L.CreatedDump);
	CHD_Message(L.DumpDone);

	CHD_KEY = nil;
end