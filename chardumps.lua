local chardumps = chardumps or {};
local L = chardumps:GetLocale();
local CHD_bindings = CHD_bindings or {};

function CHD_GetSkillSpellText()
	local s = "";
	local count = 0;

	for k, v in pairs(CHD_SERVER_LOCAL.skillspell) do
		s = s .. #v .. ", ";
		count = count + 1;
	end
	if count > 0 then
		s = string.sub(s, 1, -3);
		s = string.format("%s (%s)", L.chbSkillSpell, s);
	else
		s = L.chbSkillSpell;
	end

	return s;
end

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

local function CHD_GetGlyphText(glyph)
	local text = L.chbGlyphs;

	if glyph == nil then
		return L.chbGlyph;
	end
	if glyph.items ~= nil then
		text = text .. " " .. #glyph.items;
	else
		text = text .. " 0";
	end
	local n1 = chardumps.getTableLength(glyph[1] or {});
	local n2 = chardumps.getTableLength(glyph[2] or {});
	text = text .. string.format(" (%d, %d)", n1, n2);

	return text;
end

local function CHD_GetGlyphCount(glyph)
	if glyph == nil then
		return 0;
	end

	local n1 = chardumps.getTableLength(glyph[1] or {});
	local n2 = chardumps.getTableLength(glyph[2] or {});

	return n1 + n2;
end

local function CHD_GetBagItemCount(bankDump)
	local count = 0;

	for _, v in pairs(bankDump) do
		count = count + chardumps.getTableLength(v);
	end

	return count;
end


local function CHD_FillFieldCountClient(dump)
	if not dump then
		return false;
	end

	local res = {};

	res.achievement = chardumps.getTableLength(dump.achievement);
	res.action = chardumps.getTableLength(dump.action);
	res.criterias = chardumps.getTableLength(dump.criterias);
	res.statistic = chardumps.getTableLength(dump.statistic);
	res.arena = #dump.arena;
	res.critter = #dump.critter;
	res.mount = #dump.mount;

	res.bag = CHD_GetBagItemCount(dump.bag);
	res.currency = chardumps.getTableLength(dump.currency);
	res.equipment = #dump.equipment;
	res.reputation = #dump.reputation;
	res.glyph = CHD_GetGlyphCount(dump.glyph);
	res.inventory = chardumps.getTableLength(dump.inventory);
	res.questlog = #dump.questlog;
	res.spell = chardumps.getTableLength(dump.spell);
	res.skill = #dump.skill;
	res.pmacro = #dump.pmacro;
	res.friend = #dump.friend;
	res.pet = 0;

	_, res.bank = CHD_GetBankItemCount();
	res.bind = #dump.bind;
	res.quest = #dump.quest;
	local count = 0;
	for k, v in pairs(dump.taxi) do
		count =  count + #v;
	end
	res.taxi = count;

	count = 0;
	for _, v in pairs(dump.skillspell) do
		count =  count + #v;
	end
	res.skillspell = count;

	res.title = #dump.title;
	res.talent = CHD_GetTalentCount(dump.talent);

	dump.CHD_FIELD_COUNT = res;

	return true;
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

local function CHD_GetProfessionsInfo()
	local res = {};

	if not WOW4 then
		return res;
	end

	CHD_Message(L.GetProfessions);
	local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions();
	local indexes = {prof1, prof2, archaeology, fishing, cooking, firstAid};
	for i = 1,6 do
		-- name, texture, rank, maxRank, numSpells, spelloffset, skillLine, rankModifier, specializationIndex, specializationOffset = GetProfessionInfo(index)
		if indexes[i] then
			local name, _, rank, maxRank, numSpells, spelloffset, skillLine = GetProfessionInfo(indexes[i]);
			if rank then
				-- TODO: name delete
				table.insert(res, {["N"] = name, ["R"] = rank, ["M"] = maxRank, ["K"] = skillLine});
			end
		end
	end

	return res;
end

local function CHD_GetArenaInfo()
	local res = {};

	CHD_Message(L.GetArena);
	for i = 1, 3 do
		local teamName, teamSize, teamRating, _, _, seasonTeamPlayed, seasonTeamWins, _, seasonPlayerPlayed, _, playerRating, bg_red, bg_green, bg_blue, emblem, emblem_red, emblem_green, emblem_blue, border, border_red, border_green, border_blue = GetArenaTeam(i);
		if teamName then
			local arena = {};
			arena.teamSize           = teamSize;
			arena.teamName           = teamName;
			arena.teamRating         = teamRating;
			arena.seasonTeamPlayed   = seasonTeamPlayed;
			arena.seasonTeamWins     = seasonTeamWins;
			arena.seasonPlayerPlayed = seasonPlayerPlayed;
			arena.playerRating       = playerRating;
			arena.bg = {["R"] = bg_red, ["G"] = bg_green, ["B"] = bg_blue};
			arena.emblem = {["S"] = emblem, ["R"] = emblem_red, ["G"] = emblem_green, ["B"] = emblem_blue};
			arena.border = {["S"] = border, ["R"] = border_red, ["G"] = border_green, ["B"] = border_blue};
			res[i] = arena;
		end
	end

	return res;
end

local function CHD_GetBindInfo()
	local res = {};

	CHD_Message(L.GetBind);
	for i = 1, GetNumBindings() do
		local commandName, binding1, binding2 = GetBinding(i);
		if (binding1 or binding2) and (CHD_bindings[commandName]) then
			table.insert(res, {commandName, binding1, binding2});
		end
	end

	return res;
end

local function CHD_GetTalentInfo()
	local res = {};
	local specTalentSpell, numTalents;
	local name, _, tier, column, rank, maxRank;
	local talentLink;

	CHD_Message(L.GetTalent);
	for specNum = 1,2 do
		specTalent = {};
		for tabIndex = 1,5 do -- GetNumTalentTabs() always return  3???
			numTalents = GetNumTalents(tabIndex, false, false);
			if (numTalents == nil) or (numTalents == 0) then
				break
			end
			-- name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq, previewRank, meetsPreviewPrereq = GetTalentInfo(tabIndex, talentIndex, inspect, pet, talentGroup);
			for i = 1, numTalents do
				name, _, tier, column, rank, maxRank = GetTalentInfo(tabIndex, i, false, false, specNum);
			-- link = GetTalentLink(tabIndex, talentIndex, inspect, pet, talentGroup)
			talentLink = GetTalentLink(tabIndex, i, false, false, specNum);

			local talentId = tonumber(strmatch(talentLink, "Htalent:(%d+)"));
			if (rank ~= nil) and (rank > 0) and (talentId > 0) then
				table.insert(specTalent, talentId, rank);
			end

			end
		end

		table.sort(specTalent, function (v1, v2) return v1.I < v2.I end);

		res[specNum] = specTalent;
	end

	return res;
end

--[[
	Saving data
--]]

function CHD_Debug()
	CHD_GetStatistic();
end

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

	if (CHD_frmMainchbTaxi:GetChecked()) then
		dump.taxi = CHD_TAXI or {};
	else
		dump.taxi = {};
	end;

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