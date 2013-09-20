--[[

--]]
local L = LibStub("AceLocale-3.0"):GetLocale("chardumps");
local CHD_gArrCheckboxes = CHD_gArrCheckboxes or {};
CHD_OPTIONS = CHD_OPTIONS;
CHD_TAXI = CHD_TAXI or {};

local chbWidth = 24;
local chbHeight = 22;
local btnWidth = 20;
local btnHeight = 20;
local FrameWidth = 540;
local FrameHeight = 310;

local function CHD_CreateCheckBox(name, x, y, parent)
	local chbName = parent:GetName() .. name;
	local chb = CreateFrame("CheckButton", chbName, parent, "ChatConfigCheckButtonTemplate");
	chb:ClearAllPoints();
	chb:SetPoint("TOPLEFT", parent, x, -y);
	chb:SetWidth(chbWidth);
	chb:SetHeight(chbHeight);
	chb:SetChecked(true);

	SetTooltip(chb, L[name], L["tt" .. name]);

	local chbText = getglobal(chbName .. "Text");
	chbText:SetText(L[name]);

	return chb;
end

local function CHD_CreateButton(name, x, y, cx, cy, parent, title)
	local btnName = parent:GetName() .. name;
	local btn = CreateFrame("Button", btnName, parent, "OptionsButtonTemplate");
	btn:ClearAllPoints();
	btn:SetPoint("TOPLEFT", parent, x, -y);
	btn:SetWidth(cx);
	btn:SetHeight(cy);
	if not title then
		title = L[name];
	end
	SetTooltip(btn, title, L["tt" .. name]);
	btn:SetText(L[name]);

	return btn;
end

local function CHD_CreateEditLabel(name, parent, anchorPoint, x, y, cx, cy, title, maxLen)
	local edt = CreateFrame("EditBox", parent:GetName() .. name, parent, "InputBoxTemplate");
	edt:ClearAllPoints();
	edt:SetPoint(anchorPoint, x, y);
	edt:SetTextInsets(0, 0, 3, 3);
	edt:SetWidth(cx);
	edt:SetHeight(cy);
	edt:SetAutoFocus(false);
	if maxLen then
		edt:SetMaxLetters(maxLen);
	end

	local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
	label:SetPoint("TOPRIGHT", edt, "TOPLEFT", -10, 0);
	label:SetJustifyH("LEFT");
	label:SetHeight(cy - 2);
	label:SetText(title);

	edt.label = label;

	return edt;
end

function OnCHD_frmMainbtnCheckAllClick()
	for k,v in pairs(CHD_gArrCheckboxes) do
		if v:IsEnabled() > 0 then
			v:SetChecked();
		end
	end
end

function OnCHD_frmMainbtnCheckNoneClick()
	for k,v in pairs(CHD_gArrCheckboxes) do
		if v:IsEnabled() > 0 then
			v:SetChecked(nil);
		end
	end
end

function OnCHD_frmMainbtnCheckInvClick()
	for k,v in pairs(CHD_gArrCheckboxes) do
		if v:IsEnabled() > 0 then
			local b = v:GetChecked();
			v:SetChecked(not b);
		end
	end
end


function CHD_BankDel()
	CHD_SERVER_LOCAL.bank = {};
	CHD_SERVER_LOCAL.bank.mainbank = {};
	CHD_frmMainchbBankText:SetText(L.chbBank);
	CHD_Message(L.DeleteBank);
end;

function OnCHD_frmMainbtnBankDelClick()
	CHD.MessageBox.Title:SetText(L.DeleteBank);
	CHD.MessageBox.OnOK = CHD_BankDel;
	CHD.MessageBox:Show();
end

function CHD_QuestDel()
	CHD_SERVER_LOCAL.quest = {};
	CHD_frmMainchbQuestsText:SetText(L.chbQuests);
	CHD_Message(L.DeleteQuests);
end;

function OnCHD_frmMainbtnQuestDelClick()
	CHD.MessageBox.Title:SetText(L.DeleteQuests);
	CHD.MessageBox.OnOK = CHD_QuestDel;
	CHD.MessageBox:Show();
end

function CHD_TaxiDel()
	CHD_TAXI = {};
	CHD_frmMainchbTaxiText:SetText(L.chbTaxi);
	CHD_Message(L.DeleteTaxi);
end;

