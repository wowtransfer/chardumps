local chardumps = chardumps or {};
local L = chardumps:GetLocale();
local CHD_bindings = CHD_bindings or {};

--[[
	Functions
--]]

-- TODO: replace to other file
function CHD_SetOptionsDef()
	CHD_OPTIONS = {};

	CHD_OPTIONS.chbCrypt = true;
	CHD_OPTIONS.chbMinimize = false;

	CHD_OPTIONS.chbSpells = true;
	CHD_OPTIONS.chbMounts = true;
	CHD_OPTIONS.chbCritters = true;
	CHD_OPTIONS.chbReputation = true;
	CHD_OPTIONS.chbAchievements = true;
	CHD_OPTIONS.chbCriterias = true;
	CHD_OPTIONS.chbStatistic = true;
	CHD_OPTIONS.chbActions = true;
	CHD_OPTIONS.chbEquipment = true;
	CHD_OPTIONS.chbMacro = true;
	CHD_OPTIONS.chbArena = true;
	CHD_OPTIONS.chbTitles = true;
	CHD_OPTIONS.chbTalent = true;

	CHD_OPTIONS.chbGlyph = true;
	CHD_OPTIONS.chbCurrency = true;
	CHD_OPTIONS.chbInventory = true;
	CHD_OPTIONS.chbBags = true;
	CHD_OPTIONS.chbSkills = true;
	CHD_OPTIONS.chbSkillSpell = true;
	CHD_OPTIONS.chbQuestlog = true;
	CHD_OPTIONS.chbFriend = true;

	CHD_OPTIONS.chbBank = true;
	CHD_OPTIONS.chbBind = true;
	CHD_OPTIONS.chbQuests = true;
	CHD_OPTIONS.chbTaxi = true;

	return true;
end

-- TODO: replace to other file
function CHD_SetOptions()
	CHD_frmMainchbGlyphs:SetChecked(CHD_OPTIONS.chbGlyph);
	CHD_frmMainchbCurrency:SetChecked(CHD_OPTIONS.chbCurrency);
	CHD_frmMainchbSpells:SetChecked(CHD_OPTIONS.chbSpells);
	CHD_frmMainchbMounts:SetChecked(CHD_OPTIONS.chbMounts);
	CHD_frmMainchbCritters:SetChecked(CHD_OPTIONS.chbCritters);
	CHD_frmMainchbReputation:SetChecked(CHD_OPTIONS.chbReputation);
	CHD_frmMainchbAchievements:SetChecked(CHD_OPTIONS.chbAchievements);
	CHD_frmMainchbCriterias:SetChecked(CHD_OPTIONS.chbCriterias);
	CHD_frmMainchbStatistic:SetChecked(CHD_OPTIONS.chbStatistic);
	CHD_frmMainchbActions:SetChecked(CHD_OPTIONS.chbActions);
	CHD_frmMainchbSkills:SetChecked(CHD_OPTIONS.chbSkills);
	CHD_frmMainchbProfessions:SetChecked(CHD_OPTIONS.chbProfessions);
	CHD_frmMainchbSkillSpell:SetChecked(CHD_OPTIONS.chbSkillSpell);
	CHD_frmMainchbInventory:SetChecked(CHD_OPTIONS.chbInventory);
	CHD_frmMainchbBags:SetChecked(CHD_OPTIONS.chbBags);
	CHD_frmMainchbEquipment:SetChecked(CHD_OPTIONS.chbEquipment);
	CHD_frmMainchbQuestlog:SetChecked(CHD_OPTIONS.chbQuestlog);
	CHD_frmMainchbMacro:SetChecked(CHD_OPTIONS.chbMacro);
	CHD_frmMainchbFriend:SetChecked(CHD_OPTIONS.chbFriend);
	CHD_frmMainchbArena:SetChecked(CHD_OPTIONS.chbArena);
	CHD_frmMainchbTalent:SetChecked(CHD_OPTIONS.chbTalent);
	CHD_frmMainchbTitles:SetChecked(CHD_OPTIONS.chbTitles);

	CHD_frmMainchbTaxi:SetChecked(CHD_OPTIONS.chbTaxi);
	CHD_frmMainchbQuests:SetChecked(CHD_OPTIONS.chbQuests);
	CHD_frmMainchbBank:SetChecked(CHD_OPTIONS.chbBank);
	CHD_frmMainchbBind:SetChecked(CHD_OPTIONS.chbBind);

	CHD_frmMainchbCrypt:SetChecked(CHD_OPTIONS.chbCrypt);

	if (CHD_OPTIONS.chbMinimize) then
		OnCHD_frmMainbtnMinimizeClick();
	end

	return true;
