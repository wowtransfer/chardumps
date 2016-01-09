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

  local count = 0;
  for _, _ in pairs(t) do
    count = count + 1;
  end

  return count;
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

function chardumps:Ucfirst(s)
  if type(s) == "string" then
    return s:sub(1, 1):upper() .. s:sub(2);
  end
end
