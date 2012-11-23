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
L.chbEquipment    = "Наборы экипировки"
L.chbQuestlog     = "Журнал заданий"

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
L.GetCritter      = "  Чтение спутников"
L.GetReputation   = "  Чтение репутации"
L.GetAchievement  = "  Чтение достижений"
L.GetSkill        = "  Чтение навыков"
L.GetInventory    = "  Чтение одетых вещей"
L.GetBag          = "  Чтение сумок"
L.ScaningBagTotal = "    сумка %d, количество: %d"
L.GetEquipment    = "  Чтение наборов экипировки"
L.GetQuestlog     = "  Чтение журнала заданий"

L.GetBank         = "Чтение банка"
L.ScaningBankTotal= "  банковская ячейка %d, количество %d"
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

-- tooltip
L.ttbtnMinimize   = "Свернуть"
L.ttbtnHide       = "Скрыть"
L.ttchbGlyphs     = "Включить/Отключить сохранение информации о глифах"
L.ttchbCurrency   = "Включить/Отключить сохранение валюты"
L.ttchbSpells     = "Включить/Отключить сохранение заклинаний"
L.ttchbMounts     = "Включить/Отключить сохранение транспорта"
L.ttchbCritters   = "Включить/Отключить сохранение спутников"
L.ttchbReputation = "Включить/Отключить сохранение репутации"
L.ttchbAchievements = "Включить/Отключить сохранение достижений"
L.ttchbSkills     = "Включить/Отключить сохранение навыков"
L.ttchbInventory  = "Включить/Отключить сохранение одетых вещей"
L.ttchbBags       = "Включить/Отключить сохранение предметов в сумках"
L.ttchbEquipment  = "Включить/Отключить сохранение наборов экипировки"
L.ttchbQuestlog   = "Включить/Отключить сохранение журнала заданий"

L.ttchbBank       = "Включить/Отключить сохранение предметов банка"
L.ttchbQuests     = "Включить/Отключить сохранение заданий"
L.ttchbTaxi       = "Включить/Отключить сохранение полетов\n(1, 2, 3, 4)\n1 -- полеты в Калимдоре\n2 -- полеты в Восточных Королевствах\n3 -- полеты в Запределье\n4 -- полеты в Нордсколе"

L.ttbtnClientDump = "Создать клиентский дамп персонажа"
L.ttbtnServerQuery = "Получить выполненные задания с сервера"

L.btnServerQuery  = "Запрос с сервера"
L.btnClientDump   = "Дамп с клиента"
L.CreatingDump    = "Создание дампа..."
L.CreatedDump     = "Создание дампа прошло успешно"
L.DumpDone        = "Создано! Дамп находится здесь: каталог WoW/WTF/Account/%ИмяАккаунта%/SavedVariables/\124cFF00FF00chardumps.lua\124r"