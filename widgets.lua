local chardumps = chardumps;
local widgets = {
  chbWidth = 24,
  chbHeight = 22,
  btnWidth = 20,
  btnHeight = 20,
  --frameWidth = 540;
  --frameHeight = 310;
  frameIndex = 0,
};

---
-- @param table parent
-- @param table params
-- @field [parent=#params] string text
-- @field [parent=#params] string name
-- @field [parent=#params] number x
-- @field [parent=#params] number y
-- @field [parent=#params] number cx
-- @field [parent=#params] number cy
-- @field [parent=#params] string tooltipTitle
-- @field [parent=#params] string tooltip
-- @field [parent=#params] boolean withoutText
--
function widgets:CreateCheckbox(parent, params)
  local L = chardumps:GetLocale();
  params = params or {};
  parent = parent or UIParent;

  local chbName;
  if params.name ~= nil then
    chbName = params.name;
  else
    chbName = parent:GetName() .. self:genFrameName();
  end

  local template = "ChatConfigCheckButtonTemplate";
  if params.withoutText then
    template = nil;
  end
  local chb = CreateFrame("CheckButton", chbName, parent, template);

  if params.x ~= nil and params.y ~= nil then
    chb:ClearAllPoints();
    chb:SetPoint("TOPLEFT", params.x, params.y);
  end

  params.cx = params.cx or widgets.chbWidth;
  params.cy = params.cy or widgets.chbHeight;
  chb:SetWidth(params.cx);
  chb:SetHeight(params.cy);

  chb:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
  chb:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
  chb:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
  chb:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");

  params.tooltipTitle = params.tooltipTitle or L[chbName];
  if params.tooltipTitle ~= nil then
    widgets:SetTooltip(chb, params.tooltipTitle, L["tt" .. chbName]);
  end

  local chbText = getglobal(chb:GetName() .. "Text");
  if chbText then
    params.text = params.text or L[chbName];
    chbText:SetText(params.text);
  end

  return chb;
end

---
-- @return string
function widgets:genFrameName()
  self.frameIndex = self.frameIndex + 1;
  return "chdFrame" .. self.frameIndex;
end

---
-- @param table params
-- @field [parent=#params] string text
-- @field [parent=#params] string name
-- @field [parent=#params] number x
-- @field [parent=#params] number y Relative TOPLEFT
-- @field [parent=#params] number cx
-- @field [parent=#params] number cy
-- @field [parent=#params] string tooltipTitle
-- @field [parent=#params] string tooltip
--
function widgets:CreateButton(parent, params)
  local L = chardumps:GetLocale();
  params = params or {};
  parent = parent or UIParent;

  local btnName;
  if params.name ~= nil then
    btnName = params.name;
  else
    btnName = parent:GetName() .. self:genFrameName();
  end

  local btn = CreateFrame("Button", btnName, parent, "OptionsButtonTemplate");
  if params.x ~= nil and params.y ~= nil then
    btn:ClearAllPoints();
    btn:SetPoint("TOPLEFT", parent, params.x, params.y);
  end

  params.cx = params.cx or widgets.btnWidth;
  params.cy = params.cy or widgets.btnHeight;
  btn:SetWidth(params.cx);
  btn:SetHeight(params.cy);

  params.tooltipTitle = params.tooltipTitle or L[btnName];
  if params.tooltipTitle ~= nil then
    widgets:SetTooltip(btn, params.tooltipTitle, L["tt" .. btnName]);
  end
  params.text = params.text or L[btnName];
  btn:SetText(params.text);

  return btn;
end

local function CreateMessageBox()
  local L = chardumps:GetLocale();
  local dialog = CreateFrame("Frame", nil, UIParent);

  dialog:ClearAllPoints();
  dialog:SetPoint("CENTER", UIParent);
  dialog:SetHeight(78);
  dialog:SetWidth(200);

  dialog:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = {left = 1, right = 1, top = 1, bottom = 1},
  });
  dialog:SetFrameStrata("TOOLTIP");
  dialog:EnableMouse(true);
  dialog:SetMovable(true);

  dialog:SetScript("OnMouseDown", function(this)
    if ( ( ( not this.isLocked ) or ( this.isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then
      this:StartMoving();
      this.isMoving = true;
    end
  end);
  dialog:SetScript("OnMouseUp", function(this)
    if ( this.isMoving ) then
      this:StopMovingOrSizing();
      this.isMoving = false;
    end
  end);
  dialog:SetScript("OnHide", function(this)
    if ( this.isMoving ) then
      this:StopMovingOrSizing();
      this.isMoving = false;
    end
  end);

  dialog.Title = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal");
  dialog.Title:SetPoint("TOPLEFT", dialog, "TOPLEFT", 6, -10);
  dialog.Title:SetTextColor(1.0,1.0,0.0,1.0);
  dialog.Title:SetText("null");

  dialog.Text = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal");
  dialog.Text:SetPoint("CENTER",dialog,"CENTER",0,0);
  dialog.Text:SetTextColor(1.0,1.0,1.0);
  dialog.Text:SetText(L.areyousure);

  dialog.YesButton = CreateFrame("Button", nil, dialog, "OptionsButtonTemplate");
  dialog.YesButton:SetWidth(90);
  dialog.YesButton:SetHeight(24);
  dialog.YesButton:SetPoint("BOTTOMRIGHT", dialog, "BOTTOM", -4, 4);
  dialog.YesButton:SetScript("OnClick", function()
    if dialog.onOk then
      dialog:onOk();
    end
    dialog:Hide();
  end);
  dialog.YesButton:SetText(L.Yes);

  dialog.NoButton = CreateFrame("Button", nil, dialog, "OptionsButtonTemplate");
  dialog.NoButton:SetWidth(90);
  dialog.NoButton:SetHeight(24);
  dialog.NoButton:SetPoint("BOTTOMLEFT", dialog, "BOTTOM", 4, 4);
  dialog.NoButton:SetScript("OnClick", function() dialog:Hide() end);
  dialog.NoButton:SetText(L.No);

  dialog.SetTitle = function(title)
    dialog.Title:SetText(title);
  end

  return dialog;
end

---
-- Simple dialog with Ok and Cancel buttons
function widgets:ShowMessageBox(title, onOk)
  if self.messageBox == nil then
    self.messageBox = CreateMessageBox();
  end
  self.messageBox:SetTitle(title);
  self.messageBox.onOk = onOk;
  self.messageBox:Show();
end

---
-- Add tooltip to the frame
function widgets:SetTooltip(frame, title, text)
  if title == nil then
    return false;
  end
  frame.tooltipTitle = title;
  frame.tooltipText = text;
  frame:SetScript("OnEnter", function()
        GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT");
        GameTooltip:ClearLines();
        GameTooltip:SetText(frame.tooltipTitle);
        GameTooltip:AddLine(frame.tooltipText, 1, 1, 1, true);
        GameTooltip:Show();
      end);
  frame:SetScript("OnLeave", function() GameTooltip:Hide() end);
end

---
-- Return common addon backdrop
function widgets:GetBackdrop()
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

function widgets:GetFrameName(name, parentName)
  local result = "";
  if parentName ~= nil and type(parentName) == "string" then
    result = result .. parentName:sub(1, 1):upper() .. parentName:sub(2);
  end
  result = result .. name:sub(1, 1):upper() .. name:sub(2);

	return result;
end

function widgets:GetWidget(name)
  local realName = name:sub(1, 1):upper() .. name:sub(2);
  local frameName = framePrefix .. realName;
  return getglobal(frameName);
end

chardumps.widgets = widgets;
