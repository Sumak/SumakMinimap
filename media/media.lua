---------------------------------------------
---- media.lua
---------------------------------------------
local FCV, CFG, LOC = unpack(select(2, ...))

CFG["media"] = {
	---- fonts
	["fontsize"] = 12, 														-- Size of font 
	["font"] = [=[Interface\AddOns\SumakMinimap\media\fonts\ARIALN.TTF]=], -- основной шрифт
	["uffont"] = [[Interface\AddOns\SumakMinimap\media\fonts\uf_font.ttf]], -- general font of unitframes
	["dmgfont"] = [[Interface\AddOns\SumakMinimap\media\fonts\combat_font.ttf]], -- general font of dmg / sct
	
	---- textures
	["normTex"] = [[Interface\AddOns\SumakMinimap\media\img\normTex]], -- texture used for tukui healthbar/powerbar/etc
	["glowTex"] = [[Interface\AddOns\SumakMinimap\media\img\glowTex]], -- the glow text around some frame.
	["bubbleTex"] = [[Interface\AddOns\SumakMinimap\media\img\bubbleTex]], -- unitframes combo points
	["blank"] = [[Interface\AddOns\SumakMinimap\media\img\blank]], -- the main texture for all borders/panels
--  ["blank"] = [[Interface\\Buttons\\WHITE8x8]],
	["bordercolor"] = { .3,.3,.3,1 }, -- border color of tukui panels
	["altbordercolor"] = { .4,.4,.4,1 }, -- alternative border color, mainly for unitframes text panels.
	["backdropcolor"] = { .1,.1,.1,1 }, -- background color of tukui panels
	["buttonhover"] = [[Interface\AddOns\Tukui\media\img\button_hover]],
	--["bgfile"] =  [[Interface\ChatFrame\ChatFrameBackground]],
	["bgfile"] =[[Interface\ChatFrame\ChatFrameBackground]],
    ["texture"] = [[Interface\\Addons\\SumakMinimap\\media\\img\\statusbar.tga]],
	
	---- sound
	["whisper"] = [[Interface\AddOns\SumakMinimap\media\sounds\whisper.mp3]],
	["warning"] = [[Interface\AddOns\SumakMinimap\media\sounds\warning.mp3]],
	
	["minimaparrow"] = [[Interface\Addons\SumakMinimap\media\img\MinimapArrow.blp]],
	["mailicon"] = [[Interface\AddOns\SumakMinimap\media\img\mail]],
}
