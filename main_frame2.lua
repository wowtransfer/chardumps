local chardumps = chardumps;

local mainFrame = {
  entitiesData = {
    -- entityName = {
      -- checkbox (Yes/No),
      -- Data View (Frame),
      -- Delete Button (Button)
      -- Active Button (Button)
    -- }
  },
  captionHeight = 30,
  bttomPanelHeight = 40,
  defaultWidth = 600,
  defaultHeight = 440,
  defaultEntityWidth = 200,
  dataFrame = {
    defaultTop = 30,
    defaultLeft = 210,
    defaultWidth = 400,
    defaultHeight = 380,
  },
};

function mainFrame:CreateEntityFrame(name, parent)
  local frameName = chardumps.widgets:genFrameName();
  local frame = CreateFrame("ScrollingMessageFrame", frameName, parent);
  frame:ClearAllPoints();
  frame:SetPoint("TOPRIGHT", -10, -self.dataFrame.defaultTop);
  frame:SetWidth(self.dataFrame.defaultWidth);
  frame:SetHeight(self.dataFrame.defaultHeight);
  frame:SetBackdrop(chardumps.widgets:GetBackdrop());
  frame:SetFontObject("GameFontNormal");
  frame:Hide();

  return frame;
end

function mainFrame:init()
  local L = chardumps:GetLocale();
  local widgets = chardumps.widgets;
  local frame = CreateFrame("Frame", widgets:GetFrameName("frmMain"), UIParent);

  frame:EnableMouse(true);
  frame:SetMovable(true);
  frame:SetResizable(true); 
  frame:ClearAllPoints();
  frame:SetPoint("CENTER", UIParent);
  frame:SetWidth(self.defaultWidth);
  frame:SetHeight(self.defaultHeight);
  frame:SetFrameStrata("DIALOG");
  frame:SetScript("OnLoad", self.OnLoad);
  frame:SetScript("OnEvent", self.OnEvent);
  frame:SetBackdrop(chardumps.widgets:GetBackdrop());
  frame:SetFrameStrata("DIALOG");
  frame:Show();
  local titleRegion = frame:CreateTitleRegion();
  titleRegion:SetAllPoints();

  local str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
  str:SetPoint("CENTER", frame, 0, 0);
  str:SetPoint("TOP", frame, 0, -5);
  str:SetTextColor(1.0, 1.0, 0.0, 1.0);
  str:SetText(L.AddonName .. " v " .. L.Version);


  local btnW = widgets.btnWidth;
  local frameMin = CreateFrame("Frame", widgets:GetFrameName("minFrame", frame:GetName()), frame);
  -- frameMin:CreateTitleRegion():SetAllPoints(); TODO
  frameMin:ClearAllPoints();
  frameMin:SetPoint("TOPRIGHT", frame, 0, 0);
  frameMin:SetWidth(5 + 5 + btnW*3 + 3*3 + 5);
  frameMin:SetHeight(5 + widgets.btnHeight + 5);
  frameMin:Show();

  local btn;
  btn = widgets:CreateButton(frameMin);
  btn:SetText("x");
  btn:SetScript("OnClick", self.OnHideClick);
  btn:ClearAllPoints();
  btn:SetPoint("CENTER", 0, 0);
  btn:SetPoint("RIGHT", -11, 0);
  widgets:SetTooltip(btn, L.ttbtnHide);

  btn = widgets:CreateButton(frameMin);
  btn:SetText("_");
  btn:SetScript("OnClick", self.OnMinimizeClick);
  btn:ClearAllPoints();
  btn:SetPoint("CENTER", 0, 0);
  btn:SetPoint("RIGHT", -14 - btnW, 0);
  widgets:SetTooltip(btn, L.ttbtnMinimize);

  btn = widgets:CreateButton(frame, {name = "btnDump", cx = 100});
  btn:ClearAllPoints();
  btn:SetScript("OnClick", self.OnDumpClick);
  btn:SetPoint("BOTTOMRIGHT", -10, 10);

  self.btnSave = widgets:CreateButton(frame, {name = "btnReload", cx = 100});
  self.btnSave:ClearAllPoints();
  self.btnSave:SetScript("OnClick", self.OnSaveClick);
  self.btnSave:SetPoint("BOTTOMRIGHT", -10 - 5 - 100, 10);
  self.btnSave:Disable();


  -- Checkbox list
  
  -- checkbox
  -- button
  -- text

  local y = 30;
  local x = 0;
  local entityNames = chardumps.entityManager:GetNames();

  local btnDeleteAllTooltip = L.deleteAll;
  local btn = widgets:CreateButton(frame, {x = 10, y = -10, cx = 12, cy = 12, tooltipTitle = btnDeleteAllTooltip});
  btn:SetScript("OnClick", self.OnDeleteAllClick);
  local chbAllTooltip = L.ttchbAll;
  local chbAll = widgets:CreateCheckbox(frame, {x = 26, y = -10, cx = 14, cy = 14,
    tooltipTitle = chbAllTooltip, withoutText = true});
  chbAll:SetScript("OnClick", self.OnChbAllClick);

  -- Create entity's structure
  for i, name in pairs(entityNames) do
    local btn = widgets:CreateButton(frame, {x = 10, y = -y, cx = 12, cy = 12, tooltipTitle = "Delete"});
    btn.chdEntityName = name;
    local btnActive = widgets:CreateButton(frame, {x = 26, y = -y, cx = 12, cy = 12, tooltipTitle = "Active"});
    btnActive.chdEntityName = name;
    btnActive:SetScript("OnClick", function()
      mainFrame:SetActiveDataFrame(btnActive.chdEntityName);
    end);
    local text = L[name];
    local chb = widgets:CreateCheckbox(frame, {x = 40, y = -y, cx = 14, cy = 14, tooltipTitle = text, text = text});
    chb.chdEntityName = name;

    local entityData = {};
    entityData.checkbox = chb;
    entityData.deleteButton = btn;
    entityData.activeButton = btnActive;
    entityData.dataFrame = self:CreateEntityFrame(name, frame);
    self.entitiesData[name] = entityData;

    y = y + 14;
  end
  self:SetActiveDataFrame();

