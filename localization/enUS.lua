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
L.chbPlayer       = "Player"
L.chbGlobal       = "Global"
L.chbGlyphsText   = "Glyphs"
L.chbCurrencyText = "Currency"
L.chbSpells       = "Spells"
L.chbMounts       = "Mounts"
L.chbCritters     = "Critters"
L.chbReputation   = "Reputation"
L.chbAchievements = "Achievements"
L.chbSkills       = "Skills"
L.chbInventory    = "Inventory"
L.chbBags         = "Bags"
L.chbBank         = "Bank"
L.chbQuests       = "Quests"

L.loadmessage = "Addon is loaded, created by |cff0000ffSlaFF|r"

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
L.GetBank         = "  Get bank`s information"
L.ScaningBankTotal= "    bank`s bag: %d, count: %d"
L.GetQuest        = "  Get quest inforamation"
L.CountOfCompletedQuests = "    count of completed quests "


L.CreatingDump    = "Creating dump..."

L.CreatedDump     = "Creation of dump was successful"
L.DumpDone        = "DONE! You can find dump here: WoW Folder /WTF/Account/%AccountName%/SavedVariables/chardumps.lua"