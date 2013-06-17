local function CHD_encode_string(s)
	s = string.gsub(s,"\\","\\\\");
	s = string.gsub(s,"\"","\\\"");
	s = string.gsub(s,"'","\\'");
	s = string.gsub(s,"\n","\\n");
	s = string.gsub(s,"\t","\\t");
	return s;
end

function CHD_encode(obj)
	if obj == nil then
		return "null";
	end

	local t = type(obj);

	if t == "string" then
		return "\"" .. CHD_encode_string(obj) .. "\"";
	end

	if t == "number" or t == "boolean" then
		return tostring(obj);
	end

	if t == "table" then
		local ret = {};

		for key,value in pairs(obj) do
			if type(key) == "string" then
				table.insert(ret, "\"" .. CHD_encode_string(key) .. "\":" .. CHD_encode(value));
			else
				table.insert(ret, CHD_encode_string(tostring(key)) .. ":" .. CHD_encode(value));
			end
		end
		return "[" .. table.concat(ret, ";") .. "]";
	end

	assert(false, "unsupported type " .. t .. ":" .. tostring(obj));
end