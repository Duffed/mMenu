local AddOn = CreateFrame("Frame")
local OnEvent = function(self, event, ...) self[event](self, event, ...) end
AddOn:SetScript("OnEvent", OnEvent)


-- this frame around the buttons makes it easier for me to manage it and it looks better imo
local gamemenu = CreateFrame("Frame", "gamemenu", menu)
gamemenu:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", 
								edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
								tileSize = 0, edgeSize = 1, 
								insets = { left = -1, right = -1, top = -1, bottom = -1}
})
gamemenu:SetBackdropColor(0,0,0,1)
gamemenu:SetBackdropBorderColor(.2,.2,.2,1)
if mmconfig.menudirection == true then
	gamemenu:SetPoint("TOP", menu, "BOTTOM", 0, -4)
else
	gamemenu:SetPoint("BOTTOM", menu, "TOP", 0, 4)
end
gamemenu:SetFrameStrata("BACKGROUND")
--------------------------------------------------------------------------------------
local function login() --make sure it loads after login
local mmenugames = 0 -- Lets go!

--------------------------------------------------------------------------------------
-- Setpoint function
--------------------------------------------------------------------------------------
local function gamesetpoint(f)
	if mmconfig.menudirection == true then
		if mmenugames == 0 then
			f:SetPoint("TOP", gamemenu, "TOP", 0, -2)
		else
			f:SetPoint("TOP", gamemenu, "TOP", 0, -((mmenugames * mmconfig.addonbuttonheight) + 2 + (mmenugames*3)))
		end
	else
		if mmenugames == 0 then
			f:SetPoint("BOTTOM", gamemenu, "BOTTOM", 0, 2)
		else
			f:SetPoint("BOTTOM", gamemenu, "BOTTOM", 0, ((mmenugames * mmconfig.addonbuttonheight) + 2 + (mmenugames*3)))
		end
	end
end
--------------------------------------------------------------------------------------
--- Game Buttons
--------------------------------------------------------------------------------------

-- Tetris --------------------------
if IsAddOnLoaded("Tetris") then
	tetrisbutton = CreateFrame("Frame", "tetrisButton", gamemenu)
	CreateAddonButton(tetrisbutton)
	tetrisbutton.text:SetText(mmconfig.textcolor.."Tetris|r")
	
	--position
	gamesetpoint(tetrisbutton)
	
	--open/close
	tetrisbutton:SetScript("OnMouseDown", function() 
		if not GameTetrisFrame:IsShown() then
			SlashCmdList["TETRIS"]()
		else
			ToggleFrame(GameTetrisFrame)
		end
	end)
	
	-- mouseover
	tetrisbutton:SetScript("OnEnter", function()
		tetrisbutton.text:SetText(mmconfig.textcolorclicked.."Tetris|r")
		tetrisbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	tetrisbutton:SetScript("OnLeave", function()
		tetrisbutton.text:SetText(mmconfig.textcolor.."Tetris|r")
		tetrisbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	mmenugames = mmenugames + 1
end


-- Bejeweled --------------------------
if IsAddOnLoaded("Bejeweled") then
	bjewbutton = CreateFrame("Frame", "bjewButton", gamemenu)
	CreateAddonButton(bjewbutton)
	bjewbutton.text:SetText(mmconfig.textcolor.."Bejeweled|r")
	
	--position
	gamesetpoint(bjewbutton)
	
	--open/close
	bjewbutton:SetScript("OnMouseDown", function() 
		if not BejeweledWindow:IsShown() then
			BejeweledWindow:Show()
		else
			BejeweledWindow:Hide()
		end
	end)
	
	-- mouseover
	bjewbutton:SetScript("OnEnter", function()
		bjewbutton.text:SetText(mmconfig.textcolorclicked.."Bejeweled|r")
		bjewbutton:SetBackdropColor(unpack(mmconfig.mouseoverBackdrop))
	end)
	bjewbutton:SetScript("OnLeave", function()
		bjewbutton.text:SetText(mmconfig.textcolor.."Bejeweled|r")
		bjewbutton:SetBackdropColor(unpack(mmconfig.configBackDropColor))
	end)
	mmenugames = mmenugames + 1
end

--[[ testbutton
	test = CreateFrame("Frame", "test", gamemenu)
	CreateAddonButton(test)
	test.text:SetText(mmconfig.textcolor.."test|r")
	
	--position
	gamesetpoint(test)
	
	mmenugames = mmenugames + 1
]]


-- hide gamemenu if there are no ..
gamemenu:SetHeight((mmenugames * mmconfig.addonbuttonheight) + (mmenugames * 3) +1)
gamemenu:SetWidth(mmconfig.addonbuttonwidth + 4)

if gamemenu:GetHeight() < mmconfig.addonbuttonheight then
gamemenu:Hide() end

AddOn:UnregisterEvent("PLAYER_ENTERING_WORLD") -- UnregisterEvent so it just loads on first start
end -- function login end
--------------------------------------------------------------------------------------
-- function
--------------------------------------------------------------------------------------

AddOn:RegisterEvent("PLAYER_ENTERING_WORLD")
AddOn["PLAYER_ENTERING_WORLD"] = login
