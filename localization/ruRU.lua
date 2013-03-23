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
L.chbGlyphs       = "Символы"
L.chbCurrency     = "Валюта"
L.chbSpells       = "Заклинания"
L.chbMounts       = "Транспорт"
L.chbCritters     = "Спутники"
L.chbReputation   = "Репутация"
L.chbAchievements = "Достижения"
L.chbActions      = "Кнопки на панелях"
L.chbSkills       = "Навыки"
L.chbInventory    = "Инвентарь"
L.chbBags         = "Сумки"
L.chbEquipment    = "Наборы экипировки"
L.chbQuestlog     = "Журнал заданий"
L.chbMacro        = "Макросы"
L.chbFriend       = "Друзья"
L.chbArena        = "Арена"
L.chbPet          = "Питомцы"

L.chbBank         = "Банк"
L.chbQuests       = "Задания"
L.chbTaxi         = "Полеты"

L.chbActive       = "Активность"
L.chbCrypt        = "Шифрование"

L.loadmessage = "Аддон загружен, создатель SlaFF"

-- Get...
L.GetGlobal       = "  Чтение глобальной информации"
L.GetPlayer       = "  Чтение информации о персонаже"
L.GetPlyph        = "  Чтение информации о символах"
L.GetCurrency     = "  Чтение валюты"
L.GetSpell        = "  Чтение заклинаний"
L.GetMount        = "  Чтение транспорта"
L.GetCritter      = "  Чтение спутников"
L.GetReputation   = "  Чтение репутации"
L.GetAchievement  = "  Чтение достижений"
L.GetAction       = "  Чтение кнопок на панелях"
L.GetSkill        = "  Чтение навыков"
L.GetInventory    = "  Чтение одетых вещей"
L.GetBag          = "  Чтение сумок"
L.ScaningBagTotal = "    сумка %d, найдено предметов: %d"
L.GetEquipment    = "  Чтение наборов экипировки"
L.GetQuestlog     = "  Чтение журнала заданий"
L.GetMacro        = "  Чтение макросов"
L.GetFriends      = "  Чтение друзей"
L.GetIgnores      = "  Чтение игнорируемых"
L.GetArena        = "  Чтение команд арены"

L.GetBank         = "Чтение банка"
L.ScaningBankTotal= "  банковская ячейка %d, количество %d"
L.GetQuest        = "Чтение выполненных заданий"
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
L.ttchbGlyphs     = "Включить/Отключить сохранение информации о символах"
L.ttchbCurrency   = "Включить/Отключить сохранение валюты"
L.ttchbSpells     = "Включить/Отключить сохранение заклинаний"
L.ttchbMounts     = "Включить/Отключить сохранение транспорта"
L.ttchbCritters   = "Включить/Отключить сохранение спутников"
L.ttchbReputation = "Включить/Отключить сохранение репутации"
L.ttchbAchievements = "Включить/Отключить сохранение достижений и их критерии\nМожет занять длительное время"
L.ttchbActions    = "Включить/Отключить сохранение кнопок на панелях"
L.ttchbSkills     = "Включить/Отключить сохранение навыков"
L.ttchbInventory  = "Включить/Отключить сохранение инвентаря\n- Одетые вещи\n- Одетые сумки\n- Вещи в основном рюкзаке\n- Вещи в основном рюкзаке главного банка\n- Дополнительные сумки в банке\n- Ключи"
L.ttchbBags       = "Включить/Отключить сохранение предметов в сумках"
L.ttchbEquipment  = "Включить/Отключить сохранение наборов экипировки"
L.ttchbQuestlog   = "Включить/Отключить сохранение журнала заданий"
L.ttchbMacro      = "Включить/Отключить сохранение макросов"
L.ttchbFriend     = "Включить/Отключить сохранение друзей и игнорируемых\n(N, M)\n N -- количество друзей\n M -- количество игнорируемых"
L.ttchbArena      = "Включить/Отключить сохранение команд арены"
L.ttchbPet        = "Включить/Отключить сохранение питомцев"

L.ttchbBank       = "Включить/Отключить сохранение предметов банка"
L.ttchbQuests     = "Включить/Отключить сохранение заданий"
L.ttchbTaxi       = "Включить/Отключить сохранение полетов\n(1, 2, 3, 4)\n1 -- полеты в Калимдоре\n2 -- полеты в Восточных Королевствах\n3 -- полеты в Запределье\n4 -- полеты в Нордсколе"

L.ttchbActive     = "Включить/Отключить аддон"
L.ttchbCrypt      = "Включить/Отключить шифрование данных"

L.ttbtnDump       = "Создать дамп персонажа"
L.ttbtnServerQuery = "Получить выполненные задания с сервера"
L.ttbtnBankDel    = "Удалить информацию о предметах в банке"
L.ttbtnQuestDel   = "Удалить информацию о заданиях"
L.ttbtnTaxiDel    = "Удалить информацию о полетах"
L.ttbtnCheckAll   = "Установить все"
L.ttbtnCheckNone  = "Выключить все"
L.ttbtnCheckInv   = "Инвертировать"

L.DeleteBank      = "Удаление банка"
L.DeleteQuests    = "Удаление заданий"
L.DeleteTaxi      = "Удаление полетов"
L.Yes             = "Да"
L.No              = "Нет"
L.areyousure      = "Вы уверены?"
L.btnServerQuery  = "Запрос заданий"
L.btnDump         = "Дамп"
L.CreatingDump    = "Создание дампа..."
L.CreatedDump     = "Создание дампа прошло успешно"
L.Comboboxes      = "Переключатели"
L.DumpDone        = "Создано! Дамп находится здесь:\
каталог WoW/\
 WTF/\
  Account/\
   %ИмяАккаунта%/\
    %ИмяРеалма%/\
     %ИмяПерсонажа%/\
      SavedVariables/\
       \124cFF00FF00chardumps.lua\124r"