--[[
  -- frames
  local chb = CHD_CreateCheckBox("chbCrypt", 10, 10, frame);

  CHD_CreateButton("btnCheckAll", 1 * (btnWidth + 3) + 5, chbHeight + 5, btnWidth, btnHeight, frame);
  CHD_CreateButton("btnCheckNone", 2 * (btnWidth + 3) + 5, chbHeight + 5, btnWidth, btnHeight, frame);
  CHD_CreateButton("btnCheckInv", 3 * (btnWidth + 3) + 5, chbHeight + 5, btnWidth, btnHeight, frame);

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
    chb = CHD_CreateCheckBox(arrCheckboxName[i], x, y, frame);
    table.insert(CHD_arrCheckboxes, chb);
    y = y + cy;
    if y > (chbHeight * 8 + 20) then
      x = x + cx;
      y = chbHeight;
    end
  end

  local arrCheckboxDinName = {"chbQuests", "chbBank", "chbTaxi", "chbSkillSpell"};
  for i = 1, #arrCheckboxDinName do
    chb = CHD_CreateCheckBox(arrCheckboxDinName[i], 40, chbHeight * (i + 8) + 8, frame);
    table.insert(CHD_arrCheckboxes, chb);
  end

  local arrButtonName = {"btnQuestDel", "btnBankDel", "btnTaxiDel", "btnSkillSpellDel"};
  local arrButtonTitle = {"DeleteQuests", "DeleteBank", "DeleteTaxi", "DeleteSkillSpell"};
  for i = 1,#arrButtonName do
    local title = L[arrButtonTitle[i] ];
    local btn = CHD_CreateButton(arrButtonName[i], 10, cy * (i + 8) + 8, btnWidth, btnHeight, frame, title);
  end

  CHD_frmMainbtnQuestDel:SetScript("OnClick", OnCHD_frmMainbtnQuestDelClick);
  CHD_frmMainbtnBankDel:SetScript("OnClick", OnCHD_frmMainbtnBankDelClick);
  CHD_frmMainbtnTaxiDel:SetScript("OnClick", OnCHD_frmMainbtnTaxiDelClick);
  CHD_frmMainbtnSkillSpellDel:SetScript("OnClick", OnCHD_frmMainbtnSkillSpellDelClick);

  local btn = CHD_CreateButton("btnQuestQuery", 180, chbHeight * 9 + 8, 150, btnHeight, frame);
  btn:SetScript("OnClick", CHD_OnQueryQuestClick);

--]]

  self.frameMin = frameMin;
  self.frame = frame;
end

function mainFrame:SetActiveDataFrame(name)
  if name == nil then
    local entityNames = chardumps.entityManager:GetNames();
    name = entityNames[1];
  end
  if self.activeDataDrame ~= nil then
    self.activeDataDrame:Hide();
  end
  local frame = self.entitiesData[name].dataFrame;
  frame:Show();
  self.activeDataDrame = frame;
end

function mainFrame:OnHideClick()
  mainFrame.Hide();
end

function mainFrame:Hide()
  mainFrame.frameMin:Hide();
  mainFrame.frame:Hide();
end

function mainFrame:Show()
  mainFrame.frameMin:SetBackdrop(nil);
  mainFrame.frameMin:SetParent(mainFrame.frame);
  mainFrame.frameMin:Show();
  mainFrame.frame:Show();
end

function mainFrame:OnDumpClick()
  local L = chardumps:GetLocale();

  
  mainFrame.btnSave:Enable();
  chardumps.log.message(L.CreatedDump);
  chardumps.log.message(L.DumpDone);
end

function mainFrame:OnSaveClick()
	ReloadUI();
end

function mainFrame:OnDeleteAllClick()
  local L = chardumps:GetLocale();
  chardumps.widgets:ShowMessageBox(L.areyousure, function()
    print("Delete all...");
  end);
end

function mainFrame:OnChbAllClick()
  local checked = self:GetChecked();
  for name, data in pairs(mainFrame.entitiesData) do
    data.checkbox:SetChecked(checked);
  end
end

function mainFrame:OnMinimizeClick()
  local frame = mainFrame.frame;
  local frameMin = mainFrame.frameMin;
  if frame:IsVisible() then
    frameMin:SetBackdrop(chardumps.widgets:GetBackdrop());
    frameMin:SetParent(UIParent);
    frame:Hide();
    chardumps.options.mimimize = true;
  else
    frameMin:SetBackdrop(nil);
    frameMin:SetParent(frame);
    frame:Show();
    chardumps.options.mimimize = false;
  end
end

function mainFrame:OnLoad()

end

function mainFrame:OnEvent()

end

chardumps.mainFrame = mainFrame;
