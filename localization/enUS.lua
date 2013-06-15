--[[
	Chardumps Localization: English
--]]

local L = LibStub("AceLocale-3.0"):NewLocale("chardumps", "enUS", true)
if not L then
	return
end

L.AddonName       = "Chardumps"
L.Version         = "1.9"

-- help
L.help1 = "/chardumps or /chd -- console command"
L.help2 = "/chardumps show -- show the main frame"
L.help3 = "/chardumps -- show help"

-- interface
L.chbGlyphs       = "Glyphs"
L.chbCurrency     = "Currency"
L.chbSpells       = "Spells"
L.chbMounts       = "Mounts"
L.chbCritters     = "Critters"
L.chbReputation   = "Reputation"
L.chbAchievements = "Achievements"
L.chbActions      = "Actions"
L.chbSkills       = "Skills"
L.chbSkillSpell   = "Spells of skill"
L.chbInventory    = "Inventory"
L.chbBags         = "Bags"
L.chbEquipment    = "Equipment Sets"
L.chbQuestlog     = "Quest log"
L.chbMacro        = "Macroses"
L.chbFriend       = "Friends"
L.chbArena        = "Arena"
L.chbPet          = "Pets"

L.chbBank         = "Bank"
L.chbBind         = "Bindings"
L.chbQuests       = "Quests"
L.chbTaxi         = "Taxi"

L.chbCrypt        = "Crypt"

L.loadmessage = "Addon is loaded, created by SlaFF, GracerPro@gmail.com"

-- Get...
L.GetGlobal       = "  Get global information"
L.GetPlayer       = "  Get player`s information"
L.GetPlyph        = "  Get glyphs information"
L.GetCurrency     = "  Get currency information"
L.GetSpell        = "  Get spells"
L.GetMount        = "  Get mounts information"
L.GetCritter      = "  Get critters information"
L.GetReputation   = "  Get reputation information"
L.GetAchievement  = "  Get achievement information"
L.GetAction       = "  Get actions information"
L.GetSkill        = "  Get skill information"
L.GetSkillSpell   = "  Get spells of skill \"%s\""
L.TradeSkillFound = "    found %d spells"
L.GetInventory    = "  Get inventory information"
L.GetBag          = "  Get bag`s information"
L.ScaningBagTotal = "    bag %d, item`s found: %d"
L.GetEquipment    = "  Get equipment sets information"
L.GetQuestlog     = "  Get quests in the log"
L.GetMacro        = "  Get macro information"
L.GetFriends      = "  Get friends"
L.GetIgnores      = "  Get ignores"
L.GetArena        = "  Get arena information"

L.GetBank         = "  Get bank`s information"
L.ReadMainBankBag = "  Main bank: %d items"
L.GetBind         = "  Get bindings information"
L.ScaningBankTotal= "  bank`s bag: %d, count: %d"
L.GetQuest        = "  Get quest information"
L.CountOfCompletedQuests = "  count of completed quests "
L.GetTaxi         = "  Get Taxi/Flight information for map "
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
L.ttchbActions    = "On/Off save of actions"
L.ttchbSkills     = "On/Off save of skills"
L.ttchbSkillSpell = "On/Off save of skill`s spells"
L.ttchbInventory  = "On/Off save of inventory\n- Equipped items\n- Equipped bags\n- Main backpack\n- Main bank\n- Bank bags\n- Keys"
L.ttchbBags       = "On/Off save of items in bags"
L.ttchbEquipment  = "On/Off save of equipment sets"
L.ttchbQuestlog   = "On/Off save of quest log"
L.ttchbMacro      = "On/Off save of macroses"
L.ttchbFriend     = "On/Off save of friends and ignores\n(N, M)\n N -- count of friends\n M -- count of ignores"
L.ttchbArena      = "On/Off save of arena"
L.ttchbPet        = "On/Off save of pets"

L.ttchbBank       = "On/Off save of items in the bank\n(N, M)\n N -- count of items of main bank\n M -- count of items of additional bank bags"
L.ttchbBind       = "On/Off save of bindings"
L.ttchbQuests     = "On/Off save of completed quests"
L.ttchbTaxi       = "On/Off save of taxi\n(1, 2, 3, 4)\n1 -- taxi in Kalimdor\n2 -- taxi in Eastern Kingdoms\n3 -- taxi in Outland\n4 -- taxi in Northrend"

L.ttchbCrypt      = "Enable / Disable crypt of data"

L.ttbtnDump       = "Create the dump of player"
L.ttbtnQuestQuery = "Receive the completed quests from server"
L.ttbtnBankDel    = "Delete bank`s information"
L.ttbtnQuestDel   = "Delete quest`s information"
L.ttbtnTaxiDel    = "Delete taxi`s information"
L.ttbtnSkillSpellDel = "Delete skill`s spells information"
L.ttbtnCheckAll   = "Set all"
L.ttbtnCheckNone  = "Set none"
L.ttbtnCheckInv   = "Invert"

L.DeleteBank      = "Delete the bank"
L.DeleteQuests    = "Delete the quests"
L.DeleteTaxi      = "Delete the taxi"
L.DeleteSkillSpell = "Delete the skill`s spells"
L.Yes             = "Yes"
L.No              = "No"
L.areyousure      = "Are you sure?"
L.btnCheckAll     = "+"
L.btnCheckNone    = "-"
L.btnCheckInv     = "-+"
L.btnQuestDel     = "-"
L.btnBankDel      = "-"
L.btnTaxiDel      = "-"
L.btnSkillSpellDel = "-"
L.btnMinimize     = "_"
L.btnHide         = "x"
L.btnQuestQuery   = "Query the quests"
L.btnDump         = "Dump"
L.CreatingDump    = "Creating dump..."
L.CreatedDump     = "Creation of dump was successful"
L.Comboboxes      = "Checkboxes"
L.DumpDone        = "DONE! You can find dump here:\
WoW Folder/\
 WTF/\
  Account/\
   %AccountName%/\
    %RealmName%/\
     %PlayerName%/\
      SavedVariables/\
       \124cFF00FF00chardumps.lua\124r"