local chardumps = chardumps;
local options = CHD_OPTIONS or {};
local CHD_TAXI = CHD_TAXI or {};

function options:getDefault()
  local entityManager = chardumps.getEntityManager();

  
end

function options:Init()
  self:Clear();
  for i = 1, chardumps.MAX_NUM_CONTINENT do
    if not CHD_TAXI[i] then
      CHD_TAXI[i] = {};
    end
  end
end

function options:Save()

end

function options:Load(accountOptions, playerOptions)

end

function options:Clear()
  self:ClearForDump();
  -- other
  -- other gui
end

function options:ClearForDump()
  self.dumpOptions = {
    entities = {},
    -- entities
    -- crypt
    -- etc.
  };
end

---
-- Add entity for the dump, safe
function options:AddEntityForDump(name)
  self.dumpOptions.entities[name] = true;
end

---
-- Add entity for the dump, safe
function options:AddOptionForDump(name, value)
  if name == "entities" then
    chardumps.log.error("options: Wrong name `entities`");
  end
  if value == nil then
    value = true;
  end
  self.dumpOptions[name] = value;
end

---
-- @return #table
function options:GetOptionsFroDump()
  return self.dumpOptions;
end

chardumps.options = options;
