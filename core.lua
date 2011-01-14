local AddOn = CreateFrame("Frame")
local OnEvent = function(self, event, ...) self[event](self, event, ...) end
AddOn:SetScript("OnEvent", OnEvent)

-- Skin function
local function skinbutton(f)
	f:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", 
								edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
								tileSize = 0, edgeSize = 1, 
								insets = { left = -1, right = -1, top = -1, bottom = -1}
	})
	f:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	f:SetBackdropBorderColor(unpack(mmconfig.configBackDropBorderColor))
	
	if IsAddOnLoaded("Tukui") and TukuiMinimap.shadow and not TukuiCF["datatext"].mmenu and not TukuiCF["datatext"].mmenu > 0 then
		TukuiDB.CreateShadow(f)
	end
end

-- the menu open button
local openmenubutton = CreateFrame("Frame", "OpenMenuButton", UIParent)
skinbutton(openmenubutton)
openmenubutton:SetWidth(mmconfig.buttonwidth)
openmenubutton:SetHeight(mmconfig.buttonheight)
openmenubutton:SetPoint("CENTER",0,0)
openmenubutton:EnableMouse(true)
openmenubutton:SetMovable(true)

-- (texture)
openmenubutton.texture = openmenubutton:CreateTexture(nil, "OVERLAY")
if mmconfig.buttonwidth > 13 then
openmenubutton.texture:SetPoint("CENTER", openmenubutton, "CENTER")
openmenubutton.texture:SetWidth(20)
openmenubutton.texture:SetHeight(20)
openmenubutton.texture:SetTexture("Interface\\addons\\mMenu\\button")
openmenubutton.texture:SetAlpha(1)
end
openmenubutton.texturemo = openmenubutton:CreateTexture(nil, "OVERLAY")
if mmconfig.buttonwidth > 13 then
openmenubutton.texturemo:SetPoint("CENTER", openmenubutton, "CENTER")
openmenubutton.texturemo:SetWidth(20)
openmenubutton.texturemo:SetHeight(20)
openmenubutton.texturemo:SetTexture("Interface\\addons\\mMenu\\button")
openmenubutton.texturemo:SetVertexColor(unpack(mmconfig.mouseoverm))
openmenubutton.texturemo:SetAlpha(0)
end
-- this frame around the buttons makes it easier for me to manage it and it looks better imo
local menu = CreateFrame("Frame", "menu", UIParent)
menu:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", 
								edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
								tileSize = 0, edgeSize = 1, 
								insets = { left = -1, right = -1, top = -1, bottom = -1}
})
menu:SetBackdropColor(0,0,0,1)
menu:SetBackdropBorderColor(.2,.2,.2,1)
if mmconfig.menudirection == true then
	menu:SetPoint("TOPRIGHT", OpenMenuButton, "BOTTOMRIGHT", 0, -3)
else
	menu:SetPoint("BOTTOMRIGHT", OpenMenuButton, "TOPRIGHT", 0, 3)
end
menu:SetFrameLevel(2)
menu:SetFrameStrata("HIGH")
if IsAddOnLoaded("Tukui") and TukuiMinimap.shadow then
	TukuiDB.CreateShadow(menu)
end
menu:Hide()

-- "close all" button
local close = CreateFrame("Frame", "close", UIParent)
skinbutton(close)
close:SetWidth(mmconfig.buttonwidth)
close:SetHeight(mmconfig.buttonheight)
close:SetPoint("RIGHT", openmenubutton, "LEFT",-3,0)
close:EnableMouse(true)
close:SetAlpha(.4)
if (mmconfig.hideclose) then close:Hide() end

local c = close:CreateFontString(nil, "LOW")
c:SetPoint("CENTER", 1, 0)
c:SetFont(mmconfig.font, mmconfig.fontheight)
c:SetText(mmconfig.textcolor.."C")
--mouseover
close:SetScript("OnEnter", function()
	UIFrameFadeIn(close, mmconfig.fadetime, 0.4, 1)
	c:SetText(mmconfig.textcolorclicked.."C")
	close:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
end)
close:SetScript("OnLeave", function()
	UIFrameFadeOut(close, mmconfig.fadetime, 1, 0.4)
	c:SetText(mmconfig.textcolor.."C")
	close:SetBackdropColor(unpack(mmconfig.configBackDropColor))
end)
	

