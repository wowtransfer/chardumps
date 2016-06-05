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
  end

  if player ~= nil then
    widgets.fontStrHonor:SetText(L.Honor .. " = " .. player.honor);
    widgets.fontStrAp:SetText(L.Ap .. " = " .. player.ap);
    widgets.fontStrKills:SetText(L.Kills .. " = " .. player.kills);
  end

  local criteria = chardumps.dumper:GetEntity("criterias");
  if criteria ~= nil then
    print(criteria);
  end

  frame.widgets = widgets;
end

chardumps.entityViews = entityViews;
