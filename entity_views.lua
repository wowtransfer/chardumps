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

chardumps.entityViews = entityViews;
