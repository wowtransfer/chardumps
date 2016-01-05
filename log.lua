local chardumps = chardumps;
local log = {};

function log:message(...)
  local x = {...};
  for k,v in pairs(x) do
    print("\124cFF9F3FFFchardumps:\124r ", v);
  end
end

function log:error(message)
  print(string.format("\124cFF9F3FFFchardumps:\124c00FF0000 %s\124r", message));
end

function log:warning(message)
  print(string.format("\124cFF9F3FFFchardumps:\124c00FFFF00 %s\124r", message));
end

function log:debug(message)
  print(string.format("\124cFF9F3FFFchardumps:\124c00FFFF00 %s\124r", message));
end

chardumps.log = log;
