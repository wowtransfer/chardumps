--[[
	Chardumps Localization: Russian
--]]

local L = LibStub('AceLocale-3.0'):NewLocale('chardumps', 'ruRU')
if not L then
	return
end

-- help
L.help1 = "/chardumps or /chd -- консольная команда"
L.help2 = "/chardumps show -- показать главное окно"
L.help3 = "/chardumps -- показать справку"

-- interface
L.chbPlayer       = "Игрок"
L.chbGlobal       = "Общее"
L.chbGlyphs       = "Глифы"
L.chbCurrency     = "Валюта"
L.chbSpells       = "Заклинания"
L.chbMounts       = "Транспорт"
L.chbCritters     = "Спутники"
L.chbReputation   = "Репутация"
L.chbAchievements = "Достижения"
L.chbSkills       = "Навыки"
L.chbInventory    = "Одетые вещи"
L.chbBags         = "Сумки"

L.chbBank         = "Банк"
L.chbQuests       = "Задания"
L.chbTaxi         = "Полеты"

L.loadmessage = "Аддон загружен, создатель \124cff0000ffSlaFF\124r"

-- Get...
L.GetGlobal       = "  Чтение глобальной информации"
L.GetPlayer       = "  Чтение информации о персонаже"
L.GetPlyph        = "  Чтение информации о глифах"
L.GetCurrency     = "  Чтение валюты"
L.GetSpell        = "  Чтение книги заклинаний"
L.GetMount        = "  Чтение транспорта"
L.GetCritter      = "  Чтение питомцев"
L.GetReputation   = "  Чтение репутации"
L.GetAchievement  = "  Чтение достижений"
L.GetSkill        = "  Чтение навыков"
L.GetInventory    = "  Чтение одетых вещей"
L.GetBag          = "  Чтение сумок"
L.ScaningBagTotal = "    сумка %d, количество: %d"

L.GetBank         = "  Чтение банка"
L.ScaningBankTotal= "    банковская ячейка %d, количество %d"
L.GetQuest        = "Чтение выполненных квестов"
L.CountOfCompletedQuests = "  количество выполненных заданий "
L.GetTaxi         = "Чтение полетов для карты "
L.CountOfTaxi     = "  количество полетов "
L.Kalimdor        = "Калимдор"
L.EasternKingdoms = "Восточные королевства"
L.Outland         = "Запределье"
L.Northrend       = "Нордскол"
L.Maelstrom       = "Maelstrom"
L.Pandaria        = "Pandaria"

L.CreatingDump    = "Создание дампа..."
L.CreatedDump     = "Создание дампа прошло успешно"
L.DumpDone        = "Создано! Дамп находится здесь: каталог WoW/WTF/Account/%ИмяАккаунта%/SavedVariables/\124cFF00FF00chardumps.lua\124r"