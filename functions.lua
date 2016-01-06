local chardumps = chardumps;

---
-- Safe function call
function chardumps:TryCall(fun)
  local status, result = xpcall(fun, function(message)
    print(string.format("\124cFF9F3FFFchardumps:\124c00FF0000 %s\124r", message));
  end);
  if status then
    return result;
  end
end

---
-- Get table element count
function chardumps:GetTableLength(t)
  if type(t) ~= "table" then
    return 0;
  end

  local size = 0;
  for k, v in pairs(t) do
    size = size + 1;
  end

  return size;
end

---
-- Copy the table
function chardumps:CopyTable(t)
  local u = {};

  for k, v in pairs(t) do
    u[k] = v;
  end

  return setmetatable(u, getmetatable(t));
end
