local chardumps = chardumps;

local entityViews = {};

function entityViews:UpdatePlayerView(frame)
  local player = chardumps.dumper:GetEntity("player");
  local values = {};
  local L = chardumps:GetLocale();

  --[[
  res.name             = UnitName("player");
  res.class            = class;
  res.level            = UnitLevel("player");
  res.race             = race;
  res.gender           = UnitSex("player");
  res.kills            = honorableKills;
  res.money            = math.floor(GetMoney() / 10000); -- convert to gold
  res.honor            = pvpCurrency.honor;
  res.ap               = pvpCurrency.ap;
  res.cp               = pvpCurrency.cp;

  +++
  ap (cp), honor, kills
  bg:
  - win (total), %
  arena:
  - 2x2 win (total), %
  - 3x3 win (total), %
  - 5x5 win (total), %
  --]]

  -- array, name value
  -- ap. honor, kills,
  local x = 5;
  local y, dy = -30, -12;

  local widgets = frame.widgets;
  if widgets == nil then
    widgets = {};
    local str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    y = y + dy;
    widgets.fontStrHonor = str;

    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    y = y + dy;
    widgets.fontStrAp = str;

    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    y = y + dy;
    widgets.fontStrKills = str;

    -- Battlegrounds
    y = y + dy;
    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    widgets.fontStrBgTotal = str;

    y = y + dy;
    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    widgets.fontStrAlteracValley = str;

    y = y + dy;
    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    widgets.fontStrEyeOfTheStorm = str;
    
    y = y + dy;
    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    widgets.fontStrArathiBasin = str;
    
    y = y + dy;
    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    widgets.fontStrWarsongGulch = str;
    
    y = y + dy;
    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    widgets.fontStrIsleOfConquest = str;

  end

  if player ~= nil then
    widgets.fontStrHonor:SetText(L.Honor .. " = " .. player.honor);
    widgets.fontStrAp:SetText(L.Ap .. " = " .. player.ap);
    widgets.fontStrKills:SetText(L.Kills .. " = " .. player.kills);
  end

  local criterias = chardumps.dumper:GetEntity("statistic");
  local sumWin, sumTotal = 0, 0;
  local formatBgValues = function(win, total)
    win = win or 0;
    total = total or 0;
    if (win > 0 and total > 0) then
      return string.format("%4i/%4i (%2.1f%%)", win, total, win / total * 100);
    end
    return "";
  end
  local setBgValue = function(fontStr, bgName, winCriteriaId, totalCriteriaId)
    local win, total;
    win = criterias[winCriteriaId] or 0;
    total = criterias[totalCriteriaId] or 0;
    local s;
    if (win > 0 and total > 0) then
      s = formatBgValues(win, total);
      sumWin = sumWin + win;
      sumTotal = sumTotal + total;
    else
      s = "";
    end
    fontStr:SetText(s .. " " .. bgName);
  end

  if criterias ~= nil then
    local bgWinAndTotalCriterias = {
      ["AlteracValley"]  = {["win"] = 100, ["total"] = 104, ["text"] = L["Alterac Valley"]},
      ["EyeOfTheStorm"]  = {["win"] = 5745, ["total"] = 105, ["text"] = L["Eye of the Storm"]},
      ["ArathiBasin"]    = {["win"] = 102, ["total"] = 106, ["text"] = L["Arathi Basin"]},
      ["WarsongGulch"]   = {["win"] = 140, ["total"] = 5747, ["text"] = L["Warsong Gulch"]},
      ["IsleOfConquest"] = {["win"] = 11959, ["total"] = 11958, ["text"] = L["Isle of Conquest"]},
    };
    for name, t in pairs(bgWinAndTotalCriterias) do
      setBgValue(widgets["fontStr" .. name], t.text, t.win, t.total);
    end
    widgets.fontStrBgTotal:SetText(L["Battleground"] .. " ".. formatBgValues(sumWin, sumTotal));
  end

  frame.widgets = widgets;
end


function entityViews:UpdateInventoryView(frame)
  local inventory = chardumps.dumper:GetEntity("inventory");
  local L = chardumps:GetLocale();
  local x = 5;
  local startY = 30;
  local y, dy = -startY, -12;

  local widgets = frame.widgets;
  if widgets == nil then
    widgets = {};
 
    local scrollingMessageFrame = CreateFrame("ScrollingMessageFrame", nil, frame);
    scrollingMessageFrame:SetPoint("TOPLEFT", 10, -startY);
    scrollingMessageFrame:SetPoint("BOTTOMRIGHT", -10, 10);
    scrollingMessageFrame:SetFontObject(GameFontNormal);
    scrollingMessageFrame:SetTextColor(1, 1, 1, 1);
    scrollingMessageFrame:SetJustifyH("LEFT");
    scrollingMessageFrame:SetHyperlinksEnabled(true);
    scrollingMessageFrame:SetFading(false);
    scrollingMessageFrame:SetInsertMode("bottom");
    scrollingMessageFrame:Show();

    local texture = scrollingMessageFrame:CreateTexture();
    texture:SetAllPoints();
    texture:SetTexture(.5, .5, .5, 1);

    local scrollBar = CreateFrame("Slider", nil, frame, "UIPanelScrollBarTemplate")
    scrollBar:ClearAllPoints();
    scrollBar:SetPoint("RIGHT", frame, "RIGHT", 0, 0);
    scrollBar:SetSize(30, frame:GetHeight() - startY - 10 - 10);
    scrollBar:SetMinMaxValues(0, 100);
    scrollBar:SetValueStep(1);
    scrollBar.scrollStep = 1;
    scrollBar:SetScript("OnValueChanged", function(self, value)
      local _, maxValue = scrollBar:GetMinMaxValues();
      scrollingMessageFrame:SetScrollOffset(maxValue - value);
   end)

   widgets.scrollBar = scrollBar;
   widgets.scrollMessageFrame = scrollingMessageFrame;
  end

  if inventory ~= nil then
    local index1 = 1;
    widgets.scrollMessageFrame:Clear();
    local len = chardumps:GetTableLength(inventory);
    if len > 0 then
      widgets.scrollMessageFrame:SetMaxLines(len);
    end
    local maxValue = len - 26;
    if maxValue < 0 then
      maxValue = 0;
    end
    widgets.scrollBar:SetMinMaxValues(0, maxValue);
    widgets.scrollBar:SetValue(0);
    for i, item in pairs(inventory) do
      local itemId = item["I"] or 0;
      local itemName, itemLink = GetItemInfo(itemId);
      if itemLink then
        widgets.scrollMessageFrame:AddMessage(index1 .. " " .. itemLink);
        index1 = index1 + 1;
      end
    end
  end

  frame.widgets = widgets;
end

chardumps.entityViews = entityViews;