function OnCHD_frmMainbtnTaxiDelClick()
	CHD.MessageBox.Title:SetText(L.DeleteTaxi);
	CHD.MessageBox.OnOK = CHD_TaxiDel;
	CHD.MessageBox:Show();
end

function CHD_SkillSpellDel()
	CHD_SERVER_LOCAL.skillspell = {};
	CHD_frmMainchbSkillSpellText:SetText(L.chbSkillSpell);
	SetTooltip(CHD_frmMainchbSkillSpell, L.chbSkillSpell, L.ttchbSkillSpell);
	CHD_Message(L.DeleteSkillSpell);
end

function OnCHD_frmMainbtnSkillSpellDelClick()
	CHD.MessageBox.Title:SetText(L.DeleteSkillSpell);
	CHD.MessageBox.OnOK = CHD_SkillSpellDel;
	CHD.MessageBox:Show();
end


function OnCHD_frmMainbtnMinimizeClick()
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

function OnCHD_frmMainbtnHideClick()
	if CHD_frmMainpanSystem:IsVisible() then
		CHD_frmMainpanSystem:Hide();
	end
	CHD_frmMain:Hide();
end


function CHD_OnQueryQuestClick()
	QueryQuestsCompleted();
	if CHD_frmMainchbQuests:GetChecked() then
		CHD_SERVER_LOCAL.quest = CHD_trycall(CHD_GetQuestInfo) or {};
		CHD_frmMainchbQuestsText:SetText(L.chbQuests .. string.format(" (%d)", #CHD_SERVER_LOCAL.quest));
	else
		CHD_SERVER_LOCAL.quest = {};
		CHD_frmMainchbQuestsText:SetText(L.chbQuests .. " (0)");
	end
end;

function CHD_SlashCmdHandler(cmd)
	local cmdlist = {strsplit(" ", cmd)};

	if cmdlist[1] == "show" then
		CHD_frmMainpanSystem:SetBackdrop(nil);
		CHD_frmMainpanSystem:SetParent(CHD_frmMain);
		CHD_frmMainpanSystem:Show();
		CHD_frmMain:Show();
	elseif cmdlist[1] == "debug" then
		CHD_Debug();
	else
		CHD_Message(L.help1);
		CHD_Message(L.help2);
		CHD_Message(L.help3);
	end
end

function CHD_Init(self)
	SlashCmdList["CHD"] = CHD_SlashCmdHandler;
	SLASH_CHD1 = "/chardumps";
	SLASH_CHD2 = "/chd";

	self:EnableMouse(true);
	self:SetMovable(true);
	self:ClearAllPoints();
	self:SetPoint("CENTER", UIParent);
	self:SetWidth(FrameWidth);
	self:SetHeight(FrameHeight);
	self:SetFrameStrata("DIALOG");
	self:SetScript("OnLoad", CHD_OnLoad);
	self:SetScript("OnEvent", CHD_OnEvent);
	self:SetBackdrop(CHD_GetBackdrop());
	self:SetFrameStrata("DIALOG");
	self:Show();
	local title = self:CreateTitleRegion();
	title:SetAllPoints();

	local str = self:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	str:SetPoint("CENTER", self, 0, 0);
	str:SetPoint("TOP", self, 0, -5);
	str:SetTextColor(1.0, 1.0, 0.0, 1.0);
	str:SetText(L.AddonName .. " v " .. L.Version);

	-- frames
	local chb = CHD_CreateCheckBox("chbCrypt", 10, 10, self);

	CHD_CreateButton("btnCheckAll", 1 * (btnWidth + 3) + 5, chbHeight + 5, btnWidth, btnHeight, self);
	CHD_CreateButton("btnCheckNone", 2 * (btnWidth + 3) + 5, chbHeight + 5, btnWidth, btnHeight, self);
	CHD_CreateButton("btnCheckInv", 3 * (btnWidth + 3) + 5, chbHeight + 5, btnWidth, btnHeight, self);

	CHD_frmMainbtnCheckAll:SetScript("OnClick", OnCHD_frmMainbtnCheckAllClick);
	CHD_frmMainbtnCheckNone:SetScript("OnClick", OnCHD_frmMainbtnCheckNoneClick);
	CHD_frmMainbtnCheckInv:SetScript("OnClick", OnCHD_frmMainbtnCheckInvClick);

	local arrCheckboxName = {
		"chbCurrency", "chbInventory", "chbBags", "chbEquipment",
		"chbSpells", "chbMounts", "chbCritters", "chbGlyphs",
		"chbFriend", "chbActions", "chbMacro", "chbBind",
		"chbReputation", "chbAchievements",
		"chbArena",
		"chbTitles",
		"chbSkills",
		"chbQuestlog",
		"chbPet"
	};

	local cx, cy = 170, chbHeight;
	local x, y = 5, cy * 2 + 5;
	for i = 1, #arrCheckboxName do
		local chb = CHD_CreateCheckBox(arrCheckboxName[i], x, y, self);
		table.insert(CHD_gArrCheckboxes, chb);
		y = y + cy;
		if y > (chbHeight * 8 + 20) then
			x = x + cx;
			y = chbHeight;
		end
	end

	local arrCheckboxDinName = {"chbQuests", "chbBank", "chbTaxi", "chbSkillSpell"};
	for i = 1,#arrCheckboxDinName do
		local chb = CHD_CreateCheckBox(arrCheckboxDinName[i], 40, chbHeight * (i + 8) + 8, self);
		table.insert(CHD_gArrCheckboxes, chb);
	end

	local arrButtonName = {"btnQuestDel", "btnBankDel", "btnTaxiDel", "btnSkillSpellDel"};
	local arrButtonTitle = {"DeleteQuests", "DeleteBank", "DeleteTaxi", "DeleteSkillSpell"};
	for i = 1,#arrButtonName do
		local title = L[arrButtonTitle[i]];
		local btn = CHD_CreateButton(arrButtonName[i], 10, cy * (i + 8) + 8, btnWidth, btnHeight, self, title);
	end

	CHD_frmMainbtnQuestDel:SetScript("OnClick", OnCHD_frmMainbtnQuestDelClick);
	CHD_frmMainbtnBankDel:SetScript("OnClick", OnCHD_frmMainbtnBankDelClick);
	CHD_frmMainbtnTaxiDel:SetScript("OnClick", OnCHD_frmMainbtnTaxiDelClick);
	CHD_frmMainbtnSkillSpellDel:SetScript("OnClick", OnCHD_frmMainbtnSkillSpellDelClick);

	local btn = CHD_CreateButton("btnQuestQuery", 180, chbHeight * 9 + 8, 150, btnHeight, self);
	btn:SetScript("OnClick", CHD_OnQueryQuestClick);
	btn = CHD_CreateButton("btnDump", 0, 0, 100, btnHeight, self);
	btn:SetScript("OnClick", CHD_OnDumpClick);
	btn:ClearAllPoints();
	btn:SetPoint("BOTTOM", 0, 10);
	btn:SetPoint("RIGHT", -10, 0);

	btn = CHD_CreateButton("btnHide", 10, chbHeight * 12, btnWidth, btnHeight, self);
	btn:SetScript("OnClick", OnCHD_frmMainbtnHideClick);
	btn = CHD_CreateButton("btnMinimize", 10, chbHeight * 12, btnWidth, btnHeight, self);
	btn:SetScript("OnClick", OnCHD_frmMainbtnMinimizeClick);

	local btnW = btn:GetWidth(); -- CHD_frmMainbtnHide
	local panSystem = CreateFrame("Frame", self:GetName() .. "panSystem", self);
	panSystem:ClearAllPoints();
	panSystem:SetPoint("TOPRIGHT", self, 0, 0);
	panSystem:SetWidth(5 + 5 + btnW*2 + 3*3 + 5);
	panSystem:SetHeight(5 + btn:GetHeight() + 5);
	panSystem:Show();

	btn = getglobal(self:GetName() .. "btnHide");
	btn:SetParent(panSystem);
	btn:ClearAllPoints();
	btn:SetPoint("CENTER", panSystem, 0, 0);
	btn:SetPoint("RIGHT", panSystem, -11, 0);
	btn = getglobal(self:GetName() .. "btnMinimize");
	btn:SetParent(panSystem);
	btn:ClearAllPoints();
	btn:SetPoint("CENTER", panSystem, 0, 0);
	btn:SetPoint("RIGHT", panSystem, -14 - btnW, 0);

	CHD_CreateEditLabel("edtTotalTime", self, "BOTTOMRIGHT", -10, 62, 45, 20, L.TotalTime, 5);
	CHD_CreateEditLabel("edtLevelTime", self, "BOTTOMRIGHT", -10, 40, 45, 20, L.LevelTime, 5);

	CHD_OnLoad(self);
end