end

-- TODO: replace to other file
function CHD_SaveOptions()
	CHD_OPTIONS.chbGlyph        = CHD_frmMainchbGlyphs:GetChecked();
	CHD_OPTIONS.chbCurrency     = CHD_frmMainchbCurrency:GetChecked();
	CHD_OPTIONS.chbSpells       = CHD_frmMainchbSpells:GetChecked();
	CHD_OPTIONS.chbMounts       = CHD_frmMainchbMounts:GetChecked();
	CHD_OPTIONS.chbCritters     = CHD_frmMainchbCritters:GetChecked();
	CHD_OPTIONS.chbReputation   = CHD_frmMainchbReputation:GetChecked();
	CHD_OPTIONS.chbAchievements = CHD_frmMainchbAchievements:GetChecked();
	CHD_OPTIONS.chbCriterias    = CHD_frmMainchbCriterias:GetChecked();
	CHD_OPTIONS.chbStatistic    = CHD_frmMainchbStatistic:GetChecked();
	CHD_OPTIONS.chbActions      = CHD_frmMainchbActions:GetChecked();
	CHD_OPTIONS.chbSkills       = CHD_frmMainchbSkills:GetChecked();
	CHD_OPTIONS.chbProfessions  = CHD_frmMainchbProfessions:GetChecked();
	CHD_OPTIONS.chbSkillSpell   = CHD_frmMainchbSkillSpell:GetChecked();
	CHD_OPTIONS.chbInventory    = CHD_frmMainchbInventory:GetChecked();
	CHD_OPTIONS.chbBags         = CHD_frmMainchbBags:GetChecked();
	CHD_OPTIONS.chbEquipment    = CHD_frmMainchbEquipment:GetChecked();
	CHD_OPTIONS.chbQuestlog     = CHD_frmMainchbQuestlog:GetChecked();
	CHD_OPTIONS.chbMacro        = CHD_frmMainchbMacro:GetChecked();
	CHD_OPTIONS.chbFriend       = CHD_frmMainchbFriend:GetChecked();
	CHD_OPTIONS.chbArena        = CHD_frmMainchbArena:GetChecked();
	CHD_OPTIONS.chbTalent       = CHD_frmMainchbTalent:GetChecked();
	CHD_OPTIONS.chbTitles       = CHD_frmMainchbTitles:GetChecked();

	CHD_OPTIONS.chbTaxi         = CHD_frmMainchbTaxi:GetChecked();
	CHD_OPTIONS.chbQuests       = CHD_frmMainchbQuests:GetChecked();
	CHD_OPTIONS.chbBank         = CHD_frmMainchbBank:GetChecked();
	CHD_OPTIONS.chbBind         = CHD_frmMainchbBind:GetChecked();

	CHD_OPTIONS.chbCrypt        = CHD_frmMainchbCrypt:GetChecked();

	return true;
end

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

local function CHD_GetGlobalInfo()
	local res = {};

	CHD_Message(L.GetGlobal);
	res.locale       = GetLocale();
	res.realm        = GetRealmName();
	res.realmlist    = GetCVar("realmList");
	local _, build   = GetBuildInfo();
	res.clientbuild  = tonumber(build);
	res.addonversion = chardumps:GetVersion();
	res.createtime   = time();
	res.luaversion   = _VERSION;

	return res;
end

