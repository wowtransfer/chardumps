--[[

--]]
local L = LibStub('AceLocale-3.0'):GetLocale('chardumps');
local CHD_gArrCheckboxes = CHD_gArrCheckboxes or {};
CHD_OPTIONS = CHD_OPTIONS;

local chbWidth = 24;
local chbHeight = 22;
local btnWidth = 20;
local btnHeight = 20;

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
	else
		CHD_Message(L.help1);
		CHD_Message(L.help2);
		CHD_Message(L.help3);
	end
end

function CHD_Init(self)
	print("CHD_Init()");
	SlashCmdList["CHD"] = CHD_SlashCmdHandler;
	SLASH_CHD1 = "/chardumps";
	SLASH_CHD2 = "/chd";

	self:EnableMouse(true);
	self:SetMovable(true);
	self:ClearAllPoints();
	self:SetPoint("CENTER", UIParent);
	self:SetWidth(540);
	self:SetHeight(310);
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
	str:SetText("Chardumps v 1.8");

	-- frames
	local chb = CHD_CreateCheckBox("chbCrypt", 10, 10, self);

	-- OnCHD_frmMainbtnCheckAllClick
	local arrCheckBoxButtons = {"btnCheckAll", "btnCheckNone", "btnCheckInv"};
	for i = 1, #arrCheckBoxButtons do
		local name = arrCheckBoxButtons[i];
		local btn = CHD_CreateButton(name, i * (btnWidth + 3) + 5, chbHeight + 5, btnWidth, btnHeight, self);
		local fun = getglobal("On" .. self:GetName() .. name .. "Click");
		btn:SetScript("OnClick", fun);
	end

	local arrCheckboxName = {
		"chbCurrency", "chbInventory", "chbBags", "chbEquipment",
		"chbSpells", "chbMounts", "chbCritters", "chbGlyphs",
		"chbFriend", "chbActions", "chbMacro", "chbBind",
		"chbReputation", "chbAchievements",
		"chbArena",
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
		local name = "On" .. self:GetName() .. arrButtonName[i] .. "Click";
		local fun = getglobal(name);
		btn:SetScript("OnClick", fun);
	end

	local btn = CHD_CreateButton("btnQuestQuery", 180, chbHeight * 9 + 8, 150, btnHeight, self);
	btn:SetScript("OnClick", CHD_OnQueryQuestClick);
	btn = CHD_CreateButton("btnDump", 0, 0, 150, btnHeight, self);
	btn:SetScript("OnClick", CHD_OnDumpClick);
	btn:ClearAllPoints();
	btn:SetPoint("BOTTOM", 0, 10);
	btn:SetPoint("RIGHT", -10, 0);
	btn = CHD_CreateButton("btnHide", 10, chbHeight * 12, btnWidth, btnHeight, self);
	local fun = getglobal("On" .. self:GetName() .. "btnHide" .. "Click");
	btn:SetScript("OnClick", fun);
	btn = CHD_CreateButton("btnMinimize", 10, chbHeight * 12, btnWidth, btnHeight, self);
	fun = getglobal("On" .. self:GetName() .. "btnMinimize" .. "Click");
	btn:SetScript("OnClick", fun);

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

	CHD_OnLoad(self);
end
