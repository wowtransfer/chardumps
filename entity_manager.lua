local chardumps = chardumps;
local entityManager = {
	entities = {
		achievement = {},
		action = {},
		bag = {},
		bank = {dynamic = true},
		bind = {},
		criterias = {},
		critter = {},
		currency = {},
		global = {always = true},
		glyph = {},
		equipment = {disable = true},
		inventory = {},
		mount = {},
		player = {always = true},
		pet = {disable = true},
		pmacro = {disable = true},
		quest = {dynamic = true},
		questlog = {},
		reputation = {},
		skill = {},
		skillspell = {dynamic = true},
		spell = {},
		statistic = {},
		talent = {},
		taxi = {dynamic = true},
		title = {},
	}
};

---
-- @return table
function entityManager:GetEntities()
  return self.entities;
end

function entityManager:GetEntity(name)
  return self.entities[name];
end

---
-- @return boolean
function entityManager:hasEntity(name)
  local names = self:GetNames();
  return names[name] ~= nil;
end

--[[
The entities depends on WoW's version
--]]
function entityManager:Init()
  
end

---
-- @return string[]
function entityManager:GetNames()
  if self.names == nil then
    self.names = {};
    for key, value in pairs(self.entities) do
      table.insert(self.names, key);
    end
    table.sort(self.names);
  end
  return self.names;
end

function entityManager:GetDynamicNames()
  if self.dynamicNames == nil then
    self.dynamicNames = {};
    for key, entity in pairs(self.entities) do
      if entity.dynamic then
        table.insert(self.dynamicNames, key);
      end
    end
    table.sort(self.dynamicNames);
  end
  return self.dynamicNames;
end

chardumps.entityManager = entityManager;