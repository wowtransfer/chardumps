local chardumps = chardumps;
local options = CHD_OPTIONS or {};
local CHD_TAXI = CHD_TAXI or {};

function options:getDefault()
  local entityManager = chardumps.getEntityManager();

  self.options = {

    -- entities

    -- other
    
    -- other gui

  }
end

function options:init()
  for i = 1, chardumps.MAX_NUM_CONTINENT do
    if not CHD_TAXI[i] then
      CHD_TAXI[i] = {};
    end
  end
end

function options:save()

end

function options:load()

end

chardumps.options = options;