local function CHD_GetPlayerInfo()
	local res  = {};

	CHD_Message(L.GetPlayer);
	res.name             = UnitName("player");
	local _, class       = UnitClass("player");
	res.class            = class;
	res.level            = UnitLevel("player");
	local _, race        = UnitRace("player");
	res.race             = race;
	res.gender           = UnitSex("player");
	local honorableKills = GetPVPLifetimeStats()
	res.kills            = honorableKills;
	res.money            = math.floor(GetMoney() / 10000); -- convert to gold
	res.specs            = GetNumTalentGroups();
	if (GetActiveSpecGroup ~= nil) then
		res.active_spec  = GetActiveSpecGroup();
	end
	res.health           = UnitHealth("player");
	res.mana             = UnitMana("player");
	res.totaltime        = tonumber(CHD_frmMainedtTotalTime:GetText());
	if res.totaltime == nil then
		CHD_LogWarn(L.TotalTimeUndefined);
		res.totaltime = 0;
	end

	return res;
end

local function CHD_GetGlyphInfo()
	local res ={ {}, {} };
	local items = {};
	local numGlyphSlot = 0;
--[[
The major glyph at the top of the user interface (level 15)
The minor glyph at the bottom of the user interface (level 15)
The minor glyph at the top left of the user interface (level 30)
The major glyph at the bottom right of the user interface (level 50)
The minor glyph at the top right of the user interface (level 70)
The major glyph at the bottom left of the user interface (level 80)
--]]
	CHD_Message(L.GetPlyph);

	if not WOW3 then
		for i = 1, GetNumGlyphs() do
			-- name, glyphType, isKnown, icon, castSpell = GetGlyphInfo(index);
			-- glyphType: 1 for minor glyphs, 2 for major glyphs, 3 for prime glyphs (number)
			local name, glyphType, isKnown, icon, castSpell = GetGlyphInfo(i);
			if isKnown and castSpell then
			--	print(i, glyphType, castSpell, name);
				table.insert(items, {["T"] = glyphType, ["I"] = castSpell});
			end
		end
		numGlyphSlot = NUM_GLYPH_SLOTS;
		res.items = items;
	else
		numGlyphSlot = 6; -- GetNumGlyphSockets always returns 6 in 3.3.5a?
	end

	for talentGroup = 1,2 do
		local glyphs = res[talentGroup];
		for socket = 1, numGlyphSlot do
			-- enabled, glyphType, glyphTooltipIndex, glyphSpell, icon = GetGlyphSocketInfo(socket, talentGroup)
			local enabled, glyphType, glyphSpell;
			if WOW3 then
				enabled, glyphType, glyphSpell = GetGlyphSocketInfo(socket, talentGroup);
			else
				enabled, glyphType, _, glyphSpell = GetGlyphSocketInfo(socket, talentGroup);
			end
			if enabled and glyphType and glyphSpell then
				table.insert(glyphs, {["T"] = glyphType, ["I"] = glyphSpell});
			end
		end
	end

	return res;
end

local function CHD_GetCurrencyInfo()
	local res = {};

	local i = 1;
	while true do
		local name, isHeader = GetCurrencyListInfo(i);
		if (not name) then
			break;
		end
		if isHeader then
			ExpandCurrencyList(i, 1);
		end
		i = i + 1;
	end

	local tCurrency = {};
	if WOW3 then
		tCurrency = {
			121, 122, 103, 42, 241, 390, 81, 61, 384, 386, 221, 341, 101,
			301, 102, 123, 392, 321, 395, 161, 124, 385, 201, 125, 126
		};
	elseif WOW4 then
		tCurrency = {
			789, 241, 390, 61, 515, 398, 384, 697, 81, 615, 393, 392, 361,
			402, 395, 738, 754, 416, 677, 752, 614, 400, 394, 397, 676, 777,
			401, 391, 385, 396, 399, 776
		};
	end

	CHD_Message(L.GetCurrency);

	if WOW3 then
		for i = 1, GetCurrencyListSize() do
			-- name, isHeader, isExpanded, isUnused, isWatched, count, extraCurrencyType, icon, itemID = GetCurrencyListInfo(index)
			local _, isHeader, _, _, _, count, _, _, itemID = GetCurrencyListInfo(i);
			--print(name, count, itemID);
			if (not isHeader) and itemID and (count > 0) then
				table.insert(res, itemID, count);
			end
		end
	else
		for _, currencyId in ipairs(tCurrency) do
			-- name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(id)
			local name, amount, _, _, _, _, isDiscovered = GetCurrencyInfo(currencyId);
			--print(k, currencyId, amount, name);
			if name and isDiscovered and amount > 0 then
				table.insert(res, currencyId, amount);
			end
		end
	end

	return res;
