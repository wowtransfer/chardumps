local function chd_encode_string(s)
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
local function chd_is_array(tbl)
	local count = 0;

	for k, v in pairs(tbl) do
		if not (type(k) == 'number' and k > 0 and math.floor(k) == k) then
			return false
		end
		count = count + 1;
	end

	return count == table.getn(tbl);
end

local function chd_is_encodeable(value)
	local t = type(value);
	return t == 'string' or t == 'number' or t=='table' or t == 'boolean';
end

local function chd_encode(obj)
	if obj == nil then
		return 'null';
	end

	local t = type(obj);

	if t == 'string' then
		return '"' .. chd_encode_string(obj) .. '"';
	end

	if t == 'number' or t == 'boolean' then
		return tostring(obj);
	end

	if t == 'table' then
		local ret = {};
		local value;

		local bArray = chd_is_array(obj);
		if bArray then
			for _, v in ipairs(obj) do
				if v ~= nil then
					value = chd_encode(v);
					table.insert(ret, value);
				end
			end
			return '[' .. table.concat(ret, ',') .. ']';
		else
			for key, value in pairs(obj) do
				if chd_is_encodeable(key) and chd_is_encodeable(value) then
					table.insert(ret, '"' .. chd_encode_string(tostring(key)) .. '":' .. chd_encode(value));
				end
			end
			return '{' .. table.concat(ret, ',') .. '}';
		end
	end

	assert(false, 'unsupported type ' .. t .. ':' .. tostring(obj));
end

function chd_to_json(dump)
	return chd_encode(dump);
end