local chardumps = chardumps;

local mainFrame = {
  entitiesData = {
  -- entityName = {
  -- checkbox (Yes/No),
  -- Data View (Frame),
  -- Delete Button (Button)
  -- Active Button (Button)
  -- Press dump button font
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
  frame.chdEntityName = name;

  return frame;
end

function mainFrame:RegisterWorkEvents(frame)
  if not frame then
    frame = self.frame;
  end
  local events = {
    "TAXIMAP_OPENED", "VARIABLES_LOADED", "BANKFRAME_OPENED", "PLAYER_LEAVING_WORLD",
    "TRADE_SKILL_SHOW", "QUEST_DETAIL", "QUEST_PROGRESS",
    "QUEST_QUERY_COMPLETE", "ADDON_LOADED", "PLAYER_LOGOUT", -- UNIT_QUEST_LOG_CHANGED
    "QUEST_TURNED_IN",
  }
  frame:UnregisterAllEvents();
  for _, name in pairs(events) do
    frame:RegisterEvent(name);
  end
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
  local addonTitle = L.AddonName .. " " .. L.Version .. " - http://wowtransfer.com";
  str:SetText(addonTitle);


  local btnW = widgets.btnWidth;
  local frameMin = CreateFrame("Frame", widgets:GetFrameName("minFrame", frame:GetName()), frame);
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

  self.chbCrypt = widgets:CreateCheckbox(frame, {name = "chbCrypt", cx = 14, cy = 14, text = L["chbCrypt"]});
  self.chbCrypt:ClearAllPoints();
  self.chbCrypt:SetPoint("BOTTOMRIGHT", -10 - 5 - 300, 10);

  self.chbEvents = widgets:CreateCheckbox(frame, {name = "chbEvents", cx = 14, cy = 14, text = "Events"});
  self.chbEvents:ClearAllPoints();
  self.chbEvents:SetPoint("BOTTOMRIGHT", -10 - 5 - 370, 10);
  self.chbEvents:SetScript("OnClick", function ()
    if mainFrame.chbEvents:GetChecked() then
      mainFrame.frame:RegisterAllEvents();
    else
      mainFrame:RegisterWorkEvents();
    end
  end);

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
  local chbAll = widgets:CreateCheckbox(frame, {x = 28, y = -10, cx = 14, cy = 14,
    tooltipTitle = chbAllTooltip, withoutText = true});
  chbAll:SetScript("OnClick", self.OnChbAllClick);

  -- Create entity's structure
  for name, entity in pairs(entities) do
    if not entity.always then
      local btn = widgets:CreateButton(frame, {x = 10, y = -y, cx = 12, cy = 12, tooltipTitle = L.Delete});
      btn.chdEntityName = name;
      btn:SetScript("OnClick", function()
        mainFrame:DeleteEntityData(btn.chdEntityName);
      end)
    end

    local text = L[name];

    local btnActive = widgets:CreateButton(frame, {x = 42, y = -y, cx = 150, cy = 14, text = text});
    btnActive.chdEntityName = name;
    local btnActiveFont = btnActive:GetFontString();
    btnActiveFont:SetJustifyH("LEFT"); -- TODO: do not work
    btnActiveFont:SetTextColor(1, 1, 1);
    btnActive:SetScript("OnClick", function(self)
      mainFrame:SetActiveDataFrame(self.chdEntityName);
    end);

    local chb = widgets:CreateCheckbox(frame, {x = 28, y = -y, cx = 14, cy = 14, tooltipTitle = text, withoutText = true});
    chb.chdEntityName = name;
    if entity.disable then
      chb:SetChecked(false);
      chb:Disable();
      btnActiveFont:SetTextColor(0.5, 0.5, 0.5);
    elseif entity.always then
      chb:SetChecked(true);
      chb:Disable();
    end

    chb:SetScript("OnClick", function(self)
      print(self:GetName(), self.chdEntityName);
      mainFrame:SetActiveDataFrame(self.chdEntityName);
    end);

    local entityData = {};
    entityData.checkbox = chb;
    entityData.deleteButton = btn;
    entityData.dataFrame = self:CreateEntityFrame(name, frame);
    entityData.activeButton = btnActive;
    self.entitiesData[name] = entityData;

    y = y + 14;
  end
  self:CreateEntityWidgets(frame);
  self:SetActiveDataFrame();
  self:RegisterWorkEvents(frame);

  self.frameMin = frameMin;
  self.frame = frame;
end

function mainFrame:CreateEntityWidgets(frame)
  local L = chardumps:GetLocale();

  for name, data in pairs(self.entitiesData) do
    local entityFrame = data.dataFrame;
    local font = entityFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
    font:SetPoint("TOPLEFT", 50, -5);
    font:SetText(L[name]);

    local pressDumpButtonWarning = entityFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    pressDumpButtonWarning:SetPoint("TOPLEFT", 10, -30);
    pressDumpButtonWarning:SetText(L["Press \"Dump\" button"]);
    pressDumpButtonWarning:SetTextColor(chardumps.config:GetWarningColor());
    data.pressDumpBtnText = pressDumpButtonWarning;
  end

  local top = 25;

  local questData = self.entitiesData["quest"];
  if questData then
    local btnQueryQuest = chardumps.widgets:CreateButton(questData.dataFrame, {x = 5, y = -top, cx = 150, name = "btnQuestQuery"});
    btnQueryQuest:SetScript("OnClick", function()
      if type(QueryQuestsCompleted) == "function" then
        QueryQuestsCompleted();
      else
        self:OnQuestQueryComplete();
      end
    end);
  end
end

function mainFrame:SetActiveDataFrame(name)
  local entities = chardumps.entityManager:GetEntities();
  if name == nil then
    name = "player";
  end
  local entity = entities[name];
  if not entity then
    return
  end

  if self.activeDataDrame ~= nil then
    self.activeDataDrame:Hide();
    local name = self.activeDataDrame.chdEntityName;
    local entity = entities[name];
    local activeButton = self.entitiesData[name].activeButton;
    if not entity.disable and activeButton then
      activeButton:GetFontString():SetTextColor(1, 1, 1);
    end
  end
  local frame = self.entitiesData[name].dataFrame;
  frame:Show();
  local activeButton = self.entitiesData[name].activeButton;
  if not entity.disable and activeButton then
    activeButton:GetFontString():SetTextColor(1, 1, 0);
  end

  self.activeDataDrame = frame;
end

function mainFrame:UpdateEntityText(name, count)
  local data = self.entitiesData[name];
  if data then
    local entity = chardumps.entityManager:GetEntity(name);
    local chb = data.checkbox;
    local activeButton = data.activeButton;
    local disable = entity and entity.disable;
    if activeButton and not disable then
      local L = chardumps:GetLocale();
      local entityName = L[name];
      count = count or 0;
      entityName = entityName .. " (" .. count .. ")";
      activeButton:SetText(entityName);
    end
  end
end

function mainFrame:UpdateEntityView(name)
  local data = self.entitiesData[name];
  if data then
    local entityFrame = data.dataFrame;
    local functionName = "Update" .. chardumps:Ucfirst(name) .. "View";
    local views = chardumps.entityViews;
    local entityViewFun = views[functionName];
    if type(entityViewFun) == "function" and entityFrame then
      views[functionName](views, entityFrame);
    end
  end
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
  options:ClearForDump();
  -- read options
  for name, data in pairs(mainFrame.entitiesData) do
    if (data.checkbox:GetChecked()) then
      data.pressDumpBtnText:Hide();
      options:AddEntityForDump(name);
    end
  end
  if mainFrame.chbCrypt:GetChecked() then
    options:AddOptionForDump("crypt");
  end

  local dumpOption = options:GetOptionsForDump();
  chardumps.dumper:Dump(dumpOption);

  mainFrame.btnSave:Enable();
  chardumps.log:Message(L.CreatedDump);
  chardumps.log:Message(L.DumpDone);
end

function mainFrame:OnSaveClick()
  ReloadUI();
end

function mainFrame:DeleteEntityData(entityName)
  local entities = chardumps.entityManager:GetEntities();
  local entity = entities[entityName];
  if entity then
    if entity.dynamic then
      local L = chardumps:GetLocale();
      chardumps.widgets:ShowMessageBox(L.areyousure, function()
        chardumps.dumper:DeleteEntityData(entityName);
      end);
    else
      chardumps.dumper:DeleteEntityData(entityName);
    end
  end
end

function mainFrame:OnDeleteAllClick()
  local L = chardumps:GetLocale();
  chardumps.widgets:ShowMessageBox(L.areyousure, function()
    chardumps.dumper:Clear();
  end);
end

function mainFrame:OnChbAllClick()
  local checked = self:GetChecked();
  local entities = chardumps.entityManager:GetEntities();
  for name, data in pairs(mainFrame.entitiesData) do
    local entity = entities[name];
    local always = entity and entity.always;
    local disable = entity and entity.disable;
    if not(always or disable) then
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
    chardumps.options.minimize = true;
  else
    frameMin:SetBackdrop(nil);
    frameMin:SetParent(frame);
    frame:Show();
    chardumps.options.minimize = false;
  end
end

---
-- @return #boolean
function mainFrame:IsEntityChecked(name)
  local data = self.entitiesData[name];
  if data then
    return data.checkbox:GetChecked();
  end
  return false;
end

---
-- @return #boolean
function mainFrame:SetEntityChecked(name, value)
  local data = self.entitiesData[name];
  if data then
    value = value or true;
    data.checkbox:SetChecked(value);
  end
end

function mainFrame:OnEvent(event, ...)
  chardumps.log:Debug(event);
  if "BANKFRAME_OPENED" == event then
    local bankData = {};
    if mainFrame:IsEntityChecked("bank") then
      bankData = chardumps:TryCall(chardumps.dumper.GetBankData) or {};
    end
    chardumps.dumper:SetDynamicData("bank", bankData);
    local count = chardumps.dumper:GetBankItemsCount();
    mainFrame:UpdateEntityText("bank", count);
  elseif "PLAYER_LEAVING_WORLD" == event then
    mainFrame:OnPlayerLeavingWorld();
  elseif "TAXIMAP_OPENED" == event then
    mainFrame:OnTaximapOpened();
  elseif "ADDON_LOADED" == event then
    mainFrame:OnAddonLoaded(arg1);
  elseif "VARIABLES_LOADED" == event then
    mainFrame:OnVariablesLoaded();
  elseif "TRADE_SKILL_SHOW" == event then
    mainFrame:OnTradeSkillShow(arg1);
  elseif "QUEST_TURNED_IN" == event then
    if chardumps:GetPatchVersion() <= 3 then
      return
    end
    local L = chardumps:GetLocale();
    local questId = GetQuestID();
    chardumps.log:Message(L.Quest .. " (ID = " .. questId .. ") \124cFF00FF00 " .. L.QuestCompleted .. "\r");
  elseif "QUEST_DETAIL" == event or "QUEST_PROGRESS" == event then
    if chardumps:GetPatchVersion() <= 3 then
      return
    end
    local L = chardumps:GetLocale();
    local questIds = chardumps.dumper:GetDynamicData("quest");
    local questId = GetQuestID();
    local s = L.Quest .. " (ID = " .. questId .. ")";
    if questIds[questId] then
      s = s .. " \124cFF00FF00 " .. L.QuestWasCompleted  .. "\r";
    end
    chardumps.log:Message(s);
  elseif "QUEST_QUERY_COMPLETE" == event then
    mainFrame:OnQuestQueryComplete();
  elseif "PLAYER_LOGOUT" == event then
    chardumps.log:Debug(event .. " " .. arg1 .. " " .. arg2);
  else
    chardumps.log:Debug(event, arg1, arg2, arg3);
  end
end

function mainFrame:ApplyOptions()
  local entities = chardumps.entityManager:GetEntities();
  local playerOptions = chardumps:GetPlayerOptions();
  playerOptions.entities = playerOptions.entities or {};

  for name, checked in pairs(playerOptions.entities) do
    if entities[name] and not entities[name].disable then
      self:SetEntityChecked(name, checked);
    end
  end
  if not playerOptions.debug then
    playerOptions.crypt = true;
  end
  chardumps.options:SetDebug(playerOptions.debug);
  self.chbCrypt:SetChecked(playerOptions.crypt);
  if playerOptions.minimize then
    self:OnMinimizeClick();
  end
end

function mainFrame:SetDebug(value)
  if value then
    self.chbCrypt:Show();
    self.chbEvents:Show();
  else
    self.chbCrypt:Hide();
    self.chbEvents:Hide();
  end
end

function mainFrame:OnQuestQueryComplete()
  local questIds = chardumps.dumper:GetQuestDataReal();
  local count = chardumps:GetTableLength(questIds);
  self:UpdateEntityText("quest", count);
end

-- http://wowprogramming.com/docs/api_categories#tradeskill
function mainFrame:OnTradeSkillShow(flags)
  if not mainFrame:IsEntityChecked("skillspell") then
    return
  end

  local L = chardumps:GetLocale();
  -- Returns information about the current trade skill
  local tradeskillName, rank, maxLevel = GetTradeSkillLine();
  if (nil == tradeskillName or "UNKNOWN" == tradeskillName) then
    return
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

  chardumps.log:Message(string.format(L.GetSkillSpell, tradeskillName));
  local res = {};
  for i = 1, GetNumTradeSkills() do
    local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(i);
    if (skillType and "header" ~= skillType) then
      local link = GetTradeSkillRecipeLink(i);
      local spellID = tonumber(strmatch(link, "\124Henchant:(%d+)"));
      if spellID then
        table.insert(res, spellID);
      end
    end
  end
  table.sort(res);

  local tradeLink = GetTradeSkillListLink();
  local count = #res;
  chardumps.log:Message(string.format(L.TradeSkillFound, count));

  -- isLinked, name = IsTradeSkillLinked()
  local isLinked = IsTradeSkillLinked();
  if isLinked then
    return
  end

  local data = chardumps.dumper:GetDynamicData("skillspell");
  data[tradeskillName] = res;
  chardumps.dumper:SetDynamicData("skillspell", data);

  if count > 0 then
    local s = L.ttchbSkillSpell .. "\n";
    -- Update text on the Tooltip
    for k,v in pairs(data) do
      s = s .. "- " .. k .. " (" .. #v .. ")\n";
    end
    local data = mainFrame.entitiesData["skillspell"];
    if data then
      chardumps.widgets:SetTooltip(data.checkbox, L.chbSkillSpell, s);
    end
    mainFrame:UpdateEntityText("skillspell", chardumps.dumper:GetSkillspellItemsCount());
  end
end

function mainFrame:OnTaximapOpened()
  if not mainFrame:IsEntityChecked("taxi") then
    return
  end

  local res = {};
  --[[

  -1 - Cosmic map

  0 - Azeroth

  1 - Kalimdor

  2 - Eastern Kingdoms

  3 - Outland

  4 - Northrend

  5 - The Maelstrom

  6 - Pandaria

  --]]
  local continent = GetCurrentMapContinent();
  if (continent < 1) or (continent > chardumps.MAX_NUM_CONTINENT) then
    return
  end

  local L = chardumps:GetLocale();
  local arrContinent = {L.Kalimdor, L.EasternKingdoms, L.Outland, L.Northrend};
  chardumps.log:Message(L.GetTaxi .. arrContinent[continent]);
  for i = 1, NumTaxiNodes() do
    table.insert(res, TaxiNodeName(i));
  end
  local taxiData = chardumps.dumper:GetDynamicData("taxi");
  taxiData[continent] = res;
  chardumps.dumper:SetDynamicData("taxi", taxiData);

  mainFrame:UpdateEntityText("taxi", chardumps.dumper:GetTaxiItemsCount());

  chardumps.log:Message(L.CountOfTaxi .. tostring(#res));
end

function mainFrame:OnAddonLoaded(addonName)
  if addonName ~= "chardumps" then
    return
  end

  local L = chardumps:GetLocale();
  chardumps.log:Message(L.AddonName .. " " .. L.Version .. " - http://wowtransfer.com");
end

function mainFrame:OnPlayerLeavingWorld()
  local options = chardumps.options;

  local entities = {};
  for name, data in pairs(self.entitiesData) do
    entities[name] = data.checkbox:GetChecked();
  end

  -- TODO: create method
  local playerOptions = {};

  playerOptions.entities = entities;
  playerOptions.crypt = self.chbCrypt:GetChecked();
  playerOptions.debug = self.chbDebug:GetChecked();
  playerOptions.minimize = options.minimize;
  -- TODO: may be errors on the reading
  playerOptions.dynamicData = chardumps.dumper:GetDynamicDataAll();

  chardumps:SetPlayerOptions(playerOptions);
end

function mainFrame:OnVariablesLoaded()
  CHD_CLIENT = {};

  local playerOptions = chardumps:GetPlayerOptions();
  chardumps.dumper:SetDynamicDataAll(playerOptions.dynamicData);
  chardumps.dumper:UpdateDynamicAllFrames();

  self:ApplyOptions();
end

chardumps.mainFrame = mainFrame;
