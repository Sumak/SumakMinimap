-------------------------------------------------
---- init.lua
-- initiation of SumakMinimap
-------------------------------------------------
--[[

Это долно быть в каждом аддоне в самом начале:	
		local FCV, CFG, LOC = unpack(select(2, ...))

Так другие аддоны смогут использовать SumakUI engine
		local FCV, CFG, LOC = unpack(SumakUI)

--- Для того, чтобы другой аддон мог использовать 
---- engine SumakUI нужно импортировать данные

]]
----------------------------------------------------------------
-- Initiation engine
----------------------------------------------------------------

-- including system
local addon, engine = ...
engine[1] = { } -- FCV, functions, constants, variables
engine[2] = { } -- CFG, config
engine[3] = { }-- LOC, localization

SumakUI = engine -- Allow other addons to use Engine

local FCV, CFG, LOC = unpack(select(2, ...))

FCV.dummy = function() return end
FCV.myname = select(1, UnitName("player"))
FCV.myclass = select(2, UnitClass("player"))
FCV.myrace = select(2, UnitRace("player"))
FCV.myfaction = UnitFactionGroup("player")
FCV.client = GetLocale() 
FCV.resolution = GetCVar("gxResolution")
FCV.screenheight = tonumber(string.match(FCV.resolution, "%d+x(%d+)"))
FCV.screenwidth = tonumber(string.match(FCV.resolution, "(%d+)x+%d"))
FCV.version = GetAddOnMetadata("SumakMinimap", "Version")
FCV.versionnumber = tonumber(FCV.version)
FCV.incombat = UnitAffectingCombat("player")
FCV.patch, FCV.buildtext, FCV.releasedate, FCV.toc = GetBuildInfo()
FCV.build = tonumber(FCV.buildtext)
FCV.level = UnitLevel("player")
FCV.myrealm = GetRealmName()


-- Kill function.
dummy = function() return end
function Kill(object)
	object.Show = dummy
	object:SetAlpha(0)
	object:Hide()
end