end

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

-- TODO: remove
function compSpell(a, b)
	return a[1] < b[1];
end

local function CHD_GetSpellInfo()
	local res = {};

	CHD_Message(L.GetSpell);
	for i = 1, MAX_SKILLLINE_TABS do
		local name, _, offset, numSpells = GetSpellTabInfo(i);
		if not name then
			break;
		end
		for j = offset + 1, offset + numSpells do
			local spellLink = GetSpellLink(j, BOOKTYPE_SPELL);
			if spellLink then
				local spellid = tonumber(strmatch(spellLink, "Hspell:(%d+)"));
				table.insert(res, spellid, i);
			end
		end
	end
	table.sort(res, function (v1, v2) return v1[1] < v2[1] end);

	return res;
end

local function CHD_GetMountInfo()
	local res = {};

	CHD_Message();
	for i = 1, GetNumCompanions("MOUNT") do
		local _, _, spellID = GetCompanionInfo("MOUNT", i);
		res[i] = spellID;
	end
	sort(res);

	return res;
end

local function CHD_GetCritterInfo()
	local res = {};

	CHD_Message(L.GetCritter);
	for i = 1, GetNumCompanions("CRITTER") do
		local _, _, spellID = GetCompanionInfo("CRITTER", i);
		res[i] = spellID;
	end
	sort(res);

	return res;
end

local function CHD_GetRepInfo()
	local res = {};
	local tblRep = {};

	CHD_Message(L.GetReputation);
	ExpandAllFactionHeaders();
	for i = 1, GetNumFactions() do
		local name = GetFactionInfo(i);
		tblRep[name] = true;
	end

	for i = 1, 1160 do -- maximum 1160 for 3.3.5a
		local name, _, _, _, _, barValue, atWarWith, canToggleAtWar, isHeader, _, _, isWatched = GetFactionInfoByID(i);
		if name and tblRep[name] then
			local flags = 1;
			if canToggleAtWar and atWarWith then
				flags = bit.bor(1, 2);
			end
			table.insert(res, {["I"] = i, ["V"] = barValue, ["F"] = flags});
		end
	end

	return res;
end

local function CHD_GetAchievementInfo()
	local res = {};

	CHD_Message(L.GetAchievement);

	local count = 0;
	local guildCount = 0;
	local personalCount = 0;

	local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch;
	local posixtime;

	for i = 1, 10000 do
		status, id, _ --[[name]], _, completed, month, day, year, _ --[[description]], _, _, _, isGuildAch = pcall(GetAchievementInfo, i);

		if status then
			count = count + 1;
			if id and completed then
				if isGuildAch then
					guildCount = guildCount + 1;
				else
					posixtime = time({["year"] = 2000 + year, ["month"] = month, ["day"] = day});
					personalCount = personalCount + 1;
					if posixtime then
						table.insert(res, i, posixtime);
					end
				end
			end
		end
	end
--	print(string.format("debug: total %d, personal %d, guild %d", count, personalCount, guildCount));

	return res;
end

local function CHD_GetActionsInfo()
	local res = {};

