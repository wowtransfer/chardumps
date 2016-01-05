chardumps = chardumps or {};

local _, clientBuild = GetBuildInfo();
clientBuild = tonumber(clientBuild);

-- define client build constant
if clientBuild >= 6080 and clientBuild <= 8478 then
	WOW2 = true;
elseif clientBuild >= 9056 and clientBuild <= 12340 then
	WOW3 = true;
elseif clientBuild >= 13164 and clientBuild <= 15595 then
	WOW4 = true;
end
