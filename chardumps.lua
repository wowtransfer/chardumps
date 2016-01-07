local chardumps = chardumps or {};
local L = chardumps:GetLocale();
local CHD_bindings = CHD_bindings or {};

local function CHD_GetTalentText(talent)
	local s = "(";

	for i = 1,2 do
		if talent[i] ~= nil then
			s = s .. chardumps.getTableLength(talent[i]) .. ", ";
		else
			s = s .. "0, ";
		end
	end
	s = string.sub(s, 1, -3);
	s = s .. ")";

	return s;
end

local function CHD_GetTalentCount(talent)
	local count = 0;

	for i = 1,2 do
		if talent[i] ~= nil then
			count = count + chardumps.getTableLength(talent[i]);
		end
	end

	return count;
end


--[[
	Get data
--]]

local function CHD_GetPvpCurrency(tCurrency)
	local id, count;
	local honor = 0;
	local ap    = 0;
	local cp    = 0;

	for k, v in pairs(tCurrency) do
		id = k;
		count = v;

		if (id == 392) or (id == 43308) then -- 392 currency_id of honor, 43308 item_id of honor
			honor = count;
		elseif id == 43307 then -- 43307 arena points id
			ap = count;
		elseif id == 390 then -- 390 Conquest Points
			cp = count;
		end
	end

	return honor, ap, cp;
end

--[[
	Saving data
--]]

