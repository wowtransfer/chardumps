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