--[[
0 Spell
1 Click
32 Eq set
64 Macro
65 Click macro
128 Item

companion, equipmentset, flyout, item, macro, spell
]]
	-- "equipmentset", "flyout"
	local arrType = {};
	arrType.companion = 0;
	arrType.item = 128;
	arrType.macro = 64;
	arrType.spell = 0;

	CHD_Message(L.GetAction);
	for i = 1, 120 do -- (6 + 4) panels * 12 buttons
		local t, id, subType, spellID = GetActionInfo(i);
		if t and arrType[t] then
			local item = {};
			item.T = arrType[t];
			if t == "spell" or t == "companion" then
				item.I = spellID;
			else -- item and macro
				item.I = id;
			end
			res[i] = item;
		end
	end

	return res;
end

--[[
CanShowAchievementUI - Returns whether the Achievements UI should be enabled
GetAchievementCriteriaInfo - Gets information about criteria for an achievement or data for a statistic
GetAchievementInfo - Gets information about an achievement or statistic
GetAchievementLink - Returns a hyperlink representing the player's progress on an achievement
GetAchievementNumRewards - Returns the number of point rewards for an achievement (currently always 1)
GetAchievementReward - Returns the number of achievement points awarded for earning an achievement
GetCategoryInfo - Returns information about an achievement/statistic category
GetCategoryNumAchievements - Returns the number of achievements/statistics to display in a category
GetNumComparisonCompletedAchievements - Returns the number of achievements earned by the comparison unit
GetNumCompletedAchievements - Returns the number of achievements earned by the player
GetStatistic - Returns data for a statistic that can be shown on the statistics tab of the achievements window
GetStatisticsCategoryList - Returns a list of all statistic categories
GetTotalAchievementPoints - Returns the player's total achievement points earned
HasCompletedAnyAchievement - Checks if the player has completed at least 1 achievement
SetAchievementComparisonUnit - Enables comparing achievements/statistics with another player
--]]

local function CHD_GetCriteriasInfo()
	local res = {};

	local categories = GetCategoryList(); --  A list of achievement category IDs (table)

	CHD_Message(L.GetCriterias);
	for k, categoryId in ipairs(categories) do
		--local name, parentID, flags = GetCategoryInfo(categoryId);
		--if categoryId == 178 then --
		local numItems, numCompleted = GetCategoryNumAchievements(categoryId); -- Returns the number of achievements/statistics to display in a category.

		for i = 1, numItems do
			local achievementID, name, points, completed, Month, Day, Year, description, flags, _, rewardText, isGuildAch = GetAchievementInfo(categoryId, i);
			for j = 1, GetAchievementNumCriteria(achievementID) do
				local description, type, completedCriteria, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfo(achievementID, j);
				if criteriaID and quantity > 0 then
					table.insert(res, criteriaID, quantity);
				end
			end
		end
	end

	return res;
end

local function CHD_GetStatisticInfo()
	local res = {};

	--local categories = GetCategoryList(); -- A list of achievement category IDs (table)
	local categories = GetStatisticsCategoryList(); --  A list of statistic category IDs (table)

	CHD_Message(L.GetStatistic);
	for k, categoryId in ipairs(categories) do
		--local name, parentID, flags = GetCategoryInfo(categoryId);
		--print(string.format("categoryId: %d, name: %s, parentID: %d, flags: %d", categoryId, name, parentID, flags));

		local numItems, numCompleted = GetCategoryNumAchievements(categoryId); -- Returns the number of achievements/statistics to display in a category.
		--local categoryItem = {};
		--categoryItem.N = name;

		for i = 1, numItems do
			local statisticID, name, points, completed, Month, Day, Year, description, flags, _, rewardText, isGuildAch = GetAchievementInfo(categoryId, i);
			local description, type, completedCriteria, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfo(statisticID, 1);
			if criteriaID and completedCriteria and quantity > 0 then
				--table.insert(categoryItem, criteriaID, {["Q"] = quantity, ["N"] = name});
				table.insert(res, criteriaID, quantity);
			end
		end
		--table.insert(res, categoryId, categoryItem);
	end

	return res;
end

-- TODO: remove
function compSkill(e1, e2)
	return e1.N < e2.N;
end

