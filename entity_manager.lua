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


chardumps.entityManager = entityManager;