-- "open all" button
local open = CreateFrame("Frame", "open", UIParent)
skinbutton(open)
open:SetWidth(mmconfig.buttonwidth)
open:SetHeight(mmconfig.buttonheight)
if not (mmconfig.hideclose) then 
	open:SetPoint("RIGHT", close, "LEFT",-3,0)
else
	open:SetPoint("RIGHT", openmenubutton, "LEFT",-3,0)
end
open:EnableMouse(true)
open:SetAlpha(.4)
if (mmconfig.hideopen) then open:Hide() end

local o = open:CreateFontString(nil, "LOW")
o:SetPoint("CENTER", 1, 0)
o:SetFont(mmconfig.font, mmconfig.fontheight)
o:SetText(mmconfig.textcolor.."O")
--(mouseover)
open:SetScript("OnEnter", function()
	UIFrameFadeIn(open, mmconfig.fadetime, 0.4, 1)
	o:SetText(mmconfig.textcolorclicked.."O")
	open:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
end)
open:SetScript("OnLeave", function()
	UIFrameFadeOut(open, mmconfig.fadetime, 1, 0.4)
	o:SetText(mmconfig.textcolor.."O")
	open:SetBackdropColor(unpack(mmconfig.configBackDropColor))
end)

--------------------------------------------------------------------------------------
local function login() --make sure it loads after login
mmenuaddons = 0 -- Lets go!
--------------------------------------------------------------------------------------
-- "Create Addon Button" function
--------------------------------------------------------------------------------------
function CreateAddonButton(f)
	f:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", 
								edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
								tileSize = 0, edgeSize = 1, 
								insets = { left = -1, right = -1, top = -1, bottom = -1}
	})
	f:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	f:SetBackdropBorderColor(unpack(mmconfig.configBackDropBorderColor))
	f:SetWidth(mmconfig.addonbuttonwidth)
	f:SetHeight(mmconfig.addonbuttonheight)
	f:EnableMouse(true)
	f:SetFrameStrata("HIGH")
	f:SetFrameLevel(3)
	
	if mmconfig.menudirection == true then
		if mmenuaddons == 0 then
			f:SetPoint("TOP", menu, "TOP", 0, -2)
		else
			f:SetPoint("TOP", menu, "TOP", 0, -((mmenuaddons * mmconfig.addonbuttonheight) + 2 + (mmenuaddons*2)))
		end
	else
		if mmenuaddons == 0 then
			f:SetPoint("BOTTOM", menu, "BOTTOM", 0, 2)
		else
			f:SetPoint("BOTTOM", menu, "BOTTOM", 0, ((mmenuaddons * mmconfig.addonbuttonheight) + 2 + (mmenuaddons*2)))
		end
	end
	
	if mmconfig.hideonclick == true then
		f:SetScript("OnMouseUp", function()
			if not IsShiftKeyDown() then
				menu:Hide()
			end
		end)
	end
	
	f.text = f:CreateFontString(nil, "LOW")
	f.text:SetFont(mmconfig.font, mmconfig.fontheight)
	f.text:SetWidth(mmconfig.addonbuttonwidth - 8)
	f.text:SetPoint("CENTER", f, "CENTER")
end
--------------------------------------------------------------------------------------
-- Addon Buttons
-- (Addon order)
--------------------------------------------------------------------------------------

-- Worldmap --------------------------
if (mmconfig.mList.WorldMap) then
	worldmapbutton = CreateFrame("Frame", "WorldMapButton", menu)
	CreateAddonButton(worldmapbutton)
	worldmapbutton.text:SetText(mmconfig.textcolor.."World Map|r")
	
	--open/close
	worldmapbutton:SetScript("OnMouseDown", function() ToggleFrame(WorldMapFrame) end)
	
	-- mouseover
	worldmapbutton:SetScript("OnEnter", function()
		worldmapbutton.text:SetText(mmconfig.textcolorclicked.."World Map|r")
		worldmapbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	worldmapbutton:SetScript("OnLeave", function()
		worldmapbutton.text:SetText(mmconfig.textcolor.."World Map|r")
		worldmapbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	
	mmenuaddons = mmenuaddons + 1
end

-- Bags --------------------------
if (mmconfig.mList.Bags) then
	bagsbutton = CreateFrame("Frame", "bagsButton", menu)
	CreateAddonButton(bagsbutton)
	bagsbutton.text:SetText(mmconfig.textcolor.."Bags|r")
	
	--open/close
	bagsbutton:SetScript("OnMouseDown", function() OpenAllBags() end)
	
	-- mouseover
	bagsbutton:SetScript("OnEnter", function()
		bagsbutton.text:SetText(mmconfig.textcolorclicked.."Bags|r")
		bagsbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	bagsbutton:SetScript("OnLeave", function()
		bagsbutton.text:SetText(mmconfig.textcolor.."Bags|r")
		bagsbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	
	mmenuaddons = mmenuaddons + 1
end

-- Raidmark Bar --------------------------- 
if IsAddOnLoaded("TukuiMarkBar") and (mmconfig.mList.Raidmarkbar) then 
     markbarbutton = CreateFrame("Frame", "MarkbarButton", menu) 
     CreateAddonButton(markbarbutton) 
     markbarbutton.text:SetText(mmconfig.textcolor.."Raidmarks|r") 
      
     --open/close 
     markbarbutton:SetScript("OnMouseDown", function() ToggleFrame(MarkBarBackground) end) 
      
     -- mouseover 
     markbarbutton:SetScript("OnEnter", function() 
          markbarbutton.text:SetText(mmconfig.textcolorclicked.."Raidmarks|r") 
          markbarbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop)) 
     end) 
     markbarbutton:SetScript("OnLeave", function() 
          markbarbutton.text:SetText(mmconfig.textcolor.."Raidmarks|r") 
          markbarbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor)) 
     end) 
           
     mmenuaddons = mmenuaddons + 1 
end

-- Grid/Grid2 --------------------------
if (IsAddOnLoaded("Grid") or IsAddOnLoaded("Grid2")) and (mmconfig.mList.Grid) then
	gridbutton = CreateFrame("Frame", "gridbuttonButton", menu)
	CreateAddonButton(gridbutton)
	gridbutton.text:SetText(mmconfig.textcolor.."Grid|r")
	
	--open/close
	gridbutton:SetScript("OnMouseDown", function() 
		if IsAddOnLoaded("Grid2") then
			if Grid2LayoutFrame:IsShown() then
				Grid2LayoutFrame:Hide()
			else
				Grid2LayoutFrame:Show()
			end
		end
		if IsAddOnLoaded("Grid") then
			if GridLayoutFrame:IsShown() then
				GridLayoutFrame:Hide()
			else
				GridLayoutFrame:Show()
			end
		end
	end)
	
	-- mouseover
	gridbutton:SetScript("OnEnter", function()
		gridbutton.text:SetText(mmconfig.textcolorclicked.."Grid|r")
		gridbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	gridbutton:SetScript("OnLeave", function()
		gridbutton.text:SetText(mmconfig.textcolor.."Grid|r")
		gridbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	
	mmenuaddons = mmenuaddons + 1
end

-- Healbot --------------------------
if IsAddOnLoaded("HealBot") and (mmconfig.mList.HealBot) then
	hbbutton = CreateFrame("Frame", "hbbuttonButton", menu)
	CreateAddonButton(hbbutton)
	hbbutton.text:SetText(mmconfig.textcolor.."HealBot|r")
	
	--open/close
	hbbutton:SetScript("OnMouseDown", function() 
		HB_Timer1=0.01
        if HealBot_Config.DisableHealBot==0 then
            HealBot_Options_DisableHealBot:SetChecked(1)
            HealBot_Options_ToggleHealBot(1)
        else
            HealBot_Options_DisableHealBot:SetChecked(0)
            HealBot_Options_ToggleHealBot(0)
        end
	end)
	
	-- mouseover
	hbbutton:SetScript("OnEnter", function()
		hbbutton.text:SetText(mmconfig.textcolorclicked.."HealBot|r")
		hbbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	hbbutton:SetScript("OnLeave", function()
		hbbutton.text:SetText(mmconfig.textcolor.."HealBot|r")
		hbbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	
	mmenuaddons = mmenuaddons + 1
end

-- Skada --------------------------
if IsAddOnLoaded("Skada") and (mmconfig.mList.Skada) then
	skadabutton = CreateFrame("Frame", "SkadaButton", menu)
	CreateAddonButton(skadabutton)
	skadabutton.text:SetText(mmconfig.textcolor.."Skada|r")
	
	--open/close
	skadabutton:SetScript("OnMouseDown", function() Skada:ToggleWindow() end)
	
	-- mouseover
	skadabutton:SetScript("OnEnter", function()
		skadabutton.text:SetText(mmconfig.textcolorclicked.."Skada|r")
		skadabutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	skadabutton:SetScript("OnLeave", function()
		skadabutton.text:SetText(mmconfig.textcolor.."Skada|r")
		skadabutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	
	disabled = true -- skada specific .. its more a test but better dont delete it
	mmenuaddons = mmenuaddons + 1
end

-- TinyDPS --------------------------
if IsAddOnLoaded("TinyDPS") and (mmconfig.mList.TinyDPS) then
	tdpsbutton = CreateFrame("Frame", "tdpsbutton", menu)
	CreateAddonButton(tdpsbutton)
	tdpsbutton.text:SetText(mmconfig.textcolor.."TinyDPS|r")
	
	--open/close
	tdpsbutton:SetScript("OnMouseDown", function() ToggleFrame(tdpsFrame) end)
	
	-- mouseover
	tdpsbutton:SetScript("OnEnter", function()
		tdpsbutton.text:SetText(mmconfig.textcolorclicked.."TinyDPS|r")
		tdpsbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	tdpsbutton:SetScript("OnLeave", function()
		tdpsbutton.text:SetText(mmconfig.textcolor.."TinyDPS|r")
		tdpsbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	
	mmenuaddons = mmenuaddons + 1
end

-- Numeration --------------------------
if IsAddOnLoaded("Numeration") and (mmconfig.mList.Numeration) then
	numdpsbutton = CreateFrame("Frame", "numdpsbutton", menu)
	CreateAddonButton(numdpsbutton)
	numdpsbutton.text:SetText(mmconfig.textcolor.."Numeration|r")
	
	--open/close + shift key = reset
	numdpsbutton:SetScript("OnMouseDown", function() 
		if not IsShiftKeyDown() then
			ToggleFrame(NumerationFrame)
		else
			NumerationFrame:ShowResetWindow() 
		end
	end)
	
	-- mouseover
	numdpsbutton:SetScript("OnEnter", function()
		numdpsbutton.text:SetText(mmconfig.textcolorclicked.."Numeration|r")
		numdpsbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	numdpsbutton:SetScript("OnLeave", function()
		numdpsbutton.text:SetText(mmconfig.textcolor.."Numeration|r")
		numdpsbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	
	mmenuaddons = mmenuaddons + 1
end

-- Recount --------------------------
if IsAddOnLoaded("Recount") and (mmconfig.mList.Recount) then
	recountbutton = CreateFrame("Frame", "RecountButton", menu)
	CreateAddonButton(recountbutton)
	recountbutton.text:SetText(mmconfig.textcolor.."Recount|r")
	
	--open/close
	recountbutton:SetScript("OnMouseDown", function() 
		if not IsShiftKeyDown() then
			if Recount.MainWindow:IsShown() then Recount.MainWindow:Hide() else Recount.MainWindow:Show();Recount:RefreshMainWindow() end 
		else
			Recount:ShowReset()
		end
	end)
	
	-- mouseover
	recountbutton:SetScript("OnEnter", function()
		recountbutton.text:SetText(mmconfig.textcolorclicked.."Recount|r")
		recountbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	recountbutton:SetScript("OnLeave", function()
		recountbutton.text:SetText(mmconfig.textcolor.."Recount|r")
		recountbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	
	--position
	mmenuaddons = mmenuaddons + 1
end

-- Omen --------------------------
if IsAddOnLoaded("Omen") and (mmconfig.mList.Omen) then
	omenbutton = CreateFrame("Frame", "omenbutton", menu)
	CreateAddonButton(omenbutton)
	omenbutton.text:SetText(mmconfig.textcolor.."Omen|r")
	
	-- mouseover
	omenbutton:SetScript("OnEnter", function()
		omenbutton.text:SetText(mmconfig.textcolorclicked.."Omen|r")
		omenbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	omenbutton:SetScript("OnLeave", function()
		omenbutton.text:SetText(mmconfig.textcolor.."Omen|r")
		omenbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	
	--open/close
	omenbutton:SetScript("OnMouseDown", function() Omen:Toggle() end)
	
	mmenuaddons = mmenuaddons + 1
end

-- Atlasloot --------------------------
if IsAddOnLoaded("AtlasLoot") and (mmconfig.mList.Atlas) then
	atlasbutton = CreateFrame("Frame", "AtlasLootButton", menu)
	CreateAddonButton(atlasbutton)
	atlasbutton.text:SetText(mmconfig.textcolor.."AtlasLoot|r")
	
	--open/close
	atlasbutton:SetScript("OnMouseDown", function() ToggleFrame(AtlasLootDefaultFrame) end)
	
	-- mouseover
	atlasbutton:SetScript("OnEnter", function()
		atlasbutton.text:SetText(mmconfig.textcolorclicked.."AtlasLoot|r")
		atlasbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	atlasbutton:SetScript("OnLeave", function()
		atlasbutton.text:SetText(mmconfig.textcolor.."AtlasLoot|r")
		atlasbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
		
	mmenuaddons = mmenuaddons + 1
end

-- Cascade --------------------------
if IsAddOnLoaded("Cascade") and (mmconfig.mList.Cascade) then
	cascadebutton = CreateFrame("Frame", "CascadeButton", menu)
	CreateAddonButton(cascadebutton)
	cascadebutton.text:SetText(mmconfig.textcolor.."Cascade|r")
	
	--open/close
	cascadebutton:SetScript("OnMouseDown", function() ToggleFrame(CascadeFrame) end)
	
	-- mouseover
	cascadebutton:SetScript("OnEnter", function()
		cascadebutton.text:SetText(mmconfig.textcolorclicked.."Cascade|r")
		cascadebutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	cascadebutton:SetScript("OnLeave", function()
		cascadebutton.text:SetText(mmconfig.textcolor.."Cascade|r")
		cascadebutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
		
	mmenuaddons = mmenuaddons + 1
end
-- Tukui Config --------------------------
if IsAddOnLoaded("Tukui_ConfigUI") and IsAddOnLoaded("Tukui") and (mmconfig.mList.TukuiConfig) then
	tukuiconfig = CreateFrame("Frame", "TukuiConfigButton", menu)
	CreateAddonButton(tukuiconfig)
	tukuiconfig.text:SetText(mmconfig.textcolor.."Tukui Config|r")
	
	--open/close
	tukuiconfig:SetScript("OnMouseDown", function() SlashCmdList["CONFIG"]() end)
	
	-- mouseover
	tukuiconfig:SetScript("OnEnter", function()
		tukuiconfig.text:SetText(mmconfig.textcolorclicked.."Tukui Config|r")
		tukuiconfig:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	tukuiconfig:SetScript("OnLeave", function()
		tukuiconfig.text:SetText(mmconfig.textcolor.."Tukui Config|r")
		tukuiconfig:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
		
	mmenuaddons = mmenuaddons + 1
end
-- Reload UI -------------------------- doesnt work yet
if mmconfig.mList.ReloadUI and 1 == 2 then
	reloaduibutton = CreateFrame("Frame", "ReloadUIButton", menu)
	CreateAddonButton(reloaduibutton)
	reloaduibutton.text:SetText(mmconfig.textcolor.."Reload UI|r")
	
	--open/close
	reloaduibutton:SetScript("OnMouseUp", function() ReloadUI() end)
	
	-- mouseover
	reloaduibutton:SetScript("OnEnter", function()
		reloaduibutton.text:SetText(mmconfig.textcolorclicked.."Reload UI|r")
		reloaduibutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	reloaduibutton:SetScript("OnLeave", function()
		reloaduibutton.text:SetText(mmconfig.textcolor.."Reload UI|r")
		reloaduibutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
		
	mmenuaddons = mmenuaddons + 1
end
--------------------------------------------------------------------------------------
-- Addon order ends here
--------------------------------------------------------------------------------------
-- Create a "No Addons" Button if there are no supported addons loaded + hide close & open button
menu:SetHeight((mmenuaddons * mmconfig.addonbuttonheight) + (mmenuaddons * 2) +2)
menu:SetWidth(mmconfig.addonbuttonwidth + 4)
if menu:GetHeight() < mmconfig.addonbuttonheight then
	local noaddons = CreateFrame("Frame", "noaddons", menu)
	CreateAddonButton(noaddons)
	noaddons.text:SetText("|cff9b9b9bNo Addons :<|r")
	
	close:Hide()
	open:Hide()
	menu:SetHeight(mmconfig.addonbuttonheight + 4)
end

-- WIM --------------------------
if IsAddOnLoaded("WIM") then
	if ( mmconfig.WIMSupport ) then
		-- W Button
		local wimbutton = CreateFrame("Frame", "wimbutton", openmenubutton)
		skinbutton(wimbutton)
		wimbutton:SetWidth(mmconfig.buttonwidth)
		wimbutton:SetHeight(mmconfig.buttonheight)
		wimbutton:SetPoint("LEFT", openmenubutton, "RIGHT", 3,0)
		wimbutton:SetAlpha(0.4)
		wimbutton:EnableMouse(true)
		
		local w = wimbutton:CreateFontString(nil, "LOW")
		w:SetAllPoints(wimbutton)
		w:SetFont(mmconfig.font, mmconfig.fontheight)
		w:SetText(mmconfig.textcolor.."W")
		
		-- WIM toggle function
		local hiddenWIM 
		function toggleWIM()
			if hiddenWIM then
				WIM.ShowAllWindows()
			else
				WIM.HideAllWindows()
			end
			hiddenWIM = not hiddenWIM 
		end
		
		-- Leftclick = toggle, rightclick = Menu
		wimbutton:SetScript("OnMouseUp", function(parent, btn)
			if(btn == "LeftButton") then
				toggleWIM()
				WIM.Menu:Hide();
			else
				WIM.Menu:ClearAllPoints();
				if(WIM.Menu:IsShown()) then
					WIM.Menu:Hide();
				else
					if mmconfig.menudirection == true then
						WIM.Menu:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", -10, 10);
					else
						WIM.Menu:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", -10, -10);
					end
					WIM.Menu:Show();
				end
			end
		end)

		-- mouseover "W" Button
		wimbutton:SetScript("OnEnter", function()
			UIFrameFadeOut(wimbutton, mmconfig.fadetime, 0.4, 1)
			w:SetText(mmconfig.textcolorclicked.."W")
			wimbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
		end)
		wimbutton:SetScript("OnLeave", function()
			UIFrameFadeOut(wimbutton, mmconfig.fadetime, 1, 0.4)
			w:SetText(mmconfig.textcolor.."W")
			wimbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
		end)
	end
end

--------------------------------------------------------------------------------------
-- function
--------------------------------------------------------------------------------------

-- open menu function
openmenubutton:SetScript("OnMouseDown", function()
	if not IsShiftKeyDown() then
		if menu:IsShown() then
			-- UIFrameFadeOut(menu, mmconfig.fadetime, 0, 1)
			menu:Hide()
			openmenubutton.texturemo:SetAlpha(0)
			openmenubutton.texture:SetAlpha(1)
			openmenubutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
		else
			menu:Show()	
			openmenubutton.texturemo:SetAlpha(1)
			openmenubutton.texture:SetAlpha(0)
			openmenubutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))		
			UIFrameFadeIn(menu, mmconfig.fadetime, 0, 1)
		end
	else
	openmenubutton:ClearAllPoints()
	openmenubutton:StartMoving()
	end
end)

openmenubutton:SetScript("OnMouseUp", function()
	openmenubutton:StopMovingOrSizing()
end)

-- open all button
open:SetScript("OnMouseDown", function() 
	open:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
end)
open:SetScript("OnMouseUp", function()
	if 										(mmconfig.openall.WorldMap) then	WorldMapFrame:Show() end
	if 										(mmconfig.openall.Bags) then		OpenAllBags() end
	if IsAddOnLoaded("Grid") then if 		(mmconfig.openall.Grid) then 		GridLayoutFrame:Show() end end -- Grid
	if IsAddOnLoaded("Grid2") then if 		(mmconfig.openall.Grid) then 		Grid2LayoutFrame:Show() end end -- Grid2
	if IsAddOnLoaded("HealBot") then if 	(mmconfig.openall.HealBot) then 
												if HealBot_Options_DisableHealBot:GetChecked() then
													HealBot_Options_DisableHealBot:SetChecked(0)
													HealBot_Options_ToggleHealBot(0) 
												end end end
	if IsAddOnLoaded("Numeration") then if	(mmconfig.openall.Numeration) then	NumerationFrame:Show() end end
	if IsAddOnLoaded("Skada") then if 		(mmconfig.openall.Skada) then 		Skada:SetActive(disabled) end end
	if IsAddOnLoaded("Omen") then if 		(mmconfig.openall.Omen) then		Omen:Toggle(true) end end
	if IsAddOnLoaded("AtlasLoot") then if 	(mmconfig.openall.Atlas) then 		AtlasLootDefaultFrame:Show() end end
	if IsAddOnLoaded("Recount") then if 	(mmconfig.openall.Recount) then 	Recount.MainWindow:Show();Recount:RefreshMainWindow() end end
	if IsAddOnLoaded("TinyDPS") then if 	(mmconfig.openall.TinyDPS) then 	tdpsFrame:Show() end end
	if IsAddOnLoaded("Cascade") then if		(mmconfig.openall.Cascade) then		CascadeFrame:Show() end end
	if IsAddOnLoaded("Tukui_ConfigUI") then if (mmconfig.openall.TukuiConfig) then 
												if not TukuiConfigUI then SlashCmdList["CONFIG"]()
												else TukuiConfigUI:Show()
												end end end
	if IsAddOnLoaded("TukuiMarkBar") then if (mmconfig.openall.Raidmarkbar) then MarkBarBackground:Show() end end
end)

-- close all button
close:SetScript("OnMouseDown", function() 
	close:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
end)
close:SetScript("OnMouseUp", function()
	if 										(mmconfig.closeall.WorldMap) then	WorldMapFrame:Hide() end
	if 										(mmconfig.closeall.Bags) then		CloseAllBags() end
	if IsAddOnLoaded("Grid") then if 		(mmconfig.closeall.Grid) then 		GridLayoutFrame:Hide() end end -- Grid
	if IsAddOnLoaded("Grid2") then if 		(mmconfig.closeall.Grid) then 		Grid2LayoutFrame:Hide() end end -- Grid2
	if IsAddOnLoaded("HealBot") then if 	(mmconfig.closeall.HealBot) then 
												if not HealBot_Options_DisableHealBot:GetChecked() then
													HealBot_Options_DisableHealBot:SetChecked(1)
													HealBot_Options_ToggleHealBot(1) 
												end end end
	if IsAddOnLoaded("Numeration") then if	(mmconfig.closeall.Numeration) then	NumerationFrame:Hide() end end
	if IsAddOnLoaded("Skada") then if 		(mmconfig.closeall.Skada) then 		Skada:SetActive(enable) end end
	if IsAddOnLoaded("Omen") then if 		(mmconfig.closeall.Omen) then 		Omen:Toggle(false) end end
	if IsAddOnLoaded("AtlasLoot") then if 	(mmconfig.closeall.Atlas) then 		AtlasLootDefaultFrame:Hide() end end
	if IsAddOnLoaded("Recount") then if 	(mmconfig.closeall.Recount) then if Recount.MainWindow:IsShown() then Recount.MainWindow:Hide() end end end
	if IsAddOnLoaded("TinyDPS") then if 	(mmconfig.closeall.TinyDPS) then 	tdpsFrame:Hide() end end
	if IsAddOnLoaded("Cascade") then if		(mmconfig.closeall.Cascade) then	CascadeFrame:Hide() end end
	if IsAddOnLoaded("Tukui_ConfigUI") then if (mmconfig.closeall.TukuiConfig) then
												if not TukuiConfigUI then return
												else TukuiConfigUI:Hide()
												end end end
	if IsAddOnLoaded("TukuiMarkBar") then if (mmconfig.closeall.Raidmarkbar) then MarkBarBackground:Hide() end end
end)

AddOn:UnregisterEvent("PLAYER_ENTERING_WORLD") -- UnregisterEvent so it only loads on first start
end -- function "login" ends here

-- mouseover the "m" button
openmenubutton:SetScript("OnEnter", function()
	if not menu:IsShown() then
		UIFrameFadeIn(openmenubutton.texturemo, mmconfig.fadetime, 0, 1)
		UIFrameFadeOut(openmenubutton.texture, mmconfig.fadetime, 1, 0)
	end
end)
openmenubutton:SetScript("OnLeave", function()
	if not menu:IsShown() then
		UIFrameFadeIn(openmenubutton.texture, mmconfig.fadetime, 0, 1)
		UIFrameFadeOut(openmenubutton.texturemo, mmconfig.fadetime, 1, 0)
	end
end)

-- Slash command
SLASH_MMENU1 = "/mmenu"
SLASH_MMENU2 = "/mm"
SlashCmdList["MMENU"] = function(msg)
	if msg == "reset" then
		openmenubutton:ClearAllPoints()
		openmenubutton:SetPoint("CENTER", UIParent, "CENTER", 0,0)
		print(mmconfig.textcolorclicked.."mMenu|r "..mmconfig.textcolor.."- Position reset!")
	else
		print(mmconfig.textcolorclicked.."mMenu|r "..mmconfig.textcolor.."- Help:") 
		print(mmconfig.textcolorclicked.."-|r "..mmconfig.textcolor.."Move while holding Shift.")
		print(mmconfig.textcolorclicked.."-|r "..mmconfig.textcolor.."Reset position with|r |cff9b9b9b'/mm reset'|r")
	end
end

AddOn:RegisterEvent("PLAYER_ENTERING_WORLD")
AddOn["PLAYER_ENTERING_WORLD"] = login

-- Tukui Datatext
if TukuiCF["datatext"].mmenu and TukuiCF["datatext"].mmenu > 0 and IsAddOnLoaded("Tukui") and mmconfig.tukuisupport then
	menu:ClearAllPoints()
	if IsAddOnLoaded("Duffed") then
		menu:SetPoint("BOTTOMRIGHT", TukuiActionBarBackground, "TOPRIGHT", 0, 4)
	else
		menu:SetPoint("BOTTOM", mmdatatextbutton, "TOP", 0, 4)
	end
	openmenubutton:SetPoint("CENTER", mmdatatextbutton)
	openmenubutton:SetHeight(0.1)
	openmenubutton:SetWidth(0.1)
	openmenubutton:SetFrameStrata("BACKGROUND")
	openmenubutton:SetFrameLevel(0)
	openmenubutton:SetMovable(false)
end