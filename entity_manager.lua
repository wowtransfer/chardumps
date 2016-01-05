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
		glyph = {},
		equipment = {},
		inventory = {},
		mount = {},
		player = {},
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


function entityManager:hasEntity(name)

end

--[[
The entities depends on WoW's version
--]]
function entityManager:init()
  
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