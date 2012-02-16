---------------------------------------------
-- minimap.lua
---------------------------------------------
local FCV, CFG = unpack(select(2, ...))

local minimap_size = 144
local font_size = 13
local anchor_point = 'TOPRIGHT' 
local x = -25
local y = -40

Minimap : SetScale(1)
Minimap : SetPlayerTexture (CFG.media.minimaparrow)
Minimap : SetPlayerTextureHeight(36)
Minimap : SetPlayerTextureWidth(36)
FCV.backdrop = {
	bgFile = CFG.media.bgfile,
	--edgeFile = CFG.media.blank,
	title = false,
	tileSize = 0,
	edgeSize = 0,
	insets ={
		left = 0,
		right = 0,
		top = 0,
		bottom = 0
	}

}
---- Config end
-------------------------------------------------
local function echo(str) print('|cfffef00fSumakMinimap |cff82e2eb' .. (str or '')) end

Minimap : ClearAllPoints()
Minimap : SetPoint (anchor_point, UIParent, x, y)
GameTimeFrame : Hide()

-------------------------------------------------
---- подложка под минимапу
local minimapframe = FCV.frame ("minimapframe", Minimap, 1, "BACKGROUND", false, false, false)
	minimapframe : SetPoint ("TOPLEFT", -4, 4)
	minimapframe : SetPoint ("BOTTOMRIGHT", 4, -4)

	----
minimapframe : SetScript ('OnEvent', function (self, event)
	echo ('Версия '.. GetAddOnMetadata ('SumakMinimap', 'Version') .. ' by Sumak ')
end)
-------------------------------------------------
---- The frame for zone
local m_zone = FCV.frame ("m_zone", minimapframe, 1, "BACKGROUND", false, false, false)
	m_zone : SetSize (minimap_size+8, 20)
	m_zone : SetPoint ("TOPLEFT", 0, 26)

local m_zone_text = FCV.setfontstring (m_zone, 5, nil, nil, "CENTER")
	m_zone_text : SetFont (CFG.media.uffont, font_size)
	m_zone_text : SetPoint ("Center", m_zone, 0, 0)
	m_zone_text : SetJustifyH ("CENTER")
	m_zone_text : SetJustifyV ("CENTER")

-------------------------------------------------
---- The frame for coordinates
local m_coord = FCV.frame ("m_coord", minimapframe, 1, "LOW", true, true, true)
	m_coord : SetSize (50, 24)
	m_coord : SetPoint ("BOTTOM", minimap_size/4, 1)

local m_coord_text = FCV.setfontstring (m_coord, font_size, nil, nil, "CENTER")
	m_coord_text : SetPoint ("CENTER", 0, 0)
	m_coord_text : SetText ("00, 00")

-- сами координаты
local ela = 0
local coord_Update = function (self, t)
	ela = ela - t
	if ela > 0 then return end
	local x, y = GetPlayerMapPosition ("player")
	local xt, yt
	x = math.floor (100 * x)
	y = math.floor (100 * y)
	if x == 0 and y == 0 then
		m_coord_text : SetText("X _ X")
	else
		if x < 10 then
			xt = "0"..x
		else
			xt = x
		end
		if y < 10 then
			yt = "0"..y
		else
			yt = y
		end
		m_coord_text : SetText(xt..","..yt)
	end
	ela = .2
end

m_coord : SetScript("OnUpdate", coord_Update)
-------------------------------------------------
	
-------------------------------------------------
---- The frame for mail
local m_mail = FCV.frame ("m_mail", minimapframe, 3, "LOW", true, true, true)
	m_mail : SetSize (24, 24)
	m_mail : SetPoint ("TOP", 0, -5)
	MiniMapMailFrame : ClearAllPoints()
	MiniMapMailBorder : Hide()
	MiniMapMailFrame : SetParent(m_mail)
	MiniMapMailFrame : SetPoint('CENTER', m_mail, 'CENTER', 1, -2)
	MiniMapMailIcon : SetTexture (CFG.media.mailicon)
-------------------------------------------------
	
-------------------------------------------------
---- The frame for LFG
local m_LFG = FCV.frame ("m_LFG", minimapframe, 3, "LOW", true, true, true)
	m_LFG : SetSize (24, 24)
	m_LFG : SetPoint ("TOPRIGHT", -5, -5)

	-------------------------------------------------
