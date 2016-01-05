local chardumps = chardumps;
local encryption = {};

local function encodeString(s)
	s = string.gsub(s,"\\","\\\\");
	s = string.gsub(s,"\"","\\\"");
--	s = string.gsub(s,"'","\\'");
	s = string.gsub(s,"\n","\\n");
	s = string.gsub(s,"\t","\\t");
	return s;
end

--[[
keys:
	integer,
	string,
	nil
values:
	integer, float
	string,
	table,
	boolean
	nil
--]]
local function isArray(obj)
	local count = 0;

	for k, v in pairs(obj) do
		if not (type(k) == 'number' and k > 0 and math.floor(k) == k) then
			return false
		end
		count = count + 1;
	end

	return count == table.getn(obj);
end

local function isEncodeable(value)
	local t = type(value);
	return t == 'string' or t == 'number' or t=='table' or t == 'boolean';
end

function encryption:encode(obj)
	if obj == nil then
		return 'null';
	end

	local t = type(obj);

	if t == 'string' then
		return '"' .. encodeString(obj) .. '"';
	end

	if t == 'number' or t == 'boolean' then
		return tostring(obj);
	end

	if t == 'table' then
		local ret = {};
		local value;

		local bArray = isArray(obj);
		if bArray then
			for _, v in ipairs(obj) do
				if v ~= nil then
					value = self:encode(v);
					table.insert(ret, value);
				end
			end
			return '[' .. table.concat(ret, ',') .. ']';
		else
			for key, value in pairs(obj) do
				if isEncodeable(key) and isEncodeable(value) then
					table.insert(ret, '"' .. encodeString(tostring(key)) .. '":' .. chd_encode(value));
				end
			end
			return '{' .. table.concat(ret, ',') .. '}';
		end
	end

	assert(false, 'unsupported type ' .. t .. ':' .. tostring(obj));
end

function encryption:toJson(dump)
	return self:encode(dump);
end

chardumps.encryption = encryption;
