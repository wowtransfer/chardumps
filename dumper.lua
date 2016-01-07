local chardumps = chardumps;
local dumper = {
  -- each field are entity name
	dump = {},
	dynamicDump = {}, -- taxi, bank, quest, skillspell
};

---
-- @param table options What is saved
function dumper:Dump(options)
  local dump = {};

  dump.global = chardumps:TryCall(self.GetGlobalData) or {};
  dump.player = chardumps:TryCall(self.GetPlayerData) or {};
  dump.glyph  = chardumps:TryCall(self.GetGlyphData) or {};
  dump.currency = chardumps:TryCall(self.GetCurrencyData) or {};
  dump.spell  = chardumps:TryCall(self.GetSpellData) or {};
  
  --dump.glyph  = chardumps:TryCall(self.) or {};

  if options.crypt then
    -- TODO: crypt it
    CHD_CLIENT = dump;
  else
    CHD_CLIENT = dump;
  end
  self.dump = dump;
end

---
-- Get entity field
function dumper:GetEntity(name)
  if self.dump[name] ~= nil then
    return self.dump[name];
  end
end

function dumper:Clear()
  self.dump = {};
end

function dumper:DeleteEntityData(name)
  self.dump[name] = nil;
end

function dumper:Init()
  self:Clear();
end

function dumper:GetAchievementData()

end

function dumper:GetActionData()

end

function dumper:GetBagData()

end

function dumper:GetBankData()
  local L = chardumps:GetLocale();
  local res = {};

  -- NUM_BAG_SLOTS+1 to NUM_BAG_SLOTS+NUM_BANKBAGSLOTS are your bank bags
  res.mainbank = {};
  local itemCount = 0;

  chardumps.log:Message(L.GetBank);
  for i = 40, 74 do -- main bank
    local itemLink = GetInventoryItemLink("player", i)
    if itemLink then
      local count = GetInventoryItemCount("player",i)
      for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do
        local tmpItem = {
          ["I"] = tonumber(id)
        };
        if count > 1 then tmpItem["N"] = count end
        if tonumber(enchant) > 0 then tmpItem["H"] = tonumber(enchant) end
        if tonumber(gem1) > 0 then tmpItem["G1"] = tonumber(gem1) end
        if tonumber(gem2) > 0 then tmpItem["G2"] = tonumber(gem2) end
        if tonumber(gem3) > 0 then tmpItem["G3"] = tonumber(gem3) end

        res.mainbank[i] = tmpItem;
      end
      itemCount = itemCount + 1;
    end
  end
  chardumps.log:Message(string.format(L.ReadMainBankBag, itemCount));

  local j = 1;
  for i = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do -- and 7 bank bags
    res[j] = {};
    local bag = res[j];
    itemCount = 0;
    for slot = 1, GetContainerNumSlots(i) do
      local itemLink = GetContainerItemLink(i, slot)
      if itemLink then
        local _, count = GetContainerItemInfo(i, slot);
        for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink, ".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do
          local tmpItem = {
            ["I"] = tonumber(id)
          };
          if count > 1 then tmpItem["N"] = count end
          if tonumber(enchant) > 0 then tmpItem["H"] = tonumber(enchant) end
          if tonumber(gem1) > 0 then tmpItem["G1"] = tonumber(gem1) end
          if tonumber(gem2) > 0 then tmpItem["G2"] = tonumber(gem2) end
          if tonumber(gem3) > 0 then tmpItem["G3"] = tonumber(gem3) end

          bag[slot] = tmpItem;
        end
        itemCount = itemCount + 1;
      end
    end
    chardumps.log:Message(string.format(L.ScaningBankTotal, j, itemCount));
    i = i + 1;
    j = j + 1;
  end

  return res;
end

function dumper:GetBindData()

end

function dumper:GetCriteriasData()

end

function dumper:GetCritterData()

end