---- Reposition lfg icon at bottom-left
local function UpdateLFG ()
MiniMapLFGFrame:ClearAllPoints()
MiniMapLFGFrame:SetPoint("CENTER", m_LFG, "CENTER", 0, 0)
MiniMapLFGFrame : SetParent (m_LFG)
MiniMapLFGFrame:SetHighlightTexture(nil)
MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc ("MiniMapLFG_UpdateIsShown", UpdateLFG)

-------------------------------------------------
---- The frame for BG
local m_BG = FCV.frame ("m_BG", minimapframe, 3, "LOW", true, true, true)
	m_BG : SetSize (24, 24)
	m_BG : SetPoint ("TOPRIGHT", -5, -35)
	MiniMapBattlefieldFrame: ClearAllPoints()
	MiniMapBattlefieldFrame : SetParent (m_BG)
	MiniMapBattlefieldFrame : SetPoint ("CENTER", m_BG, "CENTER", 1, -2)

	-------------------------------------------------
---- Tracking icon frame
local m_tracking = FCV.frame ("m_tracking", minimapframe, 1, "LOW", true, true, true)
	m_tracking : SetSize (24, 24)
	m_tracking : SetPoint ("TOPLEFT", 5, -5)

----tracking icon location
	MiniMapTracking : ClearAllPoints ()
	MiniMapTracking : SetParent (m_tracking)
	MiniMapTracking : SetScale (1)
	MiniMapTracking : SetPoint ('CENTER', m_tracking, 0, 0)
-------------------------------------------------

-------------------------------------------------
---- левая панель для минимапы
local minimap_ID = FCV.frame ("minimap_ID", minimapframe, 5, "LOW", true, true, true)
minimap_ID : SetSize (40, 40)
minimap_ID : ClearAllPoints ()
minimap_ID : SetPoint ("BOTTOMRIGHT", minimapframe, "TOPLEFT", -4, -40)
MiniMapInstanceDifficulty : ClearAllPoints ()
MiniMapInstanceDifficulty : SetParent(minimap_ID)
MiniMapInstanceDifficulty : SetPoint("CENTER", minimap_ID, "CENTER", 0, -5)

-------------------------------------------------
---- Zone show
local zone_show_enable = true
local territory_colors = CFG.territory_colors
local GetZonePVPInfo = GetZonePVPInfo
local GetMinimapZoneText = GetMinimapZoneText
	
local zone_Update = function()
	local z_text  = GetMinimapZoneText ()
	m_zone_text : SetText (z_text)
	local pvp = GetZonePVPInfo() or "none"
	local r, g, b = unpack (CFG.territory_colors[pvp])
	m_zone_text : SetTextColor (r, g, b)
end

m_zone : SetScript ("OnEvent", zone_Update) 
---- zone frame //
-------------------------------------------------

Minimap : SetScale(1)
Minimap : SetSize (minimap_size, minimap_size)
Minimap : SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')
Minimap : SetFrameStrata("BACKGROUND")
Minimap : SetFrameLevel(3)
------------------------------------------	
-- Масшбирование минимапы 
-- при MouseWheel
------------------------------------------
Minimap : EnableMouseWheel (true)
Minimap : SetScript ("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn : Click()
	elseif d < 0 then
		_G.MinimapZoomOut : Click()
	end
end)

------------------------------------------
---- Move it!
Minimap : SetMovable (true)
Minimap : EnableMouse (true)
Minimap : RegisterForDrag ("LeftButton")
Minimap : SetScript ("OnDragStart",
	function (self) 
		if IsAltKeyDown () then self:StartMoving () end end)
Minimap : SetScript ("OnDragStop", 
	function (self) self : StopMovingOrSizing () end)
Minimap : SetUserPlaced (true)
SlashCmdList ["RESETMINIMAP"] = function () 
    Minimap : SetUserPlaced (false)
    ReloadUI ()
end

------------------------------------------
-- destroy function
FCV.kill = function(self, donthide, point)
	if not self then return end
	if self.UnregisterAllEvents then self:UnregisterAllEvents() end
	if self.SetPoint and not(point) then self.SetPoint = FCV.null end
	if self.Show then self.Show = FCV.null end
	if not donthide then self:Hide() end
	if self.Hide then self.Hide = FCV.null end
