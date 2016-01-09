local chardumps = chardumps or {};
local L = chardumps:GetLocale();



function CHD_OnDumpClick()
	local dump = {};

	CHD_frmMainchbCurrencyText:SetText(L.chbCurrency .. string.format(" (%d)",
		chardumps.getTableLength(dump.currency)));
	local honor, ap, cp = CHD_GetPvpCurrency(dump.currency);
	dump.player.honor = honor;
	dump.player.ap    = ap; -- Arena Points
	dump.player.cp    = cp; -- Conquest Points
end
