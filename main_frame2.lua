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

function mainFrame:Init()
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

  self.chbCrypt = widgets:CreateCheckbox(frame, {name = "chbCrypt", cx = 14, cy = 14});
  self.chbCrypt:ClearAllPoints();
  self.chbCrypt:SetPoint("BOTTOMRIGHT", -10 - 5 - 300, 10);

  -- Checkbox list

  -- checkbox
  -- button
  -- text

  local y = 30;
  local x = 0;
  local entities = chardumps.entityManager:GetEntities();

  local btnDeleteAllTooltip = L.deleteAll;
  local btn = widgets:CreateButton(frame, {x = 10, y = -10, cx = 12, cy = 12, tooltipTitle = btnDeleteAllTooltip});
  btn:SetScript("OnClick", self.OnDeleteAllClick);
  local chbAllTooltip = L.ttchbAll;
  local chbAll = widgets:CreateCheckbox(frame, {x = 40, y = -10, cx = 14, cy = 14,
    tooltipTitle = chbAllTooltip, withoutText = true});
  chbAll:SetScript("OnClick", self.OnChbAllClick);

  -- Create entity's structure
  for name, entity in pairs(entities) do
    if not entity.always then
      local btn = widgets:CreateButton(frame, {x = 10, y = -y, cx = 12, cy = 12, tooltipTitle = "Delete"});
      btn.chdEntityName = name;
    end

    local btnActive = widgets:CreateButton(frame, {x = 26, y = -y, cx = 12, cy = 12, tooltipTitle = "Active"});
    btnActive.chdEntityName = name;
    btnActive:SetScript("OnClick", function()
      mainFrame:SetActiveDataFrame(btnActive.chdEntityName);
    end);
    local text = L[name];
    local chb = widgets:CreateCheckbox(frame, {x = 40, y = -y, cx = 14, cy = 14, tooltipTitle = text, text = text});
    chb.chdEntityName = name;
    if entity.always then
      chb:SetChecked(true);
      chb:Disable();
    end

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

  local chb = CHD_CreateCheckBox("chbCrypt", 10, 10, frame);



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

  local options = chardumps.options;
  -- read options
  for name, data in pairs(mainFrame.entitiesData) do
    if (data.checkbox:GetChecked()) then
      options:AddEntityForDump(name);
    end
  end
  if mainFrame.chbCrypt:GetChecked() then
    options:AddOptionForDump("crypt");
  end

  -- create dump...
  local dumpOption = options:GetOptionsFroDump();


  mainFrame.btnSave:Enable();
  chardumps.log:Message(L.CreatedDump);
  chardumps.log:Message(L.DumpDone);
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
  local entities = chardumps.entityManager:GetEntities();
  for name, data in pairs(mainFrame.entitiesData) do
    local entity = entities[name];
    if not(entity and entity.always) then
      data.checkbox:SetChecked(checked);
    end
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
