local chardumps = chardumps;
local log = {};

function log:Message(...)
  local x = {...};
  for k,v in pairs(x) do
    print("\124cFF9F3FFFchardumps:\124r ", v);
  end
end

function log:Error(message)
  print(string.format("\124cFF9F3FFFchardumps:\124c00FF0000 %s\124r", message));
end

function log:Warning(message)
  print(string.format("\124cFF9F3FFFchardumps:\124c00FFFF00 %s\124r", message));
end

function log:Debug(message)
  print(string.format("\124cFF9F3FFFchardumps:\124c00FFFF00 %s\124r", message));
end

function log:GetDump(o)
  if type(o) == 'table' then
    local s = '{ ';
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"'.. k ..'"';
      end
      s = s .. '['.. k ..'] = ' .. self:GetDump(v) .. ','
    end
    return s .. '} ';
  end

  return tostring(o);
end

function log:Dump(o)
  print(self:GetDump(o));
end

chardumps.log = log;
