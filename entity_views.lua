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
    str:SetText(L["Battleground"]);


    y = y + dy;
    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    widgets.fontStrBgAlteracValley = str;

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


    y = y + dy;
    str = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    str:SetPoint("TOPLEFT", x, y);
    str:SetTextColor(1, 1, 1);
    widgets.fontStrBgTotal = str;
  end

  if player ~= nil then
    widgets.fontStrHonor:SetText(L.Honor .. " = " .. player.honor);
    widgets.fontStrAp:SetText(L.Ap .. " = " .. player.ap);
    widgets.fontStrKills:SetText(L.Kills .. " = " .. player.kills);
  end

  local setBgValue = function(fontStr, bgName, winCriteriaId, totalCriteriaId)
    local criterias = chardumps.dumper:GetEntity("statistic");
    local win, total = 0, 0;
    win = criterias[winCriteriaId];
    total = criterias[totalCriteriaId];
    local s;
    if (win > 0 and total > 0) then
      s = string.format("%4i/%4i (%2.1f%%)", win, total, win / total * 100);
    else
      s = "";
    end
    fontStr:SetText(s .. " " .. bgName);
  end

  local criterias = chardumps.dumper:GetEntity("statistic");
  if criterias ~= nil then
    --[[
    [100] = "win Alterac Valley",
    [104] = "Alterac Valley",
    [5745] = "win Eye of the Stormи",
    [105] = "Eye of the Storm",
    [102] = "win Arathi Basin",
    [106] = "Arathi Basin",
    [140] = "win Warsong Gulch",
    [5747] = "Warsong Gulch",
    [11959] = "win Isle of Conquest",
    [11958] = "Isle of Conquest",
    --]]
    -- widgets.fontStrBgTotal
    setBgValue(widgets.fontStrBgAlteracValley, L["Alterac Valley"], 100, 104);
    setBgValue(widgets.fontStrEyeOfTheStorm, L["Eye of the Storm"], 5745, 105);
    setBgValue(widgets.fontStrArathiBasin, L["Arathi Basin"], 102, 106);
    setBgValue(widgets.fontStrWarsongGulch, L["Warsong Gulch"], 140, 5747);
    setBgValue(widgets.fontStrIsleOfConquest, L["Isle of Conquest"], 11959, 11958);
  end

  frame.widgets = widgets;
end

chardumps.entityViews = entityViews;
