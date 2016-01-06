local chardumps = chardumps;
local L = chardumps:GetLocale();
local CHD_arrCheckboxes = CHD_arrCheckboxes or {};

function CHD_BankDel()
	CHD_SERVER_LOCAL.bank = {};
	CHD_SERVER_LOCAL.bank.mainbank = {};
	CHD_frmMainchbBankText:SetText(L.chbBank);
	CHD_Message(L.DeleteBank);
end;

function OnCHD_frmMainbtnBankDelClick()
	CHD.MessageBox.Title:SetText(L.DeleteBank);
	CHD.MessageBox.OnOK = CHD_BankDel;
	CHD.MessageBox:Show();
end

function CHD_QuestDel()
	CHD_SERVER_LOCAL.quest = {};
	CHD_frmMainchbQuestsText:SetText(L.chbQuests);
	CHD_Message(L.DeleteQuests);
end;

function OnCHD_frmMainbtnQuestDelClick()
	CHD.MessageBox.Title:SetText(L.DeleteQuests);
	CHD.MessageBox.OnOK = CHD_QuestDel;
	CHD.MessageBox:Show();
end

function CHD_TaxiDel()
	CHD_TAXI = {};
	CHD_frmMainchbTaxiText:SetText(L.chbTaxi);
	CHD_Message(L.DeleteTaxi);
end;

function OnCHD_frmMainbtnTaxiDelClick()
	CHD.MessageBox.Title:SetText(L.DeleteTaxi);
	CHD.MessageBox.OnOK = CHD_TaxiDel;
	CHD.MessageBox:Show();
end

function CHD_SkillSpellDel()
	CHD_SERVER_LOCAL.skillspell = {};
	CHD_frmMainchbSkillSpellText:SetText(L.chbSkillSpell);
	SetTooltip(CHD_frmMainchbSkillSpell, L.chbSkillSpell, L.ttchbSkillSpell);
	CHD_Message(L.DeleteSkillSpell);
end

function OnCHD_frmMainbtnSkillSpellDelClick()
	CHD.MessageBox.Title:SetText(L.DeleteSkillSpell);
	CHD.MessageBox.OnOK = CHD_SkillSpellDel;
	CHD.MessageBox:Show();
end

function CHD_OnQueryQuestClick()
	QueryQuestsCompleted();
	if CHD_frmMainchbQuests:GetChecked() then
		CHD_SERVER_LOCAL.quest = CHD_trycall(CHD_GetQuestInfo) or {};
		CHD_frmMainchbQuestsText:SetText(L.chbQuests .. string.format(" (%d)", #CHD_SERVER_LOCAL.quest));
	else
		CHD_SERVER_LOCAL.quest = {};
		CHD_frmMainchbQuestsText:SetText(L.chbQuests .. " (0)");
	end
end;

function CHD_Init(self)

	local btn = CHD_CreateButton("btnQuestQuery", 180, chbHeight * 9 + 8, 150, btnHeight, self);
	btn:SetScript("OnClick", CHD_OnQueryQuestClick);

	CHD_OnLoad(self);
end
