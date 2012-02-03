---------------------------------------------
-- variable.lua
---------------------------------------------
local FCV, CFG, LOC = unpack(select(2, ...))

CFG.territory_colors = {
	["friendly"] = {0.1, 1.0, 0.1},
	["sanctuary"] = {0.41, 0.8, 0.94},
	["arena"] = {1.0, 0.1, 0.1},
	["hostile"] = {1.0, 0.1, 0.1},
	["combat"] = {1.0, 0.1, 0.1},
	["contested"] = {1.0, 0.7, 0.0},
	["none"] = {0.1, 1.0, 0.1},
}