function dumper:GetCurrencyData()
  local L = chardumps:GetLocale();
  local res = {};

  chardumps.log:Message(L.GetCurrency);

  local i = 1;
  while true do
    local name, isHeader = GetCurrencyListInfo(i);
    if (not name) then
      break;
    end
    if isHeader then
      ExpandCurrencyList(i, 1);
    end
    i = i + 1;
  end

  local tCurrency = {};
  local patchVersion = chardumps:getPatchVersion();
  if patchVersion == 3 then
    tCurrency = {
      121, 122, 103, 42, 241, 390, 81, 61, 384, 386, 221, 341, 101,
      301, 102, 123, 392, 321, 395, 161, 124, 385, 201, 125, 126
    };
  elseif patchVersion == 4 then
    tCurrency = {
      789, 241, 390, 61, 515, 398, 384, 697, 81, 615, 393, 392, 361,
      402, 395, 738, 754, 416, 677, 752, 614, 400, 394, 397, 676, 777,
      401, 391, 385, 396, 399, 776
    };
  end

  if patchVersion == 3 then
    for i = 1, GetCurrencyListSize() do
      -- name, isHeader, isExpanded, isUnused, isWatched, count, extraCurrencyType, icon, itemID = GetCurrencyListInfo(index)
      local _, isHeader, _, _, _, count, _, _, itemID = GetCurrencyListInfo(i);
      if (not isHeader) and itemID and (count > 0) then
        table.insert(res, itemID, count);
      end
    end
  elseif patchVersion == 4 then
    for _, currencyId in ipairs(tCurrency) do
      -- name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(id)
      local name, amount, _, _, _, _, isDiscovered = GetCurrencyInfo(currencyId);
      if name and isDiscovered and amount > 0 then
        table.insert(res, currencyId, amount);
      end
    end
  end

  return res;
end

function dumper:GetGlobalData()
  local res = {};
  local L = chardumps:GetLocale();

  chardumps.log:Message(L.GetGlobal);

  res.locale       = GetLocale();
  res.realm        = GetRealmName();
  res.realmlist    = GetCVar("realmList");
  local _, build   = GetBuildInfo();
  res.clientbuild  = tonumber(build);
  res.addonversion = chardumps:GetVersion();
  res.createtime   = time();
  res.luaversion   = _VERSION;

  return res;
end

function dumper:GetGlyphData()
  local L = chardumps:GetLocale();
  local res = { {}, {} };
  local items = {};
  local numGlyphSlot = 0;
  --[[
  The major glyph at the top of the user interface (level 15)
  The minor glyph at the bottom of the user interface (level 15)
  The minor glyph at the top left of the user interface (level 30)
  The major glyph at the bottom right of the user interface (level 50)
  The minor glyph at the top right of the user interface (level 70)
  The major glyph at the bottom left of the user interface (level 80)
  --]]
  chardumps.log:Message(L.GetPlyph);

  local moreWow3 = chardumps:getPatchVersion() > 3;
  if moreWow3 then
    for i = 1, GetNumGlyphs() do
      -- name, glyphType, isKnown, icon, castSpell = GetGlyphInfo(index);
      -- glyphType: 1 for minor glyphs, 2 for major glyphs, 3 for prime glyphs (number)
      local name, glyphType, isKnown, icon, castSpell = GetGlyphInfo(i);
      if isKnown and castSpell then
      --  print(i, glyphType, castSpell, name);
        table.insert(items, {["T"] = glyphType, ["I"] = castSpell});
      end
    end
    numGlyphSlot = NUM_GLYPH_SLOTS;
    res.items = items;
  else
    numGlyphSlot = 6; -- GetNumGlyphSockets always returns 6 in 3.3.5a?
  end

  for talentGroup = 1,2 do
    local glyphs = res[talentGroup];
    for socket = 1, numGlyphSlot do
      -- enabled, glyphType, glyphTooltipIndex, glyphSpell, icon = GetGlyphSocketInfo(socket, talentGroup)
      local enabled, glyphType, glyphSpell;
      if moreWow3 then
        enabled, glyphType, _, glyphSpell = GetGlyphSocketInfo(socket, talentGroup);
      else
        enabled, glyphType, glyphSpell = GetGlyphSocketInfo(socket, talentGroup);
      end
      if enabled and glyphType and glyphSpell then
        table.insert(glyphs, {["T"] = glyphType, ["I"] = glyphSpell});
      end
    end
  end

  return res;