local function CHD_GetSkillInfo()
	local res = {};

	if not WOW3 then
		return res;
	end

	local i = 1;
	while true do
		local name, isHeader = GetSkillLineInfo(i);
		if not name then
			break;
		end
		if isHeader then
			ExpandSkillHeader(i, 1);
		end
		i = i + 1;
	end

	CHD_Message(L.GetSkill);
	for i = 1, GetNumSkillLines() do
		local skillName, _, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i);
		if skillName and (skillRank > 0) and (skillMaxRank > 0) then
			table.insert(res, {["N"] = skillName, ["R"] = skillRank, ["M"] = skillMaxRank});
		end
	end
	table.sort(res, compSkill);

	return res;
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

local function CHD_GetInventoryInfo()
	local res = {};
	local index = 24;

	CHD_Message(L.GetInventory);
	-- 1..19 equipped items +
	-- 20-23 Equipped Bags +
	-- 24-39 Main Backpack +
	-- 40-67 Main Bank
	-- 68-74 Bank Bags
	-- 86-117 Keys in Keyring +

	for i = 1, 23 do
		local itemLink = GetInventoryItemLink("player", i);
		if itemLink then
			local count = GetInventoryItemCount("player", i);
			for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do 
				local tmpItem = {
					["I"] = tonumber(id)
				};
				if count > 1 then tmpItem["N"] = count end
				if tonumber(enchant) > 0 then tmpItem["H"] = tonumber(enchant) end
				if tonumber(gem1) > 0 then tmpItem["G1"] = tonumber(gem1) end
				if tonumber(gem2) > 0 then tmpItem["G2"] = tonumber(gem2) end
				if tonumber(gem3) > 0 then tmpItem["G3"] = tonumber(gem3) end

				res[i] = tmpItem;
			end
		end
	end

	local container = 0;
	for slot = 1, GetContainerNumSlots(container) do
		local itemLink = GetContainerItemLink(container, slot);
		if itemLink then
			local _, count = GetContainerItemInfo(container, slot);
			for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink, ".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do 
				local tmpItem = {
					["I"] = tonumber(id)
				};
				if count > 1 then tmpItem["N"] = count end
				if tonumber(enchant) > 0 then tmpItem["H"] = tonumber(enchant) end
				if tonumber(gem1) > 0 then tmpItem["G1"] = tonumber(gem1) end
				if tonumber(gem2) > 0 then tmpItem["G2"] = tonumber(gem2) end
				if tonumber(gem3) > 0 then tmpItem["G3"] = tonumber(gem3) end

				res[index] = tmpItem;
			end
		end
		index = index + 1;
	end

	container = -2;
	index = 86;
	for slot = 1, GetContainerNumSlots(container) do
		local itemLink = GetContainerItemLink(container, slot);
		if itemLink then
			local id = GetContainerItemID(container, slot);
			local _, count = GetContainerItemInfo(container, slot);
			tmpItem = {
				["I"] = tonumber(id)
			};
			if count > 1 then tmpItem["N"] = count end
			res[index] = tmpItem;
		end
		index = index + 1;
	end

	return res;
end

local function CHD_GetBagInfo()
	local res = {};

	CHD_Message(L.GetBag);

	for bag = 1, NUM_BAG_SLOTS do
		local nCount = 0;
		local tmpBag = {};
		for slot = 1, GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot);
			local _, count = GetContainerItemInfo(bag, slot);

			if itemLink and count then
				local tmpItem = {};
				for id, enchant, gem1, gem2, gem3 in string.gmatch(itemLink,".-Hitem:(%d+):(%d+):(%d+):(%d+):(%d+)") do
					tmpItem = {
						["I"] = tonumber(id)
					};
					if count > 1 then tmpItem["N"] = count end
					if tonumber(enchant) > 0 then tmpItem["H"] = tonumber(enchant) end
					if tonumber(gem1) > 0 then tmpItem["G1"] = tonumber(gem1) end
					if tonumber(gem2) > 0 then tmpItem["G2"] = tonumber(gem2) end
					if tonumber(gem3) > 0 then tmpItem["G3"] = tonumber(gem3) end
				end
				nCount = nCount + 1;
				table.insert(tmpBag, tmpItem);
			end
		end
		table.insert(res, tmpBag);
		CHD_Message(string.format(L.ScaningBagTotal, bag, nCount));
	end

	return res;
