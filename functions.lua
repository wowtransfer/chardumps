local chardumps = chardumps;

---
-- Safe function call
function chardumps:TryCall(fun)
  local status, result = xpcall(fun, chardumps.log.error);
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
