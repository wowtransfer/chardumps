local chardumps = chardumps;

local mainFrame = {};

function mainFrame:init()
  local L = chardumps:GetLocale();
  local widgets = chardumps.widgets;
  print("main name:", widgets:GetFrameName("frmMain"));
  print("main form:", _G[widgets:GetFrameName("frmMain")]);
  local frame = CreateFrame("Frame", widgets:GetFrameName("frmMain"), UIParent);
  print("main form:", _G[widgets:GetFrameName("frmMain")]);
  print("frame", frame:GetName());

  frame:EnableMouse(true);
  frame:SetMovable(true);
  frame:ClearAllPoints();
  frame:SetPoint("CENTER", UIParent);
  frame:SetWidth(500);
  frame:SetHeight(400);
  frame:SetFrameStrata("DIALOG");
  frame:SetScript("OnLoad", self.OnLoad);
  frame:SetScript("OnEvent", self.OnEvent);
  frame:SetBackdrop(chardumps.widgets:GetBackdrop());
  frame:SetFrameStrata("DIALOG");
  frame:Show();
  local title = frame:CreateTitleRegion();
  title:SetAllPoints();

  local str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
  str:SetPoint("CENTER", frame, 0, 0);
  str:SetPoint("TOP", frame, 0, -5);
  str:SetTextColor(1.0, 1.0, 0.0, 1.0);
  str:SetText(L.AddonName .. " v " .. L.Version);

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

  btn = CHD_CreateButton("btnDump", 0, 0, 100, btnHeight, frame);
  btn:SetScript("OnClick", CHD_OnDumpClick);
  btn:ClearAllPoints();
  btn:SetPoint("BOTTOM", 0, 10);
  btn:SetPoint("RIGHT", -10, 0);

  btn = CHD_CreateButton("btnReload", 0, 0, 100, btnHeight, frame);
  btn:SetScript("OnClick", CHD_OnReloadClick);
  btn:ClearAllPoints();
  btn:SetPoint("BOTTOM", 0, 10);
  btn:SetPoint("RIGHT", -10 - 5 - 100, 0);
  btn:Disable();

  btn = CHD_CreateButton("btnHide", 10, chbHeight * 12, btnWidth, btnHeight, frame);
  btn:SetScript("OnClick", OnCHD_frmMainbtnHideClick);
  btn = CHD_CreateButton("btnMinimize", 10, chbHeight * 12, btnWidth, btnHeight, frame);
  btn:SetScript("OnClick", OnCHD_frmMainbtnMinimizeClick);

  local btnW = btn:GetWidth();
  local panSystem = CreateFrame("Frame", frame:GetName() .. "panSystem", frame);
  panSystem:ClearAllPoints();
  panSystem:SetPoint("TOPRIGHT", frame, 0, 0);
  panSystem:SetWidth(5 + 5 + btnW*2 + 3*3 + 5);
  panSystem:SetHeight(5 + btn:GetHeight() + 5);
  panSystem:Show();

  btn = getglobal(frame:GetName() .. "btnHide");
  btn:SetParent(panSystem);
  btn:ClearAllPoints();
  btn:SetPoint("CENTER", panSystem, 0, 0);
  btn:SetPoint("RIGHT", panSystem, -11, 0);
  btn = getglobal(frame:GetName() .. "btnMinimize");
  btn:SetParent(panSystem);
  btn:ClearAllPoints();
  btn:SetPoint("CENTER", panSystem, 0, 0);
  btn:SetPoint("RIGHT", panSystem, -14 - btnW, 0);

--]]

  self.frame = frame;
end

function mainFrame:OnLoad()

end

function mainFrame:OnEvent()

end

chardumps.mainFrame = mainFrame;
