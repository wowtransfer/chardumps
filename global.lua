--[[
print("main_frame_hundle.lua");
print("CHD: ", CHD);
print("CHD_CLIENT: ", CHD_CLIENT);
print("CHD_TAXI: ", CHD_TAXI);
print("CHD_OPTIONS: ", CHD_OPTIONS);
print("MAX_NUM_CONTINENT: ", MAX_NUM_CONTINENT);
--]]
local L = LibStub("AceLocale-3.0"):GetLocale("chardumps");
CHD = CHD or {};
CHD_gArrCheckboxes = {};
CHD_SERVER_LOCAL = {};

MAX_NUM_CONTINENT = 4 -- 1..4


function CHD_Message(...)
	local x = {...};
	for k,v in pairs(x) do
		print("\124cFF9F3FFFchardumps:\124r ", tostring(v));
	end
end

function CHD_LogErr(str)
	print("\124c00FF0000"..(str or "nil").."\124r");
end

function CHD_LogWarn(str)
	print("\124c00FFFF00"..(str or "nil").."\124r");
end

function CHD_trycall(fun)
	local status, result = xpcall(fun, CHD_LogErr);

	if status then
		return result;
	end

	return nil;
end

function CHD_GetTableCount(t)
	local size = 0;

	if type(t) ~= "table" then
		return 0;
	end

	for k, v in pairs(t) do
		size = size + 1
	end

	return size;
end

function table.copy(t)
	local u = {};

	for k, v in pairs(t) do
		u[k] = v;
	end

	return setmetatable(u, getmetatable(t));
end


function CHD_CreateMessageBox()
	local theFrame = CreateFrame("Frame", nil, UIParent);

	theFrame:ClearAllPoints();
	theFrame:SetPoint("CENTER", UIParent);
	theFrame:SetHeight(78);
	theFrame:SetWidth(200);

	theFrame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {left = 1, right = 1, top = 1, bottom = 1},
	});
	theFrame:SetFrameStrata("TOOLTIP");
	theFrame:EnableMouse(true);
	theFrame:SetMovable(true);

	theFrame:SetScript("OnMouseDown", function(this)
		if ( ( ( not this.isLocked ) or ( this.isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then
			this:StartMoving();
			this.isMoving = true;
		end
	end);
	theFrame:SetScript("OnMouseUp", function(this)
		if ( this.isMoving ) then
			this:StopMovingOrSizing();
			this.isMoving = false;
		end
	end);
	theFrame:SetScript("OnHide", function(this)
		if ( this.isMoving ) then
			this:StopMovingOrSizing();
			this.isMoving = false;
		end
	end);

	theFrame.Title = theFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	theFrame.Title:SetPoint("TOPLEFT", theFrame, "TOPLEFT", 6, -10);
	theFrame.Title:SetTextColor(1.0,1.0,0.0,1.0);
	theFrame.Title:SetText("null");

	theFrame.Text = theFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	theFrame.Text:SetPoint("CENTER",theFrame,"CENTER",0,0);
	theFrame.Text:SetTextColor(1.0,1.0,1.0);
	theFrame.Text:SetText(L.areyousure);

	theFrame.YesButton = CreateFrame("Button", nil, theFrame, "OptionsButtonTemplate");
	theFrame.YesButton:SetWidth(90);
	theFrame.YesButton:SetHeight(24);
	theFrame.YesButton:SetPoint("BOTTOMRIGHT", theFrame, "BOTTOM", -4, 4);
	theFrame.YesButton:SetScript("OnClick", function()
		if theFrame.OnOK then
			theFrame:OnOK();
		end
		theFrame:Hide();
	end);
	theFrame.YesButton:SetText(L.Yes);

	theFrame.NoButton = CreateFrame("Button", nil, theFrame, "OptionsButtonTemplate");
	theFrame.NoButton:SetWidth(90);
	theFrame.NoButton:SetHeight(24);
	theFrame.NoButton:SetPoint("BOTTOMLEFT", theFrame, "BOTTOM", 4, 4);
	theFrame.NoButton:SetScript("OnClick", function() theFrame:Hide() end);
	theFrame.NoButton:SetText(L.No);

	theFrame:Hide();

	CHD.MessageBox = theFrame;
end

function SetTooltip(theFrame, Title, TooltipText)
	theFrame.title = Title;
	theFrame.tooltiptext = TooltipText;
	theFrame:SetScript("OnEnter", function()
				GameTooltip:SetOwner(theFrame, "ANCHOR_TOPLEFT");
				GameTooltip:ClearLines();
				GameTooltip:SetText(theFrame.title);
				GameTooltip:AddLine(theFrame.tooltiptext, 1, 1, 1, true);
				GameTooltip:Show();
			end);
	theFrame:SetScript("OnLeave", function() GameTooltip:Hide() end);
end

function CHD_GetBackdrop()
	local backdrop = {
		bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {
			left = 5,
			right = 5,
			top = 5,
			bottom = 5
		}
	}

	return backdrop;
end