end
------------------------------------------

------------------------------------------
-- Time
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end


local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
	clockFrame : Hide () ;	-- kill clock frame
	clockTime : SetFont (CFG.media.uffont, font_size)
	TimeManagerClockButton : SetPoint ("CENTER", minimapframe, "BOTTOM", -minimap_size/4, 12)
	TimeManagerClockButton : SetScript ("OnMouseDown", function(_,click)
		if click == "RightButton" then
		if not CalendarFrame then
			LoadAddOn ("Blizzard_Calendar")
		end
			CalendarFrame : Show ()
		end
	end)
-- Time	
------------------------------------------

 
------------------------------------------	
-- Right click menu
------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {text = CHARACTER_BUTTON,
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = SPELLBOOK_ABILITIES_BUTTON,
    func = function() ToggleFrame(SpellBookFrame) end},
    {text = TALENTS_BUTTON,
    func = function() ToggleTalentFrame() end},
    {text = ACHIEVEMENT_BUTTON,
    func = function() ToggleAchievementFrame() end},
    {text = QUESTLOG_BUTTON,
    func = function() ToggleFrame(QuestLogFrame) end},
    {text = SOCIAL_BUTTON,
    func = function() ToggleFriendsFrame(1) end},
	{text = PLAYER_V_PLAYER,
	func = function() ToggleFrame(PVPFrame) end},
    {text = LFG_TITLE,
    func = function() ToggleFrame(LFDParentFrame) end},
    {text = L_LFRAID,
    func = function() ToggleFrame(LFRParentFrame) end},
    {text = HELP_BUTTON,
    func = function() ToggleHelpFrame() end},
    {text = "Календарь", 
    func = function()
    if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
        Calendar_Toggle()
    end},
}

local addonmenu = {
	{text = "AtlasLoot",
    func = function() if IsAddOnLoaded("AtlasLoot") then AtlasLootDefaultFrame:Show() end end},
	{text = "Skada",
    func = function() if IsAddOnLoaded("Skada") then Skada:ToggleWindow() end end},
	{text = "WIM",
    func = function() if IsAddOnLoaded("WIM") then WIM.ShowAllWindows() end end},
	{text = "Omen",
    func = function() if IsAddOnLoaded("Omen") then Omen:Toggle() end end},
	{text = "Recount",
    func = function() if IsAddOnLoaded("Recount") then Recount.MainWindow:Show() end end},
}

Minimap : SetScript("OnMouseUp", function(self, button)
	if button == "RightButton" and not InCombatLockdown() then
		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	else
		Minimap_OnClick(self)
	end
end)
 
 ------------------------------------------
-- Kill ugly things.
Kill(WatchFrame)		--список задач
--Kill(GameTimeFrame)
Kill(MinimapBorderTop) -- hide minimap border
Kill(MinimapBorder)	   -- hide minimap border
Kill(MinimapNorthTag)
Kill(MinimapZoneTextButton)
Kill(MinimapZoomOut)	-- hide zoom button
Kill(MinimapZoomIn)	-- hide zoom button
Kill(MiniMapVoiceChatFrame)	-- Hide Voice Chat Frame
Kill(MiniMapWorldMapButton)
Kill(MiniMapMailBorder)	-- hide mail border
Kill(MiniMapBattlefieldBorder)
Kill(MiniMapTrackingBackground) -- бекграунд на трекере
Kill(MiniMapTrackingButtonBorder) -- бордер на трекере
--GameTimeFrame:Hide()
Kill(GameTimeFrame)
--FCV.kill (TimeManagerClockButton)
---- хайд минимап трек икон
--MiniMapTracking:Hide()

 --/framestack - команда отображения фреймов!!!!

 
SLASH_RESETMINIMAP1 = "/rmmp"
SLASH_RESETMINIMAP1 = "/resetmmp"

m_zone:RegisterEvent("PLAYER_ENTERING_WORLD")
m_zone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
m_zone:RegisterEvent("ZONE_CHANGED")
m_zone:RegisterEvent("ZONE_CHANGED_INDOORS")

minimapframe : RegisterEvent('ADDON_LOADED')