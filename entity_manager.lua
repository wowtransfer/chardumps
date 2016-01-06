local chardumps = chardumps;
local entityManager = {
	entities = {
		achievement = {},
		action = {},
		bag = {},
		bank = {},
		bind = {},
		criterias = {},
		critter = {},
		currency = {},
		global = {always = true},
		glyph = {},
		equipment = {},
		inventory = {},
		mount = {},
		player = {always = true},
		pet = {},
		pmacro = {},
		quest = {},
		questlog = {},
		reputation = {},
		skill = {},
		skillspell = {},
		spell = {},
		statistic = {},
		talent = {},
		taxi = {},
		title = {},
	}
};

---
-- @return table
function entityManager:GetEntities()
  return self.entities;
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
    sort(self.names);
  end
  return self.names;
end

chardumps.entityManager = entityManager;