end

function dumper:GetEquipmentData()

end

function dumper:GetInventoryData()

end

function dumper:GetMountData()

end

function dumper:GetPlayerData()
  local res  = {};
  local L = chardumps:GetLocale();

  chardumps.log:Message(L.GetPlayer);

  res.name             = UnitName("player");
  local _, class       = UnitClass("player");
  res.class            = class;
  res.level            = UnitLevel("player");
  local _, race        = UnitRace("player");
  res.race             = race;
  res.gender           = UnitSex("player");
  local honorableKills = GetPVPLifetimeStats()
  res.kills            = honorableKills;
  res.money            = math.floor(GetMoney() / 10000); -- convert to gold
  res.specs            = GetNumTalentGroups();
  if GetActiveSpecGroup ~= nil then
    res.active_spec = GetActiveSpecGroup();
  end
  res.health           = UnitHealth("player");
  res.mana             = UnitMana("player");

  return res;
end

function dumper:GetPetData()

end

function dumper:GetPMmacroData()

end

function dumper:GetQuestData()
  local L = chardumps:GetLocale();
  local res = {};

  chardumps.log:Message(L.GetQuest);

  local questTable = GetQuestsCompleted(nil);
  for k, _ in pairs(questTable) do
    table.insert(res, k);
  end
  sort(res);

  return res;
end

function dumper:GetQuestlogData()

end

function dumper:GetReputationData()

end

function dumper:GetSkillData()

end

function dumper:GetSkillspellData()

end

function dumper:GetSpellData()
  local L = chardumps:GetLocale();
  local res = {};

  chardumps.log:Message(L.GetSpell);

  for i = 1, MAX_SKILLLINE_TABS do
    local name, _, offset, numSpells = GetSpellTabInfo(i);
    if not name then
      break
    end
    for j = offset + 1, offset + numSpells do
      local spellLink = GetSpellLink(j, BOOKTYPE_SPELL);
      if spellLink then
        local spellid = tonumber(strmatch(spellLink, "Hspell:(%d+)"));
        if spellid > 0 then
          table.insert(res, spellid, i);
        end
      end
    end
  end
  table.sort(res, function (v1, v2) return v1[1] < v2[1] end);

  return res;
end

function dumper:GetStatisticData()

end

function dumper:GetTalentData()

end

function dumper:GetTaxiData()

end

function dumper:GetTitleData()

end

function dumper:SetDynamicData(name, value)
  self.dynamicDump[name] = value;
end

function dumper:GetDynamicData(name)
  return self.dynamicDump[name] or {};
end

---
--@return #table
function dumper:GetBankItemCount()
  local count = 0;
  local mainbankCount = 0;
  local bankData = self.dynamicDump["bank"];

  if bankData then
    mainbankCount = chardumps:GetTableLength(bankData.mainbank);
    for _, v in pairs(bankData) do
      count = count + chardumps:GetTableLength(v);
    end
    count = count - mainbankCount;
  end

  return mainbankCount + count;
end

function dumper:GetSkillspellCount()
  local count = 0;

  for _, v in pairs(self:GetDynamicData("skillspell")) do
    count = count + #v;
  end

  return count;
end

---
-- @return #number
function dumper:GetTaxiCount()
  local taxiData = self:GetDynamicData("taxi");
  local count = 0;

  for i = 1, chardumps.MAX_NUM_CONTINENT do
    if taxiData[i] then
      count = count + #taxiData[i];
    end
  end

	return count;
end

chardumps.dumper = dumper;
