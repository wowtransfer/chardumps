local chardumps = chardumps;
local L = chardumps:GetLocale();
local CHD_arrCheckboxes = CHD_arrCheckboxes or {};





function OnCHD_frmMainbtnCheckAllClick()
	for k,v in pairs(CHD_arrCheckboxes) do
		if v:IsEnabled() == 1 then
			v:SetChecked();
		end
	end
end

function OnCHD_frmMainbtnCheckNoneClick()
	for k,v in pairs(CHD_arrCheckboxes) do
		if v:IsEnabled() == 1 then
			v:SetChecked(nil);
		end
	end
end

function OnCHD_frmMainbtnCheckInvClick()
	for k,v in pairs(CHD_arrCheckboxes) do
		if v:IsEnabled() == 1 then
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

local function CHD_OnReloadClick()
	ReloadUI();
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

function CHD_Init(self)

	self:EnableMouse(true);
	self:SetMovable(true);
	self:ClearAllPoints();
	self:SetPoint("CENTER", UIParent);
	self:SetWidth(FrameWidth);
	self:SetHeight(FrameHeight);
	self:SetFrameStrata("DIALOG");
	self:SetScript("OnLoad", CHD_OnLoad);
	self:SetScript("OnEvent", CHD_OnEvent);
	self:SetBackdrop(chardumps.widgets:getBackdrop());
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
		"chbSpells", "chbMounts", "chbCritters", "chbGlyphs", "chbTalent",
		"chbFriend", "chbActions", "chbMacro", "chbBind",
		"chbReputation", "chbAchievements", "chbStatistic", "chbCriterias",
		"chbArena",
		"chbTitles",
		"chbSkills", "chbProfessions",
		"chbQuestlog",
		"chbPet"
	};

	local cx, cy = 170, chbHeight;
	local x, y = 5, cy * 2 + 5;
	for i = 1, #arrCheckboxName do
		chb = CHD_CreateCheckBox(arrCheckboxName[i], x, y, self);
		table.insert(CHD_arrCheckboxes, chb);
		y = y + cy;
		if y > (chbHeight * 8 + 20) then
			x = x + cx;
			y = chbHeight;
		end
	end

	local arrCheckboxDinName = {"chbQuests", "chbBank", "chbTaxi", "chbSkillSpell"};
	for i = 1, #arrCheckboxDinName do
		chb = CHD_CreateCheckBox(arrCheckboxDinName[i], 40, chbHeight * (i + 8) + 8, self);
		table.insert(CHD_arrCheckboxes, chb);
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

	btn = CHD_CreateButton("btnReload", 0, 0, 100, btnHeight, self);
	btn:SetScript("OnClick", CHD_OnReloadClick);
	btn:ClearAllPoints();
	btn:SetPoint("BOTTOM", 0, 10);
	btn:SetPoint("RIGHT", -10 - 5 - 100, 0);
	btn:Disable();

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

	CHD_OnLoad(self);
end