end

local function CHD_GetEquipmentInfo()
	local res = {};
	local equip;

	CHD_Message(L.GetEquipment);
	for i = 1, GetNumEquipmentSets() do
		local name, icon = GetEquipmentSetInfo(i);
		if name then
			equip = {};
			equip["items"] = GetEquipmentSetItemIDs(name); -- return table 1..19
			equip["name"] = name;
			res[i] = equip;
		end
	end

	return res;
end

-- TODO: remove
function compQuestlog(e1, e2)
	return e1.Q < e2.Q;
end

local function CHD_GetQuestlogInfo()
	local res = {};
	local numEntries, numQuests = GetNumQuestLogEntries();

	CHD_Message(L.GetQuestlog);
	j = 1;
	for i = 1, numEntries do
		local _, _, _, _, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(i);
		local link, _, charges = GetQuestLogSpecialItemInfo(i);
	-- - 1 - The quest was failed
	--   1 - The quest was completed
	-- nil - The quest has yet to reach a conclusion
		-- questID, isComplete, itemID
		if isHeader == nil then
			if isComplete ~= 1 then
				isComplete = 0;
			end
			local itemID = 0;
			if link then
				itemID = tonumber(strmatch(link, "Hitem:(%d+)"));
			end
			res[j] = {["Q"] = questID, ["B"] = isComplete, ["I"] = itemID};
			j = j + 1;
		end
	end
	table.sort(res, compQuestlog);

	return res;
end

local function CHD_GetPMacroInfo()
	local res = {};

	CHD_Message(L.GetMacro);
	local count = 1;
	local _, numCharacterMacros = GetNumMacros();
	local nIconPos = string.len("Interface\\Icons\\") + 1;
	for i = 36 + 1, 36 + numCharacterMacros do
		local name, texture, body = GetMacroInfo(i);
		texture = string.sub(texture, nIconPos);
		res[count] = {["N"] = name, ["T"] = texture, ["B"] = body};
		count = count + 1;
	end

	return res;
end

local function CHD_GetAMacroInfo()
	local res = {};

	local count = 1;
	local numAccountMacros = GetNumMacros();
	local nIconPos = string.len("Interface\\Icons\\") + 1;
	for i = 1, numAccountMacros do
		local name, texture, body = GetMacroInfo(i);
		texture = string.sub(texture, nIconPos);
		res[count] = {["N"] = name, ["T"] = texture, ["B"] = body};
		count = count + 1;
	end

	return res;
end

local function CHD_GetFriendsInfo()
	local res = {};

	CHD_Message(L.GetFriends);
	for i = 1, GetNumFriends() do
		local name =  GetFriendInfo(i);
		res[i] = name;
	end;

	return res;
end

local function CHD_GetIgnoresInfo()
	local res = {};

	CHD_Message(L.GetIgnores);
	for i = 1, GetNumIgnores() do
		local name = GetIgnoreName(i);
		res[i] = name;
	end;

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

local function CHD_GetTitlesInfo()
	local res = {};

	CHD_Message(L.GetTitles);
	for i = 1, GetNumTitles() do
		if IsTitleKnown(i) == 1 then
			table.insert(res, i);
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
		dump.amacro = {}; -- CHD_trycall(CHD_GetAMacroInfo) or {};
	else
		dump.pmacro = {};
		dump.amacro = {};
	end
	CHD_frmMainchbMacroText:SetText(L.chbMacro .. string.format(" (%d)",
		#dump.pmacro + #dump.amacro));

	if CHD_frmMainchbFriend:GetChecked() then
		dump.friend = CHD_trycall(CHD_GetFriendsInfo) or {};
		dump.ignore = CHD_trycall(CHD_GetIgnoresInfo) or {};
	else
		dump.friend = {};
		dump.ignore = {};
	end
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