------------------------------------------------------------------------
--	frames.lua
------------------------------------------------------------------------
local FCV, CFG = unpack(select(2, ...))

-- Style Frame
FCV.style = function (myframe,nobg,offset)
	
	if nobg ~= true then
		if not myframe.bg then
			local bg = myframe : CreateFrame(nil,"BORDER")
			bg:SetPoint("TOPLEFT",offset+1,-offset-1)
			bg:SetPoint("BOTTOMRIGHT",-offset-1,offset+1)
			myframe.bg = bg
		end
	end
end

FCV.setbackdrop = function (myframe)
		myframe : SetBackdrop (FCV.backdrop)
		myframe : SetBackdropColor (0, 0, 0, 1)
		myframe : SetBackdropBorderColor (.6, .6, .6, 1)
end


local shadows = {
	bgFile = CFG.media.bgfile,
	edgeFile = CFG.media.glowTex,
	title = false,
	edgeSize = 2,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

FCV.setshadow = function (myframe)
	if myframe.shadow then return end
	local shadow = CreateFrame ("Frame", nil, myframe)
	shadow : SetFrameLevel (1)
	shadow : SetFrameStrata(myframe:GetFrameStrata())
	shadow : SetPoint ("TOPLEFT", -3, 3)
	shadow : SetPoint ("BOTTOMRIGHT", 3, -3)
	shadow : SetBackdrop (shadows)
	shadow : SetBackdropColor (0, 0, 0, 1)
	shadow : SetBackdropBorderColor (0, 0, 0, 1)
	myframe.shadow = shadow
end	

---- создание фреймов
FCV.frame = function (f_name, parent, level, strata, nobg, noshadow, border, offset, alpha)
	local myframe = CreateFrame ("Frame", f_name, parent)
-- если не указан уровень фрейма
	if level ~=true then
		myframe : SetFrameLevel(1)
		myframe : SetFrameStrata (strata)
	end
--если с бекдропом (заливка)
	if nobg ~= true then FCV.setbackdrop (myframe) end
	if noshadow ~= true then FCV.setshadow (myframe) end
	----
	return myframe
end

-- Create String <STANDART TYPE>
FCV.setfontstring = function (parent, size, isoffset, layer, fy, fz, ht)
	local f_string = parent : CreateFontString(nil,layer or "OVERLAY")
	f_string : SetFont(CFG.media.uffont, size or 13,ht)
	if not isoffset then
		f_string : SetShadowOffset(1,-1)
	end
	f_string : SetJustifyH(fy or "CENTER")
	f_string : SetJustifyV(fz or "MIDDLE")
	f_string : SetHeight(size or 13)
	return f_string
end