local chardumps = chardumps;
local dumper = {
  -- each field are entity name
	dump = {},
};

---
-- @param table options What is saved
function dumper:Dump(options)
  self.dump = {};
  
  
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

end

function dumper:GetGlyphData()

end

function dumper:GetEquipmentData()

end

function dumper:GetInventoryData()

end

function dumper:GetMountData()

end

function dumper:GetPlayerData()

end

function dumper:GetPetData()

end

function dumper:GetPMmacroData()

end

function dumper:GetQuestData()

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

chardumps.dumper = dumper;