function CHD_OnDumpClick()
	local dump = {};

	CHD_Message(L.CreatingDump);
	dump.global = CHD_trycall(CHD_GetGlobalInfo) or {};

	dump.player = CHD_trycall(CHD_GetPlayerInfo) or {};

	if CHD_frmMainchbGlyphs:GetChecked() then
		dump.glyph = CHD_trycall(CHD_GetGlyphInfo) or {};
	else
		dump.glyph = {};
	end
	CHD_frmMainchbGlyphsText:SetText(CHD_GetGlyphText(dump.glyph));

	if CHD_frmMainchbCurrency:GetChecked() then
		dump.currency = CHD_trycall(CHD_GetCurrencyInfo) or {};
	else
		CHD_LogWarn(L.WarnApAnHonorByCurrency);
		dump.currency = {};
	end
	CHD_frmMainchbCurrencyText:SetText(L.chbCurrency .. string.format(" (%d)",
		chardumps.getTableLength(dump.currency)));
	local honor, ap, cp = CHD_GetPvpCurrency(dump.currency);
	dump.player.honor = honor;
	dump.player.ap    = ap; -- Arena Points
	dump.player.cp    = cp; -- Conquest Points

	if CHD_frmMainchbSpells:GetChecked() then
		dump.spell = CHD_trycall(CHD_GetSpellInfo) or {};
	else
		dump.spell = {};
	end
	CHD_frmMainchbSpellsText:SetText(L.chbSpells .. string.format(" (%d)", chardumps.getTableLength(dump.spell)));
	if CHD_frmMainchbMounts:GetChecked() then
		dump.mount = CHD_trycall(CHD_GetMountInfo) or {};
	else
		dump.mount = {};
	end
	CHD_frmMainchbMountsText:SetText(L.chbMounts .. string.format(" (%d)", #dump.mount))
	if CHD_frmMainchbCritters:GetChecked() then
		dump.critter = CHD_trycall(CHD_GetCritterInfo) or {};
	else
		dump.critter = {};
	end
	CHD_frmMainchbCrittersText:SetText(L.chbCritters .. string.format(" (%d)", #dump.critter));

	if CHD_frmMainchbReputation:GetChecked() then
		dump.reputation = CHD_trycall(CHD_GetRepInfo) or {};
	else
		dump.reputation = {};
	end;
	CHD_frmMainchbReputationText:SetText(L.chbReputation .. string.format(" (%d)",
		chardumps.getTableLength(dump.reputation)));

	if CHD_frmMainchbAchievements:GetChecked() then
		dump.achievement = CHD_trycall(CHD_GetAchievementInfo) or {};
	else
		dump.achievement = {};
	end
	CHD_frmMainchbAchievementsText:SetText(L.chbAchievements .. string.format(" (%d)",
		chardumps.getTableLength(dump.achievement)));

	if CHD_frmMainchbActions:GetChecked() then
		dump.action = CHD_trycall(CHD_GetActionsInfo) or {};
	else
		dump.action = {};
	end
	CHD_frmMainchbActionsText:SetText(L.chbActions .. string.format(" (%d)",
		chardumps.getTableLength(dump.action)));

	dump.skill = {};
	if CHD_frmMainchbSkills:GetChecked() then
		dump.skill = CHD_trycall(CHD_GetSkillInfo) or {};
	end
	if WOW3 then
		CHD_frmMainchbSkillsText:SetText(L.chbSkills .. string.format(" (%d)",
			chardumps.getTableLength(dump.skill)));
	end

	if CHD_frmMainchbProfessions:GetChecked() then
		dump.profession = CHD_trycall(CHD_GetProfessionsInfo) or {};
	else
		dump.profession = {};
	end
	if not WOW3 then
		CHD_frmMainchbProfessionsText:SetText(L.chbProfessions .. string.format(" (%d)", #dump.profession));
	end

	if CHD_frmMainchbInventory:GetChecked() then
		dump.inventory = CHD_trycall(CHD_GetInventoryInfo) or {};
	else
		dump.inventory = {};
	end

	if not CHD_SERVER_LOCAL.bank then
		CHD_SERVER_LOCAL.bank = {}
	end
	local bankTable = chardumps.copyTable(CHD_SERVER_LOCAL.bank);
	if not bankTable.mainbank then
		bankTable.mainbank = {};
	else
		for i = 40, 74 do
			dump.inventory[i] = bankTable.mainbank[i];
		end
	end
	bankTable.mainbank = nil;
	dump.bank = bankTable;

	CHD_frmMainchbInventoryText:SetText(L.chbInventory .. string.format(" (%d)",
		chardumps.getTableLength(dump.inventory)));

	if CHD_frmMainchbBind:GetChecked() then
		dump.bind = CHD_trycall(CHD_GetBindInfo) or {};
	else
		dump.bind = {};
	end
	CHD_frmMainchbBindText:SetText(L.chbBind .. " (" .. #dump.bind .. ")");

	if CHD_frmMainchbBags:GetChecked() then
		dump.bag = CHD_trycall(CHD_GetBagInfo) or {};
	else
		dump.bag = {};
	end
	CHD_frmMainchbBagsText:SetText(L.chbBags .. string.format(" (%d)",
		CHD_GetBagItemCount(dump.bag)));
	if CHD_frmMainchbEquipment:GetChecked() then
		dump.equipment = CHD_trycall(CHD_GetEquipmentInfo) or {};
	else
		dump.equipment = {};
	end
	CHD_frmMainchbEquipmentText:SetText(L.chbEquipment .. string.format(" (%d)",
		#dump.equipment));
	if CHD_frmMainchbQuestlog:GetChecked() then
		dump.questlog = CHD_trycall(CHD_GetQuestlogInfo) or {};
	else
		dump.questlog = {};
	end
	CHD_frmMainchbQuestlogText:SetText(L.chbQuestlog .. string.format(" (%d)",
		#dump.questlog));

	if CHD_frmMainchbMacro:GetChecked() then
		dump.pmacro = CHD_trycall(CHD_GetPMacroInfo) or {};
	else
		dump.pmacro = {};
	end
	CHD_frmMainchbMacroText:SetText(L.chbMacro .. string.format(" (%d)",
		#dump.pmacro + #dump.amacro));

	CHD_frmMainchbFriendText:SetText(L.chbFriend .. string.format(" (%d, %d)",
		#dump.friend, #dump.ignore));

	if CHD_frmMainchbArena:GetChecked() then
		dump.arena = CHD_trycall(CHD_GetArenaInfo) or {};
	else
		dump.arena = {};
	end
	CHD_frmMainchbArenaText:SetText(L.chbArena .. string.format(" (%d)", #dump.arena));

	if (CHD_frmMainchbQuests:GetChecked()) then
		dump.quest = CHD_SERVER_LOCAL.quest or {}; -- TODO: delete "or {}"
	else
		dump.quest = {};
	end

	if (CHD_frmMainchbSkillSpell:GetChecked()) then
		dump.skillspell = CHD_SERVER_LOCAL.skillspell or {};
	else
		dump.skillspell = {};
	end
	CHD_frmMainchbSkillSpellText:SetText(CHD_GetSkillSpellText());

	if (CHD_frmMainchbTitles:GetChecked()) then
		dump.title = CHD_trycall(CHD_GetTitlesInfo) or {};
	else
		dump.title = {};
	end
	CHD_frmMainchbTitlesText:SetText(L.chbTitles .. "(" .. #dump.title .. ")");

	if (CHD_frmMainchbCriterias:GetChecked()) then
		dump.criterias = CHD_trycall(CHD_GetCriteriasInfo) or {};
	else
		dump.criterias = {};
	end
	CHD_frmMainchbCriteriasText:SetText(L.chbCriterias .. string.format(" (%d)",
		chardumps.getTableLength(dump.criterias)));
	if (CHD_frmMainchbStatistic:GetChecked()) then
		dump.statistic = CHD_trycall(CHD_GetStatisticInfo) or {};
	else
		dump.statistic = {};
	end
	CHD_frmMainchbStatisticText:SetText(L.chbStatistic .. string.format(" (%d)",
		chardumps.getTableLength(dump.statistic)));

	if CHD_frmMainchbTalent:GetChecked() then
		dump.talent = CHD_trycall(CHD_GetTalentInfo) or {};
	else
		dump.talent = {};
	end
	CHD_frmMainchbTalentText:SetText(L.chbTalent .. CHD_GetTalentText(dump.talent));

	CHD_FillFieldCountClient(dump);

	if CHD_frmMainchbCrypt:GetChecked() then
		CHD_CLIENT = b64_encode(chd_to_json(dump));
		--CHD_CLIENT = json.encode(dump);
	else
		CHD_CLIENT = dump;
	end

	CHD_frmMainbtnReload:Enable();

	
end

local CHD_frmMain = CreateFrame("Frame", "CHD_frmMain", UIParent); -- global main form
CHD_Init(CHD_frmMain);