crypt_lib = {};
local crypt_lib = crypt_lib;

local function encode_String(s)
  s = string.gsub(s,'\\','\\\\');
  s = string.gsub(s,'"','\\"');
  s = string.gsub(s,"'","\\'");
  s = string.gsub(s,'\n','\\n');
  s = string.gsub(s,'\t','\\t');
  return s;
end

function crypt_lib.encode(obj)
  if obj == nil then
    return "null";
  end

  local t = type(obj);

  if t == "string" then
    return '"' .. encode_String(obj) .. '"';
  end

  if t == "number" or t == "boolean" then
    return tostring(obj);
  end

  if t == "table" then
    local ret = {};

    for key,value in pairs(obj) do
      if type(key) == "string" then
	table.insert(ret, '"' .. encode_String(key) .. '":' .. crypt_lib.encode(value));
      else
        table.insert(ret, encode_String(tostring(key)) .. ':' .. crypt_lib.encode(value));
      end
    end
    return '[' .. table.concat(ret, ';') .. ']';
  end

  assert(false, 'encode attempt to encode unsupported type ' .. t .. ':' .. tostring(obj));
end