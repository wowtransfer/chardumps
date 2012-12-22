crypt_lib = {};
local crypt_lib = crypt_lib;

local function encodeString(s)
  s = string.gsub(s,'\\','\\\\');
  s = string.gsub(s,'"','\\"');
  s = string.gsub(s,"'","\\'");
  s = string.gsub(s,'\n','\\n');
  s = string.gsub(s,'\t','\\t');
  return s;
end

local function decode_TrimHandleChars(s, startPos)
  local whitespace = " \n\r\t";
  local stringLen = string.len(s);

  while ( string.find(whitespace, string.sub(s, startPos, startPos), 1, true)
      and startPos <= stringLen) do
    startPos = startPos + 1;
  end

  return startPos;
end

local function decode_Number(s, startPos)
  local endPos = startPos+1;
  local stringLen = string.len(s);
  local acceptableChars = "+-0123456789.e";

  while (string.find(acceptableChars, string.sub(s, endPos, endPos), 1, true)
	and endPos <= stringLen) do
    endPos = endPos + 1;
  end
  local stringValue = 'return ' .. string.sub(s,startPos, endPos-1);
  local stringEval = loadstring(stringValue);
  assert(stringEval, 'Failed to scan number [ ' .. stringValue .. '] in JSON string at position ' .. startPos .. ' : ' .. endPos);

  return stringEval(), endPos
end

local function decode_Constant(s, startPos)
  local consts = { ["true"] = true, ["false"] = false, ["null"] = nil };
  local constNames = {"true","false","null"};

  for k, v in pairs(constNames) do
    if string.sub(s, startPos, startPos + string.len(v) - 1 ) == v then
      return consts[v], startPos + string.len(v);
    end
  end
  assert(nil, 'Failed to scan constant from string ' .. s .. ' at starting position ' .. startPos);
end

local function decode_String(s, startPos)
  assert(startPos, 'decode_scanString(..) called without start position');

  local startChar = string.sub(s, startPos, startPos);
  assert(startChar==[[']] or startChar == [["]], 'decode_scanString called for a non-string');
  local escaped = false;
  local endPos = startPos + 1;
  local bEnded = false;
  local stringLen = string.len(s);

  repeat
    local curChar = string.sub(s, endPos, endPos);
    if not escaped then
      if curChar == [[\]] then
        escaped = true;
      else
        bEnded = curChar==startChar;
      end
    else
      escaped = false;
    end
    endPos = endPos + 1;
    assert(endPos <= stringLen+1, "String decoding failed: unterminated string at position " .. endPos)
  until
    bEnded;
  local stringValue = 'return ' .. string.sub(s, startPos, endPos-1);
  local stringEval = loadstring(stringValue);
  assert(stringEval, 'Failed to load string [ ' .. stringValue .. '] in decode_String at position ' .. startPos .. ' : ' .. endPos);
  return stringEval(), endPos;
end

local function decode_Table(s, startPos)
  local object = {};
  local stringLen = string.len(s);
  local key, value;
  assert(string.sub(s, startPos, startPos) == '[', 'decode_Object called but object does not start at position ' .. startPos .. ' in string:\n' .. s);
  startPos = startPos + 1
  repeat
    startPos = decode_TrimHandleChars(s, startPos);
    assert(startPos <= stringLen, 'string ended unexpectedly while scanning object.');
    local curChar = string.sub(s, startPos, startPos);
    if (curChar == ']') then
      return object, startPos+1;
    end
    if (curChar == ';') then
      startPos = decode_TrimHandleChars(s, startPos+1);
    end
    assert(startPos <= stringLen, 'string ended unexpectedly scanning object.');

    key, startPos = crypt_lib.decode(s, startPos);
    assert(startPos <= stringLen, 'string ended unexpectedly searching for value of key ' .. key);
    startPos = decode_TrimHandleChars(s, startPos);
    assert(startPos <= stringLen, 'string ended unexpectedly searching for value of key ' .. key);
    assert(string.sub(s, startPos, startPos) == ':', 'object key-value assignment mal-formed at ' .. startPos);
    startPos = decode_TrimHandleChars(s, startPos+1);
    assert(startPos <= stringLen, 'string ended unexpectedly searching for value of key ' .. key);
    value, startPos = crypt_lib.decode(s, startPos);
    object[key] = value;
  until
    false;
end


function crypt_lib.encode(obj)
  if obj == nil then
    return "null";
  end

  local t = type(obj);

  if t == "string" then
    return '"' .. encodeString(obj) .. '"';
  end

  if t == "number" or t == "boolean" then
    return tostring(obj);
  end

  if t == "table" then
    local ret = {};

    for key,value in pairs(obj) do
      if type(key) == "string" then
	table.insert(ret, '"' .. encodeString(key) .. '":' .. crypt_lib.encode(value));
      else
        table.insert(ret, encodeString(tostring(key)) .. ':' .. crypt_lib.encode(value));
      end
    end
    return '[' .. table.concat(ret, ';') .. ']';
  end

  assert(false, 'encode attempt to encode unsupported type ' .. t .. ':' .. tostring(obj));
end

function crypt_lib.decode(s, startPos)
  startPos = startPos or 1;
  startPos = decode_TrimHandleChars(s, startPos);

  assert(startPos<=string.len(s), 'Unterminated JSON encoded object found at position in [' .. s .. ']');

  local curChar = string.sub(s, startPos, startPos);

  if curChar == '[' then
    return decode_Table(s, startPos);
  end
  if string.find("+-0123456789.e", curChar, 1, true) then
    return decode_Number(s, startPos);
  end
  if curChar == [["]] or curChar==[[']] then
    return decode_String(s, startPos);
  end

  return decode_Constant(s, startPos);
end