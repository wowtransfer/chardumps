--[[
	Chardumps Localization: English
--]]

local L = LibStub("AceLocale-3.0"):NewLocale("chardumps", "enUS", true)
if not L then
	return
end

-- help
L.help1 = "/chardumps or /chd -- console command"
L.help2 = "/chardumps show -- show the main frame"
L.help3 = "/chardumps -- show help"

-- interface
L.chbGlyphs       = "Glyphs"
L.chbCurrencyText = "Currency"
L.chbSpells       = "Spells"
L.chbMounts       = "Mounts"
L.chbCritters     = "Critters"
L.chbReputation   = "Reputation"
L.chbAchievements = "Achievements"
L.chbSkills       = "Skills"
L.chbInventory    = "Inventory"
L.chbBags         = "Bags"
L.chbEquipment    = "Equipment Sets"
L.chbQuestlog     = "Quest log"
L.chbMacro        = "Macroses"
L.chbFriend       = "Friends"
L.chbArena        = "Arena"

L.chbBank         = "Bank"
L.chbQuests       = "Quests"
L.chbTaxi         = "Taxi"

L.loadmessage = "Addon is loaded, created by \124cff0000ffSlaFF\124r"

-- Get...
L.GetGlobal       = "  Get global information"
L.GetPlayer       = "  Get player`s information"
L.GetPlyph        = "  Get glyphs information"
L.GetCurrency     = "  Get currency information"
L.GetSpell        = "  Get spell book"
L.GetMount        = "  Get mounts information"
L.GetCritter      = "  Get critters information"
L.GetReputation   = "  Get reputation information"
L.GetAchievement  = "  Get achievement information"
L.GetSkill        = "  Get skill information"
L.GetInventory    = "  Get inventory information"
L.GetBag          = "  Get bag`s information"
L.ScaningBagTotal = "    bag %d, count: %d"
L.GetEquipment    = "  Get equipment sets information"
L.GetQuestlog     = "  Get quests in the log"
L.GetMacro        = "  Get macro information"
L.GetFriends      = "  Get friends"
L.GetIgnores      = "  Get ignores"
L.GetArena        = "  Get arena information"

L.GetBank         = "Get bank`s information"
L.ScaningBankTotal= "  bank`s bag: %d, count: %d"
L.GetQuest        = "Get quest information"
L.CountOfCompletedQuests = "  count of completed quests "
L.GetTaxi         = "Get Taxi/Flight information for map "
L.CountOfTaxi     = "  count of taxi "
L.Kalimdor        = "Kalimdor"
L.EasternKingdoms = "Eastern Kingdoms"
L.Outland         = "Outland"
L.Northrend       = "Northrend"
L.Maelstrom       = "Maelstrom"
L.Pandaria        = "Pandaria"

-- tooltip
L.ttbtnMinimize   = "Minimize"
L.ttbtnHide       = "Hide"
L.ttchbGlyphs     = "On/Off save of glyphs"
L.ttchbCurrency   = "On/Off save of currency"
L.ttchbSpells     = "On/Off save of spells"
L.ttchbMounts     = "On/Off save of mounts"
L.ttchbCritters   = "On/Off save of critters"
L.ttchbReputation = "On/Off save of reputation"
L.ttchbAchievements = "On/Off save of achievements and criteries\n\124cFFFF0000Need a lot of time\124r"
L.ttchbSkills     = "On/Off save of skills"
L.ttchbInventory  = "On/Off save of inventory"
L.ttchbBags       = "On/Off save of items in bags"
L.ttchbEquipment  = "On/Off save of equipment sets"
L.ttchbQuestlog   = "On/Off save of quest log"
L.ttchbMacro      = "On/Off save of macroses"
L.ttchbFriend     = "On/Off save of friends and ignores\n(N, M)\n N -- count of friends\n M -- count of ignores"
L.ttchbArena      = "On/Off save of arena"

L.ttchbBank       = "On/Off save of items in the bank"
L.ttchbQuests     = "On/Off save of completed quests"
L.ttchbTaxi       = "On/Off save of taxi\n(1, 2, 3, 4)\n1 -- taxi in Kalimdor\n2 -- taxi in Eastern Kingdoms\n3 -- taxi in Outland\n4 -- taxi in Northrend"

L.ttbtnClientDump = "Create the client dump of player"
L.ttbtnServerQuery = "Receive the completed quests from server"
L.ttbtnBankDel    = "Delete bank`s information"
L.ttbtnQuestDel   = "Delete quest`s information"
L.ttbtnTaxiDel    = "Delete taxi`s information"

L.btnServerQuery  = "Server query"
L.btnClientDump   = "Client dump"
L.CreatingDump    = "Creating dump..."
L.CreatedDump     = "Creation of dump was successful"
L.DumpDone        = "DONE! You can find dump here: WoW Folder /WTF/Account/%AccountName%/SavedVariables/chardumps.lua"