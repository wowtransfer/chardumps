--[[

--]]
local chardumps = chardumps;
local L = chardumps:GetLocale();

function CHD_GetTaxiText()
	return L.chbTaxi .. string.format(" (%d, %d, %d, %d)",
		#CHD_TAXI[1] or 0,
		#CHD_TAXI[2] or 0,
		#CHD_TAXI[3] or 0,
		#CHD_TAXI[4] or 0);
end

function CHD_OnTaximapOpened(arg1, arg2, arg3)
	if not CHD_frmMainchbTaxi:GetChecked() then
		return false;
	end

	local res = {};
--[[
-1 - Cosmic map
0 - Azeroth
1 - Kalimdor
2 - Eastern Kingdoms
3 - Outland
4 - Northrend
5 - The Maelstrom
6 - Pandaria
--]]
--	print("debug: GetMapInfo():", GetMapInfo());
	local continent = GetCurrentMapContinent();
	if (continent < 1) or (continent > MAX_NUM_CONTINENT) then
		return false;
	end

	local arrContinent = {L.Kalimdor, L.EasternKingdoms, L.Outland, L.Northrend};
	CHD_Message(L.GetTaxi .. arrContinent[continent]);
	for i = 1, NumTaxiNodes() do
		table.insert(res, TaxiNodeName(i));
	end

	CHD_TAXI[continent] = res;

	CHD_frmMainchbTaxiText:SetText(CHD_GetTaxiText());

	CHD_Message(L.CountOfTaxi .. tostring(#CHD_TAXI[continent]));

	return true;
end

function CHD_OnVariablesLoaded()
	-- client
	CHD_CLIENT = {};

	-- server
	CHD_SERVER_LOCAL = {};

	CHD_SERVER_LOCAL.quest = {};
	CHD_SERVER_LOCAL.bank = {};
	CHD_SERVER_LOCAL.bank.mainbank = {};
	CHD_SERVER_LOCAL.skillspell = {};

	CHD_frmMainchbTaxiText:SetText(CHD_GetTaxiText());
	CHD_frmMainchbQuestsText:SetText(L.chbQuests);
	CHD_frmMainchbBankText:SetText(L.chbBank);

	if not CHD_trycall(CHD_SetOptions) then
		CHD_SetOptionsDef();
		CHD_trycall(CHD_SetOptions);
	end

	return true;
end

function CHD_OnEvent(self, event, ...)
	if "BANKFRAME_OPENED" == event then
		if CHD_frmMainchbBank:GetChecked() then
			CHD_SERVER_LOCAL.bank = CHD_trycall(CHD_GetBankInfo) or {};
		else
			CHD_SERVER_LOCAL.bank = {};
		end
		CHD_frmMainchbBankText:SetText(L.chbBank .. string.format(" (%d, %d)", CHD_GetBankItemCount()));
	elseif "PLAYER_LEAVING_WORLD" == event then
		CHD_SaveOptions();
	elseif "TAXIMAP_OPENED" == event then
		CHD_OnTaximapOpened(arg1, arg2);
	elseif "VARIABLES_LOADED" == event then
		CHD_OnVariablesLoaded();
	elseif "TRADE_SKILL_SHOW" == event then
		CHD_OnTradeSkillShow(arg1, arg2);
	elseif "QUEST_DETAIL" == event or "QUEST_PROGRESS" == event then
		if WOW3 then
			return
		end
		local questTable = GetQuestsCompleted(nil);
		local questId = GetQuestID();
		local s = L.Quest .. "(ID = " .. questId .. ")";
		if questTable[questId] ~= nil then
			s = s .. " \124cFF00FF00 " .. L.QuestWasCompleted  .. "\r";
		end
		CHD_Message(s);
	elseif "QUEST_COMPLETE" == event then
		if WOW3 then
			return
		end
		local questId = GetQuestID();
		CHD_Message(L.Quest .. " (ID = " .. questId .. ") \124cFF00FF00 " .. L.QuestCompleted .. "\r");
	elseif "QUEST_AUTOCOMPLETE" == event then
		print("debug:", event, arg1, arg2, arg3);
	else
		print("debug:", event, arg1, arg2, arg3);
	end
end
