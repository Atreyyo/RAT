--########### Raid Ability Tracker 
--########### By Atreyyo @ VanillaGaming.org
--##########################################

Rat = CreateFrame("Button", "Rat", UIParent); -- Create first frame
Rat.Mainframe = CreateFrame("Frame","RMF",UIParent) -- Create Mainframe
Rat.Options = CreateFrame("Frame","ROF",UIParent) -- Create Optionsframe
Rat.Minimap = CreateFrame("Frame",nil,Minimap) -- Minimap Frame
Rat.Version = CreateFrame("Frame","RVF",UIParent) -- Create Versionframe
Rat_Version = GetAddOnMetadata("Rat", "Version")

-- Variables

RAT_CP_OBJ=nil
RAT_CP_TYPE=nil
Rat_unit = UnitName("player") 
-- Tables

RatTbl = {}
RatVersionTbl = {}
VersionFTbl = {}
getThrottle = {}
sendThrottle = {}
RatFrames = {}
Rat_Settings = Rat_Settings or {}

cdtbl = { 
	["Innervate"] = "Interface\\Icons\\Spell_Nature_Lightning",
	["Challenging Roar"] = "Interface\\Icons\\Ability_Druid_ChallangingRoar",
	["Challenging Shout"] = "Interface\\Icons\\Ability_BullRush",
	["Rebirth"] = "Interface\\Icons\\Spell_Nature_Reincarnation",
	["Shield Wall"] = "Interface\\Icons\\Ability_Warrior_ShieldWall",
	["Berserker Rage"] = "Interface\\Icons\\Spell_Nature_AncestralGuardian",
	["Pummel"] = "Interface\\Icons\\INV_Gauntlets_04",
	["Disarm"] = "Interface\\Icons\\Ability_Warrior_Disarm",
	["Major Soulstone"] = "Interface\\Icons\\INV_Misc_Orb_04",
	["Lay on Hands"] = "Interface\\Icons\\Spell_Holy_LayOnHands",
	["Blessing of Protection"] = "Interface\\Icons\\Spell_Holy_SealOfProtection",
	["Divine Shield"] = "Interface\\Icons\\Spell_Holy_DivineIntervention",
	["Divine Intervention"] = "Interface\\Icons\\Spell_Nature_TimeStop",
	["Tranquilizing Shot"] = "Interface\\Icons\\Spell_Nature_Drowsy",
	["Kick"] = "Interface\\Icons\\Ability_Kick",
	["Reincarnation"] = "Interface\\Icons\\Spell_Nature_Reincarnation",
	["Mana Tide Totem"] = "Interface\\Icons\\Spell_Frost_SummonWaterElemental",
}

Rat_Font = {
	[1] = "ABF",
	[2] = "Accidental Presidency",
	[3] = "Adventure",
	[4] = "Avqest",
	[5] = "Bazooka",
	[6] = "BigNoodleTitling",
	[7] = "BigNoodleTitling-Oblique",
	[8] = "BlackChancery",
	[9] = "Emblem",
	[10] = "Enigma__2",
	[11] = "Movie_Poster-Bold",
	[12] = "Porky",
	[13] = "rm_midse",
	[14] = "Tangerin",
	[15] = "Tw_Cen_MT_Bold",
	[16] = "Ultima_Campagnoli",
	[17] = "VeraSe",
	[18] = "visitor2",
	[19] = "Yellowjacket",
}

Rat_FontSize = {
	[1] = 12,
	[2] = 13,
	[3] = 10,
	[4] = 11,
	[5] = 11,
	[6] = 12,
	[7] = 12,
	[8] = 12,
	[9] = 11,
	[10] = 11,
	[11] = 20,
	[12] = 10,
	[13] = 12,
	[14] = 12,
	[15] = 12,
	[16] = 12,
	[17] = 11,
	[18] = 12,
	[19] = 10,
}

Rat_BarTexture = {
	[1] = "Aluminium",
	[2] = "Armory",
	[3] = "BantoBar",
	[4] = "Glaze2",
	[5] = "Gloss",
	[6] = "Graphite",
	[7] = "Grid",
	[8] = "Healbot",
	[9] = "LiteStep",
	[10] = "Minimalist",
	[11] = "normTex",
	[12] = "Otravi",
	[13] = "Outline",
	[14] = "Perl",
	[15] = "Round",
	[16] = "Smooth",
}


-- Default setting check

function RatDefault()
	if Rat_Settings["Warrior"] == nil then 
		Rat_Settings["Warrior"] = 1 
	elseif Rat_Settings["Warrior"] == 1 then
		Rat.Mainframe.WarriorFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
	elseif Rat_Settings["Warrior"] == 0 then
		Rat.Mainframe.WarriorFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
	end
	
	if Rat_Settings["Druid"] == nil then 
		Rat_Settings["Druid"] = 1 
	elseif Rat_Settings["Druid"] == 1 then
		Rat.Mainframe.DruidFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
	elseif Rat_Settings["Druid"] == 0 then
		Rat.Mainframe.DruidFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
	end
	
	if Rat_Settings["Paladin"] == nil then 
		Rat_Settings["Paladin"] = 1 
	elseif Rat_Settings["Paladin"] == 1 then
		Rat.Mainframe.PaladinFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
	elseif Rat_Settings["Paladin"] == 0 then
		Rat.Mainframe.PaladinFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
	end
	
	if Rat_Settings["Hunter"] == nil then 
		Rat_Settings["Hunter"] = 1 
	elseif Rat_Settings["Hunter"] == 1 then
		Rat.Mainframe.HunterFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
	elseif Rat_Settings["Hunter"] == 0 then
		Rat.Mainframe.HunterFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
	end
	
	if Rat_Settings["Shaman"] == nil then 
		Rat_Settings["Shaman"] = 1 
	elseif Rat_Settings["Shaman"] == 1 then
		Rat.Mainframe.ShamanFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
	elseif Rat_Settings["Shaman"] == 0 then
		Rat.Mainframe.ShamanFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
	end
	
	if Rat_Settings["Rogue"] == nil then 
		Rat_Settings["Rogue"] = 1 
	elseif Rat_Settings["Rogue"] == 1 then
		Rat.Mainframe.RogueFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
	elseif Rat_Settings["Rogue"] == 0 then
		Rat.Mainframe.RogueFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
	end
	
	if Rat_Settings["Warlock"] == nil then 
		Rat_Settings["Warlock"] = 1 
	elseif Rat_Settings["Warlock"] == 1 then
		Rat.Mainframe.WarlockFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
	elseif Rat_Settings["Warlock"] == 0 then
		Rat.Mainframe.WarlockFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
	end
	
	if Rat_unit == nil then 
		Rat_unit = UnitName("player") 
	end
	
	if Rat_Settings["showhide"] == nil then 
		Rat_Settings["showhide"] = 1 
	end
	if Rat_Settings["scale"] == nil then
		Rat_Settings["scale"] = 1
	end
end
-- Register events

Rat:RegisterEvent("ADDON_LOADED") 
Rat:RegisterEvent("RAID_ROSTER_UPDATE")
Rat:RegisterEvent("PARTY_MEMBERS_CHANGED")
Rat:RegisterEvent("SPELL_UPDATE_COOLDOWN")
Rat:RegisterEvent("CHAT_MSG_ADDON")
Rat:RegisterEvent("BAG_UPDATE_COOLDOWN")

-- function to handle events

function Rat:OnEvent()
	if (event == "ADDON_LOADED") and (arg1 == "Rat" or arg1 == "rat" or arg1 == "RAT") then
		DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A RaidAbilityTracker:|r Loaded!")
		DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A Rat:|r type |cFFFFFF00 /Rat show|r to show frame",1,1,1)
		DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A Rat:|r type |cFFFFFF00 /Rat hide|r to hide frame",1,1,1)
		DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A Rat:|r type |cFFFFFF00 /Rat options|r to show options menu",1,1,1)
		DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A Rat:|r hold |cFFFFFF00 'Alt'|r to move RAT",1,1,1)
		Rat.Mainframe:ConfigFrame()
		RatDefault()
		Rat.Options:ConfigFrame()
		Rat.Version:ConfigFrame()
		Rat.Minimap:CreateMinimapIcon()
		getSpells()
		getInvCd()
		sendCds()
		Rat:Update(true)
	elseif (event == "CHAT_MSG_ADDON") then
		if string.sub(arg1,1,3) == "RAT" then
			if Rat_unit ~= arg4 then 
				if string.sub(arg1,4,7) == "SYNC" then
					local cd = string.sub(arg1, string.find(arg1, "[", 1, true)+1, string.find(arg1, "]", 1, true)-1)
					local duration = arg2
					local cdname = string.sub(arg1, string.find(arg1, "(", 1, true)+1, string.find(arg1, ")", 1, true)-1)
					local name = arg4
					Rat:AddCd(name,cdname,cd,duration) 
					getSpells()
					getInvCd()
					sendCds()
					Rat:Update(true)
				end
				if string.sub(arg1,4,10) == "VERSION" then
					if string.sub(arg1,11,15) == "CHECK" then
						if sendThrottle["version"] == nil or (GetTime() - sendThrottle["version"]) > 10 then
							SendAddonMessage("RATVERSIONSYNC",Rat_Version,"RAID")
							sendThrottle["versioncheck"] = GetTime()
						end
					end
					if string.sub(arg1,11,15) == "SYNC" then
						RatVersionTbl[arg4] = arg2
						Rat.Version:Check()
					end
				end
			end
		end
	elseif (event == "RAID_ROSTER_UPDATE") then
		getSpells()
		getInvCd()
		Rat:Cleardb()
		Rat:HideVersionNameFrames()
		Rat:Update(true)
		sendCds()
	elseif (event == "SPELL_UPDATE_COOLDOWN") then
		getSpells()
		getInvCd()
		Rat:Cleardb()
		sendCds()
		Rat:Update()
	elseif (event == "BAG_UPDATE_COOLDOWN") then
	getInvCd()
	sendCds()
	Rat:Update()
	end
end

-- function to check version

function Rat.Version:Check()
	if Rat.Version:IsVisible() then 
		local count = 0
		local xaxis = 0
		local yaxis = 0
		for name, version in pairs(RatVersionTbl) do
			if count >= 30 then
				xaxis = 320
				yaxis = -450
			elseif count >= 20 then
				xaxis = 220
				yaxis = -300
			elseif count >= 10 then
				xaxis = 120
				yaxis = -150
			end
			VersionFTbl[name] = VersionFTbl[name] or Rat.Version:Insert(name)
			local frame = VersionFTbl[name]
			frame:SetPoint("TOPLEFT",1+xaxis,-(1+(15*count)+yaxis))
			frame.text:SetText(name.." |cFFFFFFFFv"..version)
			frame.text:SetTextColor(1,1,1,1) 
			frame.texture:SetTexture(Rat:GetClassColors(name))
			frame:Show()
			Rat.Version:SetWidth(123+(xaxis))
			if count < 10 then 
				Rat.Version:SetHeight(18+(15*count))
			else
				Rat.Version:SetHeight(153)
			end
			Rat.Version.close:SetPoint("CENTER",0,-((Rat.Version:GetHeight()/2)+6))
			count = count+1
		end
	end
end

-- function to create nameframes for the version check

function Rat.Version:Insert(name)
	local frame = CreateFrame('Button', name, Rat.Version)
	frame:SetWidth(120)
	frame:SetHeight(15)
	frame:SetBackdropColor(1,1,1,0.6)
	frame.texture = frame:CreateTexture(nil, 'ARTWORK')
	frame.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	frame.texture:SetWidth(118)
	frame.texture:SetHeight(13)
	frame.texture:SetPoint('TOPLEFT', 1, -1)
	frame.texture:SetTexture("Interface/TargetingFrame/UI-StatusBar")
	frame.text = frame:CreateFontString(nil, "OVERLAY")
	frame.text:SetPoint("CENTER",0, 0)
	frame.text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	frame.text:SetTextColor(1, 1, 1, 1)
	frame.text:SetShadowOffset(1,-1)
	frame.text:SetText("name")
	return frame
end

-- function to congig versionframe

function Rat.Version:ConfigFrame()

	backdrop = {
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		tile="true",
		tileSize="8",
		edgeSize="8",
		insets={
				left="2",
				right="2",
				top="2",
				bottom="2"
			}
	}

	self:SetFrameStrata("HIGH")
	self:SetWidth(120) -- Set these to whatever height/width is needed 
	self:SetHeight(100) -- for your Texture
	self:SetPoint("CENTER",0,0)
	self:SetMovable(1)
	self:EnableMouse(1)
	self:EnableMouseWheel(1)
	self:SetBackdrop(backdrop)
	self:SetBackdropColor(0,0,0,1)
	self:SetMovable(true)
	self:SetResizable(enable)
	self:SetMinResize(400, 120)
	
	-- close button

	self.close = CreateFrame("Button",nil,self,"UIPanelButtonTemplate")
	self.close:SetPoint("CENTER",0,-((self:GetHeight()/2)+5))
	self.close:SetFrameStrata("HIGH")
	self.close:SetWidth(79)
	self.close:SetHeight(18)
	self.close:SetText("Close")
	self.close:SetScript("OnClick", function() PlaySound("igMainMenuOptionCheckBoxOn"); self:Hide(); end)
	
	self:Hide()
end

-- function to config mainframe

function Rat.Mainframe:ConfigFrame()
	if Rat_Settings["topbarcolor"] == nil then
		Rat_Settings["topbarcolor"] = {["r"] = 0.1, ["g"] = 0.1, ["b"] = 1}
	end
	if Rat_Settings["abilitybarcolor"] == nil then
		Rat_Settings["abilitybarcolor"] = {["r"] = 0.0, ["g"] = 0.44, ["b"] = 0.87}
	end
	if Rat_Settings["abilitytextcolor"] == nil then
		Rat_Settings["abilitytextcolor"] = {["r"] = 1, ["g"] = 1, ["b"] = 1}
	end
	if Rat_Settings["font"] == nil then
		Rat_Settings["font"] = 1
	end
	if Rat_Settings["bartexture"] == nil then
		Rat_Settings["bartexture"] = 1
	end
	Rat.Mainframe.options = {}
	function Rat.Mainframe.options:StartMoving()
		this:StartMoving()
		this.drag = true
	end
	
	function Rat.Mainframe.options:StopMovingOrSizing()
		this:StopMovingOrSizing()
		this.drag = false
	end
	
	backdrop = {
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile="false",
			tileSize="8",
			edgeSize="8",
			insets={
				left="2",
				right="2",
				top="2",
				bottom="2"
			}
	}
	self:SetFrameStrata("LOW")
	self:SetWidth(250) -- Set these to whatever height/width is needed 
	self:SetHeight(41) -- for your Texture
	self:SetPoint("CENTER",0,0)
	self:SetMovable(1)
	self:EnableMouse(1)
	self:RegisterForDrag("LeftButton")
	self:SetBackdrop(backdrop)
	
	self:SetScript("OnDragStart", Rat.Mainframe.options.StartMoving)
	self:SetScript("OnDragStop", Rat.Mainframe.options.StopMovingOrSizing)
	self:SetScript("OnUpdate", function()
		this:EnableMouse(IsAltKeyDown())
		if not IsAltKeyDown() and this.drag then
			self.options:StopMovingOrSizing()
		end
	end)
	
	self.Background = {}
	self.Background.Top = CreateFrame("Frame",nil,self) -- top frame
	self.Background.Tab1 = CreateFrame("Frame",nil,self) -- mid frame
	
	-- create top background
	local backdrop = {
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile="false",
			tileSize="4",
			edgeSize="4",
			insets={
				left="2",
				right="2",
				top="2",
				bottom="2"
			}
	}
	self.Background.Top:SetFrameStrata('BACKGROUND')
	self.Background.Top:SetWidth(self:GetWidth()-2)
	self.Background.Top:SetHeight(20)
	self.Background.Top:SetBackdrop(backdrop)
	self.Background.Top:SetBackdropColor(0,0,0,1)
	self.Background.Top:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
	self.Background.Top:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText("Hold 'Alt' key to move the window", 1, 1, 1, 1);
		GameTooltip:Show()
	end)
	self.Background.Top:SetScript("OnEnter", function()
		GameTooltip:Hide()
	end)
	
	topbg = self.Background.Top:CreateTexture(nil, 'ARTWORK',self)
	topbg:SetPoint("TOPLEFT",1,-1)
	topbg:SetWidth(self:GetWidth()-5)
	topbg:SetHeight(17)
	topbg:SetTexture(Rat_Settings["topbarcolor"]["r"],Rat_Settings["topbarcolor"]["g"],Rat_Settings["topbarcolor"]["b"])
	topbg:SetGradientAlpha("Vertical", 1,1,1, 0.25, 1, 1, 1, 1)
	
	self.Background.Top.Title = self.Background.Top:CreateFontString(nil, "ARTWORK")
	self.Background.Top.Title:SetPoint("LEFT", 22, 0)
	self.Background.Top.Title:SetFont("Interface\\AddOns\\Rat\\fonts\\"..Rat_Font[Rat_Settings["font"]]..".TTF", Rat_FontSize[Rat_Settings["font"]]+1)
	self.Background.Top.Title:SetTextColor(255, 255, 255, 1)
	self.Background.Top.Title:SetShadowOffset(2,-2)
	self.Background.Top.Title:SetText("RAT v"..Rat_Version)
	
	-- Druid option frame
	local r, l, t, b = Rat:ClassPos("Druid")
	self.DruidFrame = CreateFrame('Button', "Druid", self)
	self.DruidFrame:SetWidth(16)
	self.DruidFrame:SetHeight(16)
	self.DruidFrame:SetBackdropColor(0,0,0,1)
	self.DruidFrame:SetPoint('TOPRIGHT', -24, -1)
	self.DruidFrame:SetFrameStrata('MEDIUM')
	self.DruidFrame.Icon = self.DruidFrame:CreateTexture(nil, 'ARTWORK')
	self.DruidFrame.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.DruidFrame.Icon:SetTexCoord(r, l, t, b)
	self.DruidFrame.Icon:SetPoint('TOPRIGHT', -1, -1)
	self.DruidFrame.Icon:SetWidth(16)
	self.DruidFrame.Icon:SetHeight(16)
	self.DruidFrame:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(self.DruidFrame, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(this:GetName(), 1, 0.49, 0.04, 1, 1);
		GameTooltip:Show()
		end)
	self.DruidFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	self.DruidFrame:SetScript("OnMouseDown", function()
			if (arg1 == "LeftButton") then
				if Rat_Settings[this:GetName()] == 1 then
					Rat_Settings[this:GetName()] = 0
					self.DruidFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
				else
					Rat_Settings[this:GetName()] = 1
					self.DruidFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
				end
			end
		end)
	
	-- Hunter option frame
	local r, l, t, b = Rat:ClassPos("Hunter")
	self.HunterFrame = CreateFrame('Button', "Hunter", self)
	self.HunterFrame:SetWidth(16)
	self.HunterFrame:SetHeight(16)
	self.HunterFrame:SetBackdropColor(0,0,0,1)
	self.HunterFrame:SetPoint('TOPRIGHT', -41, -1)
	self.HunterFrame:SetFrameStrata('MEDIUM')
	self.HunterFrame.Icon = self.HunterFrame:CreateTexture(nil, 'ARTWORK')
	self.HunterFrame.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.HunterFrame.Icon:SetTexCoord(r, l, t, b)
	self.HunterFrame.Icon:SetPoint('TOPRIGHT', -1, -1)
	self.HunterFrame.Icon:SetWidth(16)
	self.HunterFrame.Icon:SetHeight(16)
	self.HunterFrame:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(self.HunterFrame, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(this:GetName(), 0.67, 0.83, 0.45, 1, 1);
		GameTooltip:Show()
		end)
	self.HunterFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	self.HunterFrame:SetScript("OnMouseDown", function()
			if (arg1 == "LeftButton") then
				if Rat_Settings[this:GetName()] == 1 then
					Rat_Settings[this:GetName()] = 0
					self.HunterFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
				else
					Rat_Settings[this:GetName()] = 1
					self.HunterFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
				end
			end
		end)

	-- Paladin option frame
	local r, l, t, b = Rat:ClassPos("Paladin")
	self.PaladinFrame = CreateFrame('Button', "Paladin", self)
	self.PaladinFrame:SetWidth(16)
	self.PaladinFrame:SetHeight(16)
	self.PaladinFrame:SetBackdropColor(0,0,0,1)
	self.PaladinFrame:SetPoint('TOPRIGHT', -58, -1)
	self.PaladinFrame:SetFrameStrata('MEDIUM')
	self.PaladinFrame.Icon = self.PaladinFrame:CreateTexture(nil, 'ARTWORK')
	self.PaladinFrame.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.PaladinFrame.Icon:SetTexCoord(r, l, t, b)
	self.PaladinFrame.Icon:SetPoint('TOPRIGHT', -1, -1)
	self.PaladinFrame.Icon:SetWidth(16)
	self.PaladinFrame.Icon:SetHeight(16)
	self.PaladinFrame:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(self.PaladinFrame, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(this:GetName(), 0.96, 0.55, 0.73, 1, 1);
		GameTooltip:Show()
	end)
	self.PaladinFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	self.PaladinFrame:SetScript("OnMouseDown", function()
			if (arg1 == "LeftButton") then
				if Rat_Settings[this:GetName()] == 1 then
					Rat_Settings[this:GetName()] = 0
					self.PaladinFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
				else
					Rat_Settings[this:GetName()] = 1
					self.PaladinFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
				end
			end
		end)

	-- Shaman option frame
	local r, l, t, b = Rat:ClassPos("Shaman")
	self.ShamanFrame = CreateFrame('Button', "Shaman", self)
	self.ShamanFrame:SetWidth(16)
	self.ShamanFrame:SetHeight(16)
	self.ShamanFrame:SetBackdropColor(0,0,0,1)
	self.ShamanFrame:SetPoint('TOPRIGHT', -58, -1)
	self.ShamanFrame:SetFrameStrata('MEDIUM')
	self.ShamanFrame.Icon = self.ShamanFrame:CreateTexture(nil, 'ARTWORK')
	self.ShamanFrame.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.ShamanFrame.Icon:SetTexCoord(r, l, t, b)
	self.ShamanFrame.Icon:SetPoint('TOPRIGHT', -1, -1)
	self.ShamanFrame.Icon:SetWidth(16)
	self.ShamanFrame.Icon:SetHeight(16)
	self.ShamanFrame:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(self.ShamanFrame, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(this:GetName(), 0.0, 0.44, 0.87, 1, 1);
		GameTooltip:Show()
	end)
	self.ShamanFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	self.ShamanFrame:SetScript("OnMouseDown", function()
		if (arg1 == "LeftButton") then
				if Rat_Settings[this:GetName()] == 1 then
					Rat_Settings[this:GetName()] = 0
					self.ShamanFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
				else
					Rat_Settings[this:GetName()] = 1
					self.ShamanFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
				end
			end
		end)

	
	-- Rogue option frame
	local r, l, t, b = Rat:ClassPos("Rogue")
	self.RogueFrame = CreateFrame('Button', "Rogue", self)
	self.RogueFrame:SetWidth(16)
	self.RogueFrame:SetHeight(16)
	self.RogueFrame:SetPoint('TOPRIGHT', -75, -1)
	self.RogueFrame:SetFrameStrata('MEDIUM')
	self.RogueFrame.Icon = self.RogueFrame:CreateTexture(nil, 'ARTWORK')
	self.RogueFrame.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.RogueFrame.Icon:SetTexCoord(r, l, t, b)
	self.RogueFrame.Icon:SetPoint('TOPRIGHT', -1, -1)
	self.RogueFrame.Icon:SetWidth(16)
	self.RogueFrame.Icon:SetHeight(16)
	self.RogueFrame:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(self.RogueFrame, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(this:GetName(), 1.00, 0.96, 0.41, 1, 1);
		GameTooltip:Show()
		end)
	self.RogueFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	self.RogueFrame:SetScript("OnMouseDown", function()
			if (arg1 == "LeftButton") then
				if Rat_Settings[this:GetName()] == 1 then
					Rat_Settings[this:GetName()] = 0
					self.RogueFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
				else
					Rat_Settings[this:GetName()] = 1
					self.RogueFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
				end
			end
		end)
	
	-- Warlock option frame
	local r, l, t, b = Rat:ClassPos("Warlock")
	self.WarlockFrame = CreateFrame('Button', "Warlock", self)
	self.WarlockFrame:SetWidth(16)
	self.WarlockFrame:SetHeight(16)
	self.WarlockFrame:SetPoint('TOPRIGHT', -92, -1)
	self.WarlockFrame:SetFrameStrata('MEDIUM')
	self.WarlockFrame.Icon = self.WarlockFrame:CreateTexture(nil, 'ARTWORK')
	self.WarlockFrame.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.WarlockFrame.Icon:SetTexCoord(r, l, t, b)
	self.WarlockFrame.Icon:SetPoint('TOPRIGHT', -1, -1)
	self.WarlockFrame.Icon:SetWidth(16)
	self.WarlockFrame.Icon:SetHeight(16)
	self.WarlockFrame:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(self.WarlockFrame, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(this:GetName(), 0.58, 0.51, 0.79, 1, 1);
		GameTooltip:Show()
		end)
	self.WarlockFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	self.WarlockFrame:SetScript("OnMouseDown", function()
			if (arg1 == "LeftButton") then
				if Rat_Settings[this:GetName()] == 1 then
					Rat_Settings[this:GetName()] = 0
					self.WarlockFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
				else
					Rat_Settings[this:GetName()] = 1
					self.WarlockFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
				end
			end
		end)
	
	-- Warrior option frame
	local r, l, t, b = Rat:ClassPos("Warrior")
	self.WarriorFrame = CreateFrame('Button', "Warrior", self)
	self.WarriorFrame:SetWidth(16)
	self.WarriorFrame:SetHeight(16)
	self.WarriorFrame:SetPoint('TOPRIGHT', -109, -1)
	self.WarriorFrame:SetFrameStrata('MEDIUM')
	self.WarriorFrame.Icon = self.WarriorFrame:CreateTexture(nil, 'ARTWORK')
	self.WarriorFrame.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.WarriorFrame.Icon:SetTexCoord(r, l, t, b)
	self.WarriorFrame.Icon:SetPoint('TOPRIGHT', -1, -1)
	self.WarriorFrame.Icon:SetWidth(16)
	self.WarriorFrame.Icon:SetHeight(16)
	self.WarriorFrame:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(self.WarriorFrame, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(this:GetName(), 0.78, 0.61, 0.43, 1, 1);
		GameTooltip:Show()
		end)
	self.WarriorFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)	
	self.WarriorFrame:SetScript("OnMouseDown", function()
			if (arg1 == "LeftButton") then
				if Rat_Settings[this:GetName()] == 1 then
					Rat_Settings[this:GetName()] = 0
					self.WarriorFrame.Icon:SetVertexColor(0.5, 0.5, 0.5)
				else
					Rat_Settings[this:GetName()] = 1
					self.WarriorFrame.Icon:SetVertexColor(1.0, 1.0, 1.0)
				end
			end
		end)
		
	-- create mid background	
	local backdrop = {
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		tile="true",
		tileSize="8",
		edgeSize="22",
		insets={
				left="2",
				right="2",
				top="2",
				bottom="2"
			}
		}
	self.Background.Tab1:SetFrameStrata("BACKGROUND")
	self.Background.Tab1:SetWidth(self:GetWidth())
	self.Background.Tab1:SetHeight(23)
	self.Background.Tab1:SetBackdrop(backdrop)
	self.Background.Tab1:SetBackdropColor(0,0,0,0.5)
	self.Background.Tab1:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -17)

	-- create close button
	self.CloseButton = CreateFrame("Button",nil,self,"UIPanelCloseButton")
	self.CloseButton:SetPoint("TOPLEFT",self:GetWidth()-23,2)
	self.CloseButton:SetWidth(24)
	self.CloseButton:SetHeight(24)
	self.CloseButton:SetFrameStrata('MEDIUM')
	self.CloseButton:SetScript("OnMouseUp", function()
			if (arg1 == "LeftButton") then
				Rat_Settings["showhide"] = 0
			end
		end)
		
	-- icon
	self.Iconframe = CreateFrame('Button',"Iconframe",self)
	self.Iconframe:SetWidth(18)
	self.Iconframe:SetHeight(18)
	self.Iconframe:SetPoint("TOPLEFT",2,-1)
	self.Iconframe:SetFrameStrata('MEDIUM')
	self.Iconframe.Icon = self.Iconframe:CreateTexture(nil,'ARTWORK')
	self.Iconframe.Icon:SetWidth(18)
	self.Iconframe.Icon:SetHeight(18)
	self.Iconframe.Icon:SetPoint('TOPLEFT', 0, 0)
	self.Iconframe.Icon:SetTexture("Interface\\AddOns\\Rat\\media\\icon.tga")
	self.Iconframe:SetScript("OnEnter", function() 
		self.Iconframe.Icon:SetVertexColor(0.5, 0.5, 0.5)
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText("Options Menu", 1, 1, 1, 1);
		GameTooltip:Show()
	end)
	self.Iconframe:SetScript("OnLeave", function() 
		self.Iconframe.Icon:SetVertexColor(1.0, 1.0, 1.0)
		GameTooltip:Hide()
	end)
	self.Iconframe:SetScript("OnMouseDown", function()
			if (arg1 == "LeftButton") then
				if Rat.Options:IsVisible() then 
					Rat.Options:Hide()
				else 
					Rat.Options:Show() 
				end
			end
		end)
end

-- function to congig the options frame

function Rat.Options:ConfigFrame()

	Rat.Options.Drag = { }
	function Rat.Options.Drag:StartMoving()
		this:StartMoving()
	end
	
	function Rat.Options.Drag:StopMovingOrSizing()
		this:StopMovingOrSizing()
	end

	local backdrop = {
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			tile="false",
			tileSize="4",
			edgeSize="8",
			insets={
				left="2",
				right="2",
				top="2",
				bottom="2"
			}
	}
	
	self:SetFrameStrata("BACKGROUND")
	self:SetWidth(875) -- Set these to whatever height/width is needed 
	self:SetHeight(400) -- for your Texture
	self:SetPoint("CENTER",UIParent,"CENTER",0,0)
	self:SetMovable(1)
	self:EnableMouse(1)
	self:RegisterForDrag("LeftButton")
	self:SetScript("OnDragStart", Rat.Options.Drag.StartMoving)
	self:SetScript("OnDragStop", Rat.Options.Drag.StopMovingOrSizing)
	self:SetBackdrop(backdrop) --border around the frame
	self:SetBackdropColor(0,0,0,1);
	
	-- background
	self.Background = {} -- Background Frame table
	
	self.Background.Topleft = CreateFrame("Frame",nil,self) -- Topleft Background Frame
	self.Background.Topright = CreateFrame("Frame",nil,self) -- Topright Background Frame
	self.Background.Topmid = CreateFrame("Frame",nil,self) -- Topleft Background Frame
	self.Background.Bottommid = CreateFrame("Frame",nil,self) -- Topright Background Frame
	self.Background.Bottomleft = CreateFrame("Frame",nil,self) -- Bottomleft Background Frame
	self.Background.Bottomright =  CreateFrame("Frame",nil,self) -- Bottomright Background Frame	
	self.Background.Tab1 =  CreateFrame("Frame",nil,self) -- Mid Background Frame
	self.Background.Tab2 =  CreateFrame("Frame",nil,self) -- Mid Background Frame
	self.Background.Button1 =  CreateFrame("Button",nil,self) -- Mid Background Frame
	self.Background.Button2 =  CreateFrame("Button",nil,self) -- Mid Background Frame

	-- Topleft Background Frame
	local backdrop = {bgFile = "Interface\\auctionframe\\ui-auctionframe-bid-topleft"}  -- path to the background texture
	self.Background.Topleft:SetFrameStrata("BACKGROUND")
	self.Background.Topleft:SetWidth(200) -- Set these to whatever height/width is needed 
	self.Background.Topleft:SetHeight(200) -- for your Texture
	self.Background.Topleft:SetBackdrop(backdrop)
	self.Background.Topleft:SetPoint("TOPLEFT", self, -7, 9)
	
	-- Topmid Background Frame
	local backdrop = {bgFile = "Interface\\auctionframe\\ui-auctionframe-auction-top"}  -- path to the background texture
	self.Background.Topmid:SetFrameStrata("BACKGROUND")
	self.Background.Topmid:SetWidth(482) -- Set these to whatever height/width is needed 
	self.Background.Topmid:SetHeight(200) -- for your Texture
	self.Background.Topmid:SetBackdrop(backdrop)
	self.Background.Topmid:SetPoint("TOPLEFT", self, "TOPLEFT", 193, 9)
	
	-- Topright Background Frame
	local backdrop = {bgFile = "Interface\\auctionframe\\ui-auctionframe-auction-topright"}  -- path to the background texture
	self.Background.Topright:SetFrameStrata("BACKGROUND")
	self.Background.Topright:SetWidth(200) -- Set these to whatever height/width is needed 
	self.Background.Topright:SetHeight(200) -- for your Texture
	self.Background.Topright:SetBackdrop(backdrop)
	self.Background.Topright:SetPoint("TOPLEFT", self, "TOPLEFT", 675, 9)
	
	-- Bottomleft Background Frame
	local backdrop = {bgFile = "Interface\\auctionframe\\ui-auctionframe-bid-botleft"}  -- path to the background texture
	self.Background.Bottomleft:SetFrameStrata("BACKGROUND")
	self.Background.Bottomleft:SetWidth(200) -- Set these to whatever height/width is needed 
	self.Background.Bottomleft:SetHeight(296) -- for your Texture
	self.Background.Bottomleft:SetBackdrop(backdrop)
	self.Background.Bottomleft:SetPoint("TOPLEFT", self, "TOPLEFT", -7, -191)
	
	-- Bottommid Background Frame
	local backdrop = {bgFile = "Interface\\auctionframe\\ui-auctionframe-auction-bot"}  -- path to the background texture
	self.Background.Bottommid:SetFrameStrata("BACKGROUND")
	self.Background.Bottommid:SetWidth(482) -- Set these to whatever height/width is needed 
	self.Background.Bottommid:SetHeight(296) -- for your Texture
	self.Background.Bottommid:SetBackdrop(backdrop)
	self.Background.Bottommid:SetPoint("TOPLEFT", self, "TOPLEFT", 193, -191)
	
	-- Bottomright Background Frame
	local backdrop = {bgFile = "Interface\\auctionframe\\ui-auctionframe-browse-botright"}  -- path to the background texture
	self.Background.Bottomright:SetFrameStrata("BACKGROUND")
	self.Background.Bottomright:SetWidth(200) -- Set these to whatever height/width is needed 
	self.Background.Bottomright:SetHeight(296) -- for your Texture
	self.Background.Bottomright:SetBackdrop(backdrop)
	self.Background.Bottomright:SetPoint("TOPLEFT", self, "TOPLEFT", 675, -191)
	
	-- Tab1 Background Frame
	local backdrop = {bgFile = "Interface\\raidframe\\ui-raidframe-groupbg"}  -- path to the background texture
	self.Background.Tab1:SetFrameStrata("LOW")
	self.Background.Tab1:SetWidth(865) -- Set these to whatever height/width is needed 
	self.Background.Tab1:SetHeight(348) -- for your Texture
	self.Background.Tab1:SetBackdrop(backdrop)
	self.Background.Tab1:SetPoint("TOPLEFT", self, "TOPLEFT", 6, -48)	
	
	-- Tab2 Background Frame
	local backdrop = {bgFile = "Interface\\raidframe\\ui-raidframe-groupbg"}  -- path to the background texture
	self.Background.Tab2:SetFrameStrata("LOW")
	self.Background.Tab2:SetWidth(865) -- Set these to whatever height/width is needed 
	self.Background.Tab2:SetHeight(348) -- for your Texture
	self.Background.Tab2:SetBackdrop(backdrop)
	self.Background.Tab2:SetPoint("TOPLEFT", self, "TOPLEFT", 6, -48)	
	
	-- Tab buttons
	
	-- Button1
	self.Background.Button1:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	self.Background.Button1:SetBackdropColor(0,0,0,0.6)
	self.Background.Button1:SetFrameStrata("MEDIUM")
	self.Background.Button1:SetPoint("TOPLEFT", self, "TOPLEFT", 80, -25)
	self.Background.Button1:SetWidth(85)
	self.Background.Button1:SetHeight(20)
	self.Background.Button1:SetScript("OnClick", function() 
		self.Background.Tab1:Show()
		self.Background.Tab2:Hide()
		self.Background.Button2:SetBackdropColor(1,1,1,0)
	end)
	self.Background.Button1:SetScript("OnEnter", function() 
		self.Background.Button1:SetBackdropColor(1,1,1,0.6)
	end)
	self.Background.Button1:SetScript("OnLeave", function() 
		if self.Background.Tab1:IsVisible() then
			self.Background.Button1:SetBackdropColor(0,0,0,0.6)
		else
			self.Background.Button1:SetBackdropColor(1,1,1,0)
		end
	end)
	
	local text = self.Background.Button1:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", 0, 0)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
	text:SetText("Class options")

	-- Button2
	self.Background.Button2:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	self.Background.Button2:SetBackdropColor(1,1,1,0)
	self.Background.Button2:SetFrameStrata("MEDIUM")
	self.Background.Button2:SetPoint("TOPLEFT", self, "TOPLEFT", 180, -25)
	self.Background.Button2:SetWidth(60)
	self.Background.Button2:SetHeight(20)
	self.Background.Button2:SetScript("OnClick", function() 
		self.Background.Tab2:Show()
		self.Background.Tab1:Hide()
		self.Background.Button1:SetBackdropColor(1,1,1,0)
	end)
	self.Background.Button2:SetScript("OnEnter", function() 
		self.Background.Button2:SetBackdropColor(1,1,1,0.6)
	end)
	self.Background.Button2:SetScript("OnLeave", function() 
		if self.Background.Tab2:IsVisible() then
			self.Background.Button2:SetBackdropColor(0,0,0,0.6)
		else
			self.Background.Button2:SetBackdropColor(1,1,1,0)
		end
	end)
	
	local text = self.Background.Button2:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", 0, 0)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
	text:SetText("Settings")

	self.Background.Tab2:Hide() -- hides second tab at start
	
	-- Scale slider

	self.Background.Slider = CreateFrame("Slider", "Slider", self.Background.Tab2, 'OptionsSliderTemplate')
	self.Background.Slider:SetWidth(200)
	self.Background.Slider:SetHeight(20)
	self.Background.Slider:SetPoint("TOPLEFT", 70, -25)
	self.Background.Slider:SetMinMaxValues(0.5, 1.5)
	self.Background.Slider:SetValue(Rat_Settings["scale"])
	self.Background.Slider:SetValueStep(0.025)
	getglobal(self.Background.Slider:GetName() .. 'Low'):SetText('-100%')
	getglobal(self.Background.Slider:GetName() .. 'High'):SetText('100%')
	self.Background.Slider:SetScript("OnValueChanged", function() 
		Rat_Settings["scale"] = this:GetValue()
		Rat.Mainframe:SetScale(Rat_Settings["scale"])
	end)
	self.Background.Slider:Show()
	Rat.Mainframe:SetScale(Rat_Settings["scale"])
	
	local text = self.Background.Slider:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", 0, 15)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
	text:SetText("Scale")	
	
	-- Buttons for color picker
	
	local backdrop = {
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			tile="false",
			tileSize="4",
			edgeSize="4",
			insets={
				left="2",
				right="2",
				top="2",
				bottom="2"
			}
	}
	
	-- top bar 
	self.Background.topbarcolor =  CreateFrame("Button","topbarcolor",self.Background.Tab2) -- 
	self.Background.topbarcolor:SetWidth(25)
	self.Background.topbarcolor:SetHeight(25)
	self.Background.topbarcolor:SetPoint("TOPLEFT", 400, -80)
	self.Background.topbarcolor:SetBackdrop(backdrop)
	self.Background.topbarcolor:SetScript("OnClick", function()
		Rat:OpenColorPicker(this, "topbarcolor")
	end)
	
	self.Background.topbarcolor.Texture = self.Background.topbarcolor:CreateTexture(nil, 'ARTWORK')
	self.Background.topbarcolor.Texture:SetTexture(Rat_Settings["topbarcolor"]["r"],Rat_Settings["topbarcolor"]["g"],Rat_Settings["topbarcolor"]["b"],1)
	self.Background.topbarcolor.Texture:SetPoint('TOPLEFT', 2, -2)
	self.Background.topbarcolor.Texture:SetWidth(21)
	self.Background.topbarcolor.Texture:SetHeight(21)	
	
	local text = self.Background.topbarcolor:CreateFontString(nil, "OVERLAY")
	text:SetPoint("LEFT", 40, 0)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
	text:SetText("Title bar color")

	
	-- ability bar 
	self.Background.abilitybarcolor =  CreateFrame("Button","abilitybarcolor",self.Background.Tab2) -- 
	self.Background.abilitybarcolor:SetWidth(25)
	self.Background.abilitybarcolor:SetHeight(25)
	self.Background.abilitybarcolor:SetPoint("TOPLEFT", 400, -130)
	self.Background.abilitybarcolor:SetBackdrop(backdrop)
	self.Background.abilitybarcolor:SetScript("OnClick", function()
		Rat:OpenColorPicker(this, "abilitybarcolor")
	end)
	
	self.Background.abilitybarcolor.Texture = self.Background.abilitybarcolor:CreateTexture(nil, 'ARTWORK')
	self.Background.abilitybarcolor.Texture:SetTexture(Rat_Settings["abilitybarcolor"]["r"],Rat_Settings["abilitybarcolor"]["g"],Rat_Settings["abilitybarcolor"]["b"],1)
	self.Background.abilitybarcolor.Texture:SetPoint('TOPLEFT', 2, -2)
	self.Background.abilitybarcolor.Texture:SetWidth(21)
	self.Background.abilitybarcolor.Texture:SetHeight(21)	
	
	local text = self.Background.abilitybarcolor:CreateFontString(nil, "OVERLAY")
	text:SetPoint("LEFT", 40, 0)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
	text:SetText("Ability bar color")
	
	-- ability text 
	self.Background.abilitytextcolor =  CreateFrame("Button","abilitytextcolor",self.Background.Tab2) -- 
	self.Background.abilitytextcolor:SetWidth(25)
	self.Background.abilitytextcolor:SetHeight(25)
	self.Background.abilitytextcolor:SetPoint("TOPLEFT", 400, -180)
	self.Background.abilitytextcolor:SetBackdrop(backdrop)
	self.Background.abilitytextcolor:SetScript("OnClick", function()
		Rat:OpenColorPicker(this, "abilitytextcolor")
	end)
	
	self.Background.abilitytextcolor.Texture = self.Background.abilitytextcolor:CreateTexture(nil, 'ARTWORK')
	self.Background.abilitytextcolor.Texture:SetTexture(Rat_Settings["abilitytextcolor"]["r"],Rat_Settings["abilitytextcolor"]["g"],Rat_Settings["abilitytextcolor"]["b"],1)
	self.Background.abilitytextcolor.Texture:SetPoint('TOPLEFT', 2, -2)
	self.Background.abilitytextcolor.Texture:SetWidth(21)
	self.Background.abilitytextcolor.Texture:SetHeight(21)	
	
	local text = self.Background.abilitytextcolor:CreateFontString(nil, "OVERLAY")
	text:SetPoint("LEFT", 40, 0)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
	text:SetText("Ability text color")

	-- font dropdown
	
	self.FontDropdown = CreateFrame("Button", "Font Dropdown",self.Background.Tab2, "UIDropDownMenuTemplate")
	self.FontDropdown:SetPoint("TOPLEFT", 600 , -80)
	
	local text = self.FontDropdown:CreateFontString(nil, "OVERLAY")
	text:SetPoint("LEFT", 165, 2)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
	text:SetText("Font")
	
	UIDropDownMenu_Initialize(self.FontDropdown, Rat.Options.FontDrop)
	UIDropDownMenu_SetSelectedID(self.FontDropdown, Rat_Settings["font"])
	
	-- bartexture dropdown

	self.BarTextureDropdown = CreateFrame("Button", "Bar texture Dropdown",self.Background.Tab2, "UIDropDownMenuTemplate")
	self.BarTextureDropdown:SetPoint("TOPLEFT", 600 , -130)
	
	local text = self.BarTextureDropdown:CreateFontString(nil, "OVERLAY")
	text:SetPoint("LEFT", 165, 2)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
	text:SetText("Bar texture")
	
	UIDropDownMenu_Initialize(self.BarTextureDropdown, Rat.Options.BarTextureDrop)
	UIDropDownMenu_SetSelectedID(self.BarTextureDropdown, Rat_Settings["bartexture"])
	
	-- border
	self.left = self.Background.Tab1:CreateTexture(nil, "BORDER")
	self.left:SetWidth(502.5)
	self.left:SetHeight(2)
	self.left:SetPoint('TOPLEFT', -70, -60)
	self.left:SetTexture(1, 1, 1, 1)
	self.left:SetGradientAlpha("Horizontal", 0, 0, 0, 0, 1, 1, 1, 0.8)

	self.right = self.Background.Tab1:CreateTexture(nil, "BORDER")
	self.right:SetWidth(502.5)
	self.right:SetHeight(2)
	self.right:SetPoint('TOPRIGHT', 70, -60)
	self.right:SetTexture(1, 1, 1, 1)
	self.right:SetGradientAlpha("Horizontal", 1, 1, 1, 0.8, 0, 0, 0, 0)
	
	-- Class icons
	
		local backdrop = {
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		tile="true",
		tileSize="8",
		edgeSize="8",
		insets={
				left="2",
				right="2",
				top="2",
				bottom="2"
			}
		}
	
	-- Warrior
	local r, l, t, b = Rat:ClassPos("Warrior")
	self.Warrior = CreateFrame("Frame",nil,self.Background.Tab1) -- warrior class frame
	self.Warrior:SetWidth(125)
	self.Warrior:SetHeight(250)
	self.Warrior:SetPoint('TOPLEFT', 20, -70)
	self.Warrior:SetBackdrop(backdrop)
	self.Warrior:SetBackdropColor(0,0,0,1)
	self.Warrior.Icon = self.Warrior:CreateTexture(nil, 'ARTWORK')
	self.Warrior.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.Warrior.Icon:SetTexCoord(r, l, t, b)
	self.Warrior.Icon:SetPoint('CENTER', 0, 155)
	self.Warrior.Icon:SetWidth(25)
	self.Warrior.Icon:SetHeight(25)
	
	-- Warlock
	local r, l, t, b = Rat:ClassPos("Warlock")
	self.Warlock = CreateFrame("Frame",nil,self.Background.Tab1) -- warlock class frame
	self.Warlock:SetWidth(125)
	self.Warlock:SetHeight(250)
	self.Warlock:SetPoint('TOPLEFT', 160, -70)
	self.Warlock:SetBackdrop(backdrop)
	self.Warlock:SetBackdropColor(0,0,0,1)
	self.Warlock.Icon = self.Warlock:CreateTexture(nil, 'ARTWORK')
	self.Warlock.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.Warlock.Icon:SetTexCoord(r, l, t, b)
	self.Warlock.Icon:SetPoint('CENTER', 0,155)
	self.Warlock.Icon:SetWidth(25)
	self.Warlock.Icon:SetHeight(25)
	
	-- Rogue
	local r, l, t, b = Rat:ClassPos("Rogue")
	self.Rogue = CreateFrame("Frame",nil,self.Background.Tab1) -- rogue class frame
	self.Rogue:SetWidth(125)
	self.Rogue:SetHeight(250)
	self.Rogue:SetPoint('TOPLEFT', 300, -70)
	self.Rogue:SetBackdrop(backdrop)
	self.Rogue:SetBackdropColor(0,0,0,1)
	self.Rogue.Icon = self.Rogue:CreateTexture(nil, 'ARTWORK')
	self.Rogue.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.Rogue.Icon:SetTexCoord(r, l, t, b)
	self.Rogue.Icon:SetPoint('CENTER', 0,155)
	self.Rogue.Icon:SetWidth(25)
	self.Rogue.Icon:SetHeight(25)
	
	-- Paladin
	local r, l, t, b = Rat:ClassPos("Paladin")
	self.Paladin = CreateFrame("Frame",nil,self.Background.Tab1) -- paladin class frame
	self.Paladin:SetWidth(125)
	self.Paladin:SetHeight(250)
	self.Paladin:SetPoint('TOPLEFT', 440, -70)
	self.Paladin:SetBackdrop(backdrop)
	self.Paladin:SetBackdropColor(0,0,0,1)
	self.Paladin.Icon = self.Paladin:CreateTexture(nil, 'ARTWORK')
	self.Paladin.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.Paladin.Icon:SetTexCoord(r, l, t, b)
	self.Paladin.Icon:SetPoint('CENTER', 0,155)
	self.Paladin.Icon:SetWidth(25)
	self.Paladin.Icon:SetHeight(25)
	
	-- Shaman
	local r, l, t, b = Rat:ClassPos("Shaman")
	self.Shaman = CreateFrame("Frame",nil,self.Background.Tab1) -- shaman class frame
	self.Shaman:SetWidth(125)
	self.Shaman:SetHeight(250)
	self.Shaman:SetPoint('TOPLEFT', 440, -70)
	self.Shaman:SetBackdrop(backdrop)
	self.Shaman:SetBackdropColor(0,0,0,1)
	self.Shaman.Icon = self.Shaman:CreateTexture(nil, 'ARTWORK')
	self.Shaman.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.Shaman.Icon:SetTexCoord(r, l, t, b)
	self.Shaman.Icon:SetPoint('CENTER', 0,155)
	self.Shaman.Icon:SetWidth(25)
	self.Shaman.Icon:SetHeight(25)
	
	-- Hunter
	local r, l, t, b = Rat:ClassPos("Hunter")
	self.Hunter = CreateFrame("Frame",nil,self.Background.Tab1) -- hunter class frame
	self.Hunter:SetWidth(125)
	self.Hunter:SetHeight(250)
	self.Hunter:SetPoint('TOPLEFT', 580, -70)
	self.Hunter:SetBackdrop(backdrop)
	self.Hunter:SetBackdropColor(0,0,0,1)
	self.Hunter.Icon = self.Hunter:CreateTexture(nil, 'ARTWORK')
	self.Hunter.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.Hunter.Icon:SetTexCoord(r, l, t, b)
	self.Hunter.Icon:SetPoint('CENTER', 0,155)
	self.Hunter.Icon:SetWidth(25)
	self.Hunter.Icon:SetHeight(25)
	
	-- Druid
	local r, l, t, b = Rat:ClassPos("Druid")
	self.Druid = CreateFrame("Frame",nil,self.Background.Tab1) -- druid class frame
	self.Druid:SetWidth(125)
	self.Druid:SetHeight(250)
	self.Druid:SetPoint('TOPLEFT', 720, -70)
	self.Druid:SetBackdrop(backdrop)
	self.Druid:SetBackdropColor(0,0,0,1)
	self.Druid.Icon = self.Druid:CreateTexture(nil, 'ARTWORK')
	self.Druid.Icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	self.Druid.Icon:SetTexCoord(r, l, t, b)
	self.Druid.Icon:SetPoint('CENTER', 0,155)
	self.Druid.Icon:SetWidth(25)
	self.Druid.Icon:SetHeight(25)

	-- checkboxes

	-- Warrior --
	
	-- Shield Wall
	local Checkbox = CreateFrame("CheckButton", "Shield Wall", self.Warrior, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,80)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Shield Wall"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Shield Wall"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Shield Wall"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Shield Wall"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Warrior:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Shield Wall")
	
	-- Challenging Shout
	local Checkbox = CreateFrame("CheckButton", "Challenging Shout", self.Warrior, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,35)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Challenging Shout"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Challenging Shout"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Challenging Shout"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Challenging Shout"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Warrior:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Challenging Shout")
	
	-- Berserker Rage
	local Checkbox = CreateFrame("CheckButton", "Berserker Rage", self.Warrior, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,-10)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Berserker Rage"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Berserker Rage"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Berserker Rage"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Berserker Rage"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Warrior:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Berserker Rage")
	
	-- Pummel
	local Checkbox = CreateFrame("CheckButton", "Pummel", self.Warrior, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,-55)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Pummel"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Pummel"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Pummel"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Pummel"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Warrior:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Pummel")
	
	-- Disarm
	local Checkbox = CreateFrame("CheckButton", "Disarm", self.Warrior, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,-100)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Disarm"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Disarm"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Disarm"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Disarm"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Warrior:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Disarm")
	
	-- Warlock
	
	-- Major Soulstone
	local Checkbox = CreateFrame("CheckButton", "Major Soulstone", self.Warlock, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,80)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Major Soulstone"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Major Soulstone"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Major Soulstone"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Major Soulstone"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Warlock:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Major Soulstone")
	
	-- Rogue
	
	-- Kick
	local Checkbox = CreateFrame("CheckButton", "Kick", self.Rogue, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,80)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Kick"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Kick"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Kick"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Kick"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Rogue:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Kick")
	
	-- Paladin

	-- Lay on Hands
	local Checkbox = CreateFrame("CheckButton", "Lay on Hands", self.Paladin, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,80)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Lay on Hands"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Lay on Hands"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Lay on Hands"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Lay on Hands"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Paladin:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Lay on Hands")
	
	-- Blessing of Protection
	local Checkbox = CreateFrame("CheckButton", "Blessing of Protection", self.Paladin, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,35)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Blessing of Protection"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Blessing of Protection"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Blessing of Protection"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Blessing of Protection"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Paladin:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Blessing of Protection")
	
	-- Divine Shield
	local Checkbox = CreateFrame("CheckButton", "Divine Shield", self.Paladin, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,-10)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Divine Shield"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Divine Shield"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Divine Shield"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Divine Shield"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Paladin:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Divine Shield")
	
	-- Divine Intervention
	local Checkbox = CreateFrame("CheckButton", "Divine Intervention", self.Paladin, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,-55)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Divine Intervention"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Divine Intervention"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Divine Intervention"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Divine Intervention"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Paladin:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Divine Intervention")
	
	-- Shaman
	
	-- Mana Tide Totem
	local Checkbox = CreateFrame("CheckButton", "Mana Tide Totem", self.Shaman, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,80)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Mana Tide Totem"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Mana Tide Totem"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Mana Tide Totem"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Mana Tide Totem"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Shaman:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Mana Tide Totem")
	
	-- Reincarnation
	local Checkbox = CreateFrame("CheckButton", "Reincarnation", self.Shaman, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,35)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Reincarnation"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Reincarnation"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Reincarnation"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Reincarnation"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Shaman:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Reincarnation")
	
	-- Hunter
	
	-- Tranquilizing Shot
	local Checkbox = CreateFrame("CheckButton", "Tranquilizing Shot", self.Hunter, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,80)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Tranquilizing Shot"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Tranquilizing Shot"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Tranquilizing Shot"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Tranquilizing Shot"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Hunter:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Tranquilizing Shot")
	
	-- Druid
	
	-- Innervate 
	local Checkbox = CreateFrame("CheckButton", "Innervate", self.Druid, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,80)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Innervate"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Innervate"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Innervate"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Innervate"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Druid:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Innervate")
	
	-- Rebirth
	local Checkbox = CreateFrame("CheckButton", "Rebirth", self.Druid, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,35)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Rebirth"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Rebirth"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Rebirth"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Rebirth"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Druid:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Rebirth")
	
	-- Challenging Roar
	local Checkbox = CreateFrame("CheckButton", "Challenging Roar", self.Druid, "UICheckButtonTemplate")
	Checkbox:SetPoint("CENTER",0,-10)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("LOW")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Challenging Roar"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Challenging Roar"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Challenging Roar"])
	local Icon = Checkbox:CreateTexture(nil, 'ARTWORK',1)
	Icon:SetTexture(cdtbl["Challenging Roar"])
	Icon:SetWidth(25)
	Icon:SetHeight(25)
	Icon:SetPoint("CENTER",0,0)
	local text = self.Druid:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", Checkbox, "CENTER", 0, 25)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Challenging Roar")
	
	-- icon
	self.Icon = self:CreateTexture(nil, 'ARTWORK')
	self.Icon:SetTexture("Interface\\AddOns\\Rat\\media\\icon.tga")
	self.Icon:SetPoint('TOPLEFT', -1, 4)
	self.Icon:SetWidth(50)
	self.Icon:SetHeight(50)
	
	-- title text
	local text = self.Background.Topmid:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", self, "CENTER", 0, 191)
    text:SetFont("Fonts\\FRIZQT__.TTF", 15)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Raid Ability Tracker v"..Rat_Version)
	
	-- options text
	local text = self.Background.Topmid:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER", self, "CENTER", 0, 165)
    text:SetFont("Fonts\\FRIZQT__.TTF", 25)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("OPTIONS")
	
	-- minimap option
	
	local Checkbox = CreateFrame("CheckButton", "Minimap", self.Background.Tab2, "UICheckButtonTemplate")
	Checkbox:SetPoint("TOPLEFT",70,-80)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("MEDIUM")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Minimap"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Minimap"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Turn on/off", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Minimap"])
	local text = Checkbox:CreateFontString(nil, "OVERLAY")
    text:SetPoint("LEFT", 45, 0)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Show minimap icon")
	
	-- notify option
	
	local Checkbox = CreateFrame("CheckButton", "Notify", self.Background.Tab2, "UICheckButtonTemplate")
	Checkbox:SetParent(self.Background.Tab2)
	Checkbox:SetPoint("TOPLEFT",70,-130)
	Checkbox:SetWidth(35)
	Checkbox:SetHeight(35)
	Checkbox:SetFrameStrata("MEDIUM")
	Checkbox:SetScript("OnClick", function () 
		if Checkbox:GetChecked() == nil then 
			Rat_Settings["Notify"] = nil
		elseif Checkbox:GetChecked() == 1 then 
			Rat_Settings["Notify"] = 1 
		end
		end)
	Checkbox:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(Checkbox, "ANCHOR_RIGHT");
		GameTooltip:SetText("Notify when abilites are ready", 255, 255, 0, 1, 1);
		GameTooltip:Show()
	end)
	Checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Checkbox:SetChecked(Rat_Settings["Notify"])
	local text = Checkbox:CreateFontString(nil, "OVERLAY")
    text:SetPoint("LEFT", 45, 0)
    text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	text:SetTextColor(1, 1, 1, 1)
	text:SetShadowOffset(2,-2)
    text:SetText("Ability notification")
	
	-- create close button
	self.CloseButton = CreateFrame("Button",nil,self,"UIPanelCloseButton")
	self.CloseButton:SetPoint("TOPLEFT",self:GetWidth()-23,2)
	self.CloseButton:SetWidth(24)
	self.CloseButton:SetHeight(24)
	self.CloseButton:SetFrameStrata('MEDIUM')
	
	--button
	
	self.version = CreateFrame("Button",nil,self,"UIPanelButtonTemplate")
	self.version:SetPoint("TOPRIGHT",-19,-1)
	self.version:SetWidth(89)
	self.version:SetHeight(16)
	self.version:SetText("Version Check")
	self.version:SetScript("OnClick", function() 
	PlaySound("igMainMenuOptionCheckBoxOn"); 
	if sendThrottle["versioncheck"] == nil or (GetTime() - sendThrottle["versioncheck"]) > 10 then
		SendAddonMessage("RATVERSIONCHECK",0,"RAID"); 
		Rat.Version:Show() 
		sendThrottle["versioncheck"] = GetTime()
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A Rat:|r Don't spam the check function!",1,1,1)
	end
	end)
	
	-- done button
	self.dbutton = CreateFrame("Button",nil,self,"UIPanelButtonTemplate")
	self.dbutton:SetPoint("BOTTOM",0,10)
	self.dbutton:SetFrameStrata("MEDIUM")
	self.dbutton:SetWidth(79)
	self.dbutton:SetHeight(18)
	self.dbutton:SetText("Done")
	self.dbutton:SetScript("OnClick", function() PlaySound("igMainMenuOptionCheckBoxOn"); Rat.Options:Hide() end)
	
	self:Hide()
end

-- dropdown functions

function Rat.Options:FontDrop()
	local info={}
	local i=1
	for k,v in pairs(Rat_Font) do
		info.text=v
		info.value=i
		info.func= function () UIDropDownMenu_SetSelectedID(Rat.Options.FontDropdown, this:GetID())
			Rat_Settings["font"] = this:GetID()
			Rat.Mainframe.Background.Top.Title:SetFont("Interface\\AddOns\\Rat\\fonts\\"..Rat_Font[Rat_Settings["font"]]..".TTF", Rat_FontSize[Rat_Settings["font"]]+1)
		end
		info.checked = nil
		info.checkable = nil
		UIDropDownMenu_AddButton(info, 1)
		i=i+1
	end
end

function Rat.Options:BarTextureDrop()
	local info={}
	local i=1
	for k,v in pairs(Rat_BarTexture) do
		info.text=v
		info.value=i
		info.func= function () UIDropDownMenu_SetSelectedID(Rat.Options.BarTextureDropdown, this:GetID())
			Rat_Settings["bartexture"] = this:GetID()
		end
		info.checked = nil
		info.checkable = nil
		UIDropDownMenu_AddButton(info, 1)
		i=i+1
	end
end

-- function that creates the cooldown bars that will be shown in the Rat window

function Rat:CreateFrame(name)
	local frame = CreateFrame('Button', name, Rat.Mainframe.Background.Tab1)
	frame:SetBackdrop({ bgFile=[[Interface/Tooltips/UI-Tooltip-Background]] })
	frame:SetBackdropColor(0,0,0,1)
	frame.unit = frame:CreateTexture(nil, 'ARTWORK')
	frame.unit:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	frame.unit:SetWidth(60)
	frame.unit:SetHeight(20)
	frame.unit:SetPoint('TOPLEFT', 1, -1)
	frame.unit:SetTexture("Interface/TargetingFrame/UI-StatusBar")
	frame.unitname = frame:CreateFontString(nil, "ARTWORK")
	frame.unitname:SetPoint("LEFT", frame.unit, "LEFT", 2, 0)
	frame.unitname:SetFont("Fonts\\FRIZQT__.TTF", 10)
	frame.unitname:SetTextColor(255, 255, 255, 1)
	frame.unitname:SetShadowOffset(2,-2)
	frame.unitname:SetText("Name")
	frame.icon = frame:CreateTexture(nil, 'OVERLAY')
	frame.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	frame.icon:SetWidth(20)
	frame.icon:SetHeight(20)
	frame.icon:SetPoint('TOPLEFT', 62, -1)
	frame.bar = frame:CreateTexture(nil, 'ARTWORK')
	frame.bar:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	frame.bar:SetWidth(20)
	frame.bar:SetHeight(20)
	frame.bar:SetPoint('TOPLEFT', 83, -1)
	frame.bar:SetTexture(Rat_Settings["abilitybarcolor"]["r"],Rat_Settings["abilitybarcolor"]["g"],Rat_Settings["abilitybarcolor"]["b"],1)
	frame.timer = frame:CreateFontString(nil, "OVERLAY")
	frame.timer:SetPoint("LEFT", frame, "LEFT", 90, 0)
	frame.timer:SetFont("Fonts\\FRIZQT__.TTF", 10)
	frame.timer:SetTextColor(Rat_Settings["abilitytextcolor"]["r"],Rat_Settings["abilitytextcolor"]["g"],Rat_Settings["abilitytextcolor"]["b"], 1)
	frame.timer:SetShadowOffset(2,-2)
	frame.timer:SetText("1")
	frame.time = frame:CreateFontString(nil, "OVERLAY")
	frame.time:SetPoint("RIGHT", frame, "RIGHT", -5, 0)
	frame.time:SetFont("Fonts\\FRIZQT__.TTF", 11)
	frame.time:SetTextColor(Rat_Settings["abilitytextcolor"]["r"],Rat_Settings["abilitytextcolor"]["g"],Rat_Settings["abilitytextcolor"]["b"], 1)
	frame.time:SetShadowOffset(2,-2)
	frame.time:SetText("1")
	frame.barglow = CreateFrame('Button', "glow", frame)
	frame.barglow:SetWidth(2)
	frame.barglow:SetHeight(20)
	frame.barglow.d = frame.barglow:CreateTexture(nil, "BORDER")
	frame.barglow.d:SetWidth(4)
	frame.barglow.d:SetHeight(20)
	frame.barglow.d:SetTexture(1, 1, 1, 0.7)
	frame.barglow.d:SetGradientAlpha("Horizontal", 1, 1, 1, 0, 1, 1, 1, 0.8)
	frame.barglow.u = frame.barglow:CreateTexture(nil, "BORDER")
	frame.barglow.u:SetWidth(4)
	frame.barglow.u:SetHeight(20)
	frame.barglow.u:SetTexture(1, 1, 1, 0.7)
	frame.barglow.u:SetGradientAlpha("Horizontal", 1, 1, 1, 0.8, 1, 1, 1, 0)
	frame.barglow.d:SetPoint("CENTER", -2, 0)
	frame.barglow.u:SetPoint("CENTER", 2, 0)
	frame:SetScript("OnClick", function()
		local playername = frame.unitname:GetText()
		local cooldowntimer = frame.time:GetText()
		local cooldownName = frame.timer:GetText()
		Rat:msg(playername.." has "..cooldowntimer.." cooldown left on ["..cooldownName.."]")
	end)
	return frame
end

-- minimap

function Rat.Minimap:CreateMinimapIcon()
	local Moving = false
	
	function self:OnMouseUp()
		Moving = false;
	end
	
	function self:OnMouseDown()
		PlaySound("igMainMenuOptionCheckBoxOn")
		Moving = false;
		if (arg1 == "LeftButton") then 
			if Rat.Mainframe:IsVisible() then 
				Rat.Mainframe:Hide()
				Rat_Settings["showhide"] = 0
			else 
				Rat.Mainframe:Show() 
				Rat_Settings["showhide"] = 1
			end
		elseif (arg1 == "RightButton") then
			if Rat.Options:IsVisible() then Rat.Options:Hide()
			else Rat.Options:Show() end
		else Moving = true;
		end
	end
	
	function self:OnUpdate()
		if Moving == true then
			local xpos,ypos = GetCursorPosition();
			local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom();
			xpos = xmin-xpos/UIParent:GetScale()+70;
			ypos = ypos/UIParent:GetScale()-ymin-70;
			local RATIconPos = math.deg(math.atan2(ypos,xpos));
			if (RATIconPos < 0) then
				RATIconPos = RATIconPos + 360
			end
			Rat_Settings["MinimapX"] = 54 - (78 * cos(RATIconPos));
			Rat_Settings["MinimapY"] = (78 * sin(RATIconPos)) - 55;
			
			Rat.Minimap:SetPoint(
			"TOPLEFT",
			"Minimap",
			"TOPLEFT",
			Rat_Settings["MinimapX"],
			Rat_Settings["MinimapY"]);
		end
	end
	
	function self:OnEnter()
		GameTooltip:SetOwner(Rat.Minimap, "ANCHOR_LEFT");
		GameTooltip:SetText("Raid Ability Tracker");
		GameTooltip:AddLine("Left Click to show/hide RAT.",1,1,1);
		GameTooltip:AddLine("Right Click to show/hide options menu.",1,1,1);
		GameTooltip:AddLine("Middle Button Click to move Icon.",1,1,1);
		GameTooltip:Show()
	end
	
	function self:OnLeave()
		GameTooltip:Hide()
	end

	self:SetFrameStrata("LOW")
	self:SetWidth(31) -- Set these to whatever height/width is needed 
	self:SetHeight(31) -- for your Texture
	self:SetPoint("CENTER", -75, -20)
	
	self.Button = CreateFrame("Button",nil,self)
	self.Button:SetPoint("CENTER",0,0)
	self.Button:SetWidth(31)
	self.Button:SetHeight(31)
	self.Button:SetFrameLevel(8)
	self.Button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	self.Button:SetScript("OnMouseUp", self.OnMouseUp)
	self.Button:SetScript("OnMouseDown", self.OnMouseDown)
	self.Button:SetScript("OnUpdate", self.OnUpdate)
	self.Button:SetScript("OnEnter", self.OnEnter)
	self.Button:SetScript("OnLeave", self.OnLeave)
	
	local overlay = self:CreateTexture(nil, 'OVERLAY',self)
	overlay:SetWidth(53)
	overlay:SetHeight(53)
	overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	overlay:SetPoint('TOPLEFT',0,0)
	
	local icon = self:CreateTexture(nil, "BACKGROUND")
	icon:SetWidth(20)
	icon:SetHeight(20)
	icon:SetTexture("Interface\\AddOns\\Rat\\Media\\Icon")
	icon:SetTexCoord(0.18, 0.82, 0.18, 0.82)
	icon:SetPoint('CENTER', 0, 0)
	self.icon = icon
	
	Rat.Minimap:SetPoint(
			"TOPLEFT",
			"Minimap",
			"TOPLEFT",
			Rat_Settings["MinimapX"],
			Rat_Settings["MinimapY"])

end

-- Color picker functions

function Rat:SetColor()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	frame = getglobal(RAT_CP_OBJ:GetName());      -- enregistre la couleur
	frame.r = r;
	frame.g = g;
	frame.b = b;
	
	if RAT_CP_TYPE == "topbarcolor" then
		topbg:SetTexture(r,g,b)
		topbg:SetGradientAlpha("Vertical", 1,1,1, 0.25, 1, 1, 1, 1)
		Rat.Options.Background.topbarcolor.Texture:SetTexture(r,g,b)
		Rat_Settings[RAT_CP_TYPE]["r"] = r
		Rat_Settings[RAT_CP_TYPE]["g"] = g
		Rat_Settings[RAT_CP_TYPE]["b"] = b
	elseif RAT_CP_TYPE == "abilitybarcolor" then
		Rat.Options.Background.abilitybarcolor.Texture:SetTexture(r,g,b)
		Rat_Settings[RAT_CP_TYPE]["r"] = r
		Rat_Settings[RAT_CP_TYPE]["g"] = g
		Rat_Settings[RAT_CP_TYPE]["b"] = b	
	elseif RAT_CP_TYPE == "abilitytextcolor" then
		Rat.Options.Background.abilitytextcolor.Texture:SetTexture(r,g,b)
		Rat_Settings[RAT_CP_TYPE]["r"] = r
		Rat_Settings[RAT_CP_TYPE]["g"] = g
		Rat_Settings[RAT_CP_TYPE]["b"] = b	
	end
end

function Rat:CancelColor()
	local r = ColorPickerFrame.previousValues.r;
	local g = ColorPickerFrame.previousValues.g;
	local b = ColorPickerFrame.previousValues.b;
	local swatch,frame;

	frame = getglobal(RAT_CP_OBJ:GetName());      -- enregistre la couleur

	frame.r = r;
	frame.g = g;
	frame.b = b;

	if RAT_CP_TYPE == "topbarcolor" then
		topbg:SetTexture(r,g,b)
		topbg:SetGradientAlpha("Vertical", 1,1,1, 0.25, 1, 1, 1, 1)
		Rat.Options.Background.topbarcolor.Texture:SetTexture(r,g,b)
		Rat_Settings[RAT_CP_TYPE]["r"] = r
		Rat_Settings[RAT_CP_TYPE]["g"] = g
		Rat_Settings[RAT_CP_TYPE]["b"] = b
	elseif RAT_CP_TYPE == "abilitybarcolor" then
		Rat.Options.Background.abilitybarcolor.Texture:SetTexture(r,g,b)
		Rat_Settings[RAT_CP_TYPE]["r"] = r
		Rat_Settings[RAT_CP_TYPE]["g"] = g
		Rat_Settings[RAT_CP_TYPE]["b"] = b	
	elseif RAT_CP_TYPE == "abilitytextcolor" then
		Rat.Options.Background.abilitytextcolor.Texture:SetTexture(r,g,b)
		Rat_Settings[RAT_CP_TYPE]["r"] = r
		Rat_Settings[RAT_CP_TYPE]["g"] = g
		Rat_Settings[RAT_CP_TYPE]["b"] = b	
	end
end

function Rat:OpenColorPicker(obj, type)
	RAT_CP_OBJ = obj
	RAT_CP_TYPE = type

	button = getglobal(obj:GetName());

	ColorPickerFrame.func = Rat.SetColor -- button.swatchFunc;
	ColorPickerFrame:SetColorRGB(Rat_Settings[RAT_CP_TYPE]["r"], Rat_Settings[RAT_CP_TYPE]["g"], Rat_Settings[RAT_CP_TYPE]["b"]);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = Rat.CancelColor

	ColorPickerFrame:SetPoint("TOPLEFT", obj, "TOPRIGHT", 0, 0)

	ColorPickerFrame:Show();
end

-- hypelink conversion to text

function Rat:hyperlink_name(hyperlink)
    local _, _, name = strfind(hyperlink, '|Hitem:%d+:%d+:%d+:%d+|h[[]([^]]+)[]]|h')
    return name
end

-- function to get chat type (say,party,raid,whisper)

function Rat:msg(text)
	local channel, chatnumber = ChatFrameEditBox.chatType
	if channel == "WHISPER" then
		chatnumber = ChatFrameEditBox.tellTarget
	elseif channel == "CHANNEL" then
		chatnumber = ChatFrameEditBox.channelTarget
	end
	SendChatMessage(text, channel, nil, chatnumber)
end

-- functions to list all abilities on cooldown into our table

function getInvCd()
	if RatTbl[Rat_unit] == nil then RatTbl[Rat_unit] = { } end
    for rbag = 0,4 do
        if GetBagName(rbag) then
            for rslot = 1, GetContainerNumSlots(rbag) do
				local s_time, duration, enabled = GetContainerItemCooldown(rbag, rslot)
				if enabled == 1 then
					local name = Rat:hyperlink_name(GetContainerItemLink(rbag, rslot))
					for i,_ in pairs(cdtbl) do
						if i == name then
							if RatTbl[Rat_unit][i] == nil then RatTbl[Rat_unit][i] = { } end
							if duration > 2.5 then
								local timeleft = duration-(GetTime()-s_time)
								if (duration-math.floor(timeleft)) == 0 then
									SendAddonMessage("RATSYNC["..duration.."]("..i..")",timeleft,"RAID")
									RatTbl[Rat_unit][i]["duration"] = timeleft+GetTime()
									RatTbl[Rat_unit][i]["cd"] = duration
									sendThrottle[i] = GetTime()
								end
								if sendThrottle[i] == nil or (GetTime() - sendThrottle[i]) > 10 then
									SendAddonMessage("RATSYNC["..duration.."]("..i..")",timeleft,"RAID")
									RatTbl[Rat_unit][i]["duration"] = timeleft+GetTime()
									RatTbl[Rat_unit][i]["cd"] = duration
									sendThrottle[i] = GetTime()
								end
							elseif duration == 0 then
								RatTbl[Rat_unit][name]["duration"] = 0
							end
						end
					end
				end
			end
		end
	end
end

function getSpells()
	local spellID = 1
	local spell = GetSpellName(spellID, BOOKTYPE_SPELL)
	if RatTbl[Rat_unit] == nil then RatTbl[Rat_unit] = { } end
	while (spell) do
		local start, duration, hasCooldown = GetSpellCooldown(spellID, BOOKTYPE_SPELL)
		for i,v in pairs(cdtbl) do
			if i == spell then
				if RatTbl[Rat_unit][spell] == nil then RatTbl[Rat_unit][spell] = { } end
				if hasCooldown == 1 and duration > 2.5 then
					local timeleft = duration-(GetTime()-start)
						RatTbl[Rat_unit][spell]["duration"] = timeleft+GetTime()
						RatTbl[Rat_unit][spell]["cd"] = duration
				else
					RatTbl[Rat_unit][spell]["duration"] = 0
				end
			end
		end
			
		spellID = spellID + 1
		spell = GetSpellName(spellID, BOOKTYPE_SPELL)
	end
end

-- function to send our cooldowns to the raid

function sendCds()
		local spellID = 1
		local spell = GetSpellName(spellID, BOOKTYPE_SPELL)
		if RatTbl[Rat_unit] == nil then RatTbl[Rat_unit] = { } end
		while (spell) do
			local start, duration, hasCooldown = GetSpellCooldown(spellID, BOOKTYPE_SPELL)
			for i,_ in pairs(RatTbl[Rat_unit]) do
				if i == spell then
				
					if hasCooldown == 1 and duration > 2.5 then
					local timeleft = duration-(GetTime()-start)
						if (RatTbl[Rat_unit][i]["cd"]-math.floor(timeleft)) == 0 then
							SendAddonMessage("RATSYNC["..duration.."]("..i..")",timeleft,"RAID")
							sendThrottle[i] = GetTime()
						end
						if sendThrottle[i] == nil or (GetTime() - sendThrottle[i]) > 10 then
							SendAddonMessage("RATSYNC["..duration.."]("..i..")",timeleft,"RAID")
							sendThrottle[i] = GetTime()
						end
					else
					end
				end
			end		
			spellID = spellID + 1
			spell = GetSpellName(spellID, BOOKTYPE_SPELL)
		end
	if sendThrottle["Major Soulstone"] == nil or (GetTime() - sendThrottle["Major Soulstone"]) > 10 then
		if (RatTbl[Rat_unit]["Major Soulstone"]) then
			if RatTbl[Rat_unit]["Major Soulstone"]["duration"]-GetTime() > 0 then
				SendAddonMessage("RATSYNC["..RatTbl[Rat_unit]["Major Soulstone"]["cd"].."](Major Soulstone)",RatTbl[Rat_unit]["Major Soulstone"]["duration"]-GetTime(),"RAID")
			else
			end
			sendThrottle["Major Soulstone"] = GetTime()
		end
	end
	sendAddMsg = GetTime()
end

-- add an ability cooldown we got from a raidmember

function Rat:AddCd(name,cdname,cd,duration)
	if RatTbl[name] == nil then RatTbl[name] = {} end
	if RatTbl[name][cdname] == nil then RatTbl[name][cdname] = {} end
	RatTbl[name][cdname]["duration"] = duration+GetTime()
	RatTbl[name][cdname]["cd"] = cd
	Rat:Update()
end

-- function to check if a player is still in raid

function Rat:InRaidCheck(name)
	if GetRaidRosterInfo(1) then
		for i=1,GetNumRaidMembers() do
			if name == UnitName("raid"..i) then
				return true
			end
		end
		return false
	end
end

-- function to clear our database, we don't want cooldowns from people not in raid.

function Rat:Cleardb()
	if GetRaidRosterInfo(1) then
		for name,_ in pairs(RatTbl) do
			if name ~= UnitName("player") and not Rat:InRaidCheck(name) then
				for ability, dura in pairs(RatTbl[name]) do
					local rframe = name..ability
					RatFrames[rframe]:Hide()
				end
				RatTbl[name]=nil
			end
		end
	else
		for name,_ in pairs(RatTbl) do
			if name ~= UnitName("player") then
				for ability, dura in pairs(RatTbl[name]) do
					local rframe = name..ability
					RatFrames[rframe]:Hide()
				end
				RatTbl[name]=nil
			end
		end
	end
end

-- hides version frames for players not in raid anymore for our version check frame

function Rat:HideVersionNameFrames()
	if GetRaidRosterInfo(1) then
		for name,frame in pairs(VersionFTbl) do
			if name ~= UnitName("player") and not Rat:InRaidCheck(name) then
				frame:Hide()
				RatVersionTbl[name] = nil
			end
		end
	else
		for name,frame in pairs(VersionFTbl) do
			if name ~= UnitName("player") then
				frame:Hide()
				RatVersionTbl[name] = nil
			end
		end
	end
	Rat.Version:Check()
end

-- function to get classcolors from a player

function Rat:GetClassColors(name)
	if name == UnitName("player") then
		if UnitClass("player") == "Warrior" then return 0.78, 0.61, 0.43,1
		elseif UnitClass("player") == "Hunter" then return 0.67, 0.83, 0.45
		elseif UnitClass("player") == "Mage" then return 0.41, 0.80, 0.94
		elseif UnitClass("player") == "Rogue" then return 1.00, 0.96, 0.41
		elseif UnitClass("player") == "Warlock" then return 0.58, 0.51, 0.79,1
		elseif UnitClass("player") == "Druid" then return 1, 0.49, 0.04,1
		elseif UnitClass("player") == "Shaman" then return 0.0, 0.44, 0.87	
		elseif UnitClass("player") == "Priest" then return 1.00, 1.00, 1.00
		elseif UnitClass("player") == "Paladin" then return 0.96, 0.55, 0.73
		end
	end
	if GetRaidRosterInfo(1) then
		for i=1,GetNumRaidMembers() do
			if UnitName("raid"..i) == name then
				if UnitClass("raid"..i) == "Warrior" then return 0.78, 0.61, 0.43,1
				elseif UnitClass("raid"..i) == "Hunter" then return 0.67, 0.83, 0.45
				elseif UnitClass("raid"..i) == "Mage" then return 0.41, 0.80, 0.94
				elseif UnitClass("raid"..i) == "Rogue" then return 1.00, 0.96, 0.41
				elseif UnitClass("raid"..i) == "Warlock" then return 0.58, 0.51, 0.79,1
				elseif UnitClass("raid"..i) == "Druid" then return 1, 0.49, 0.04,1
				elseif UnitClass("raid"..i) == "Shaman" then return 0.0, 0.44, 0.87	
				elseif UnitClass("raid"..i) == "Priest" then return 1.00, 1.00, 1.00
				elseif UnitClass("raid"..i) == "Paladin" then return 0.96, 0.55, 0.73
				end
			end
		end
	end
end

function Rat_GetClassColors(name)
	if name == UnitName("player") then
		if UnitClass("player") == "Warrior" then return "|cffC79C6E"..name.."|r"
		elseif UnitClass("player") == "Hunter" then return "|cffABD473"..name.."|r"
		elseif UnitClass("player") == "Mage" then return "|cff69CCF0"..name.."|r"
		elseif UnitClass("player") == "Rogue" then return "|cffFFF569"..name.."|r"
		elseif UnitClass("player") == "Warlock" then return "|cff9482C9"..name.."|r"
		elseif UnitClass("player") == "Druid" then return "|cffFF7D0A"..name.."|r"
		elseif UnitClass("player") == "Shaman" then return "|cff0070DE"..name.."|r"
		elseif UnitClass("player") == "Priest" then return "|cffFFFFFF"..name.."|r"
		elseif UnitClass("player") == "Paladin" then return "|cffF58CBA"..name.."|r"
		end
	end
	if GetRaidRosterInfo(1) then
		for i=1,GetNumRaidMembers() do
			if UnitName("raid"..i) == name then
				if UnitClass("raid"..i) == "Warrior" then return "|cffC79C6E"..name.."|r"
				elseif UnitClass("raid"..i) == "Hunter" then return "|cffABD473"..name.."|r"
				elseif UnitClass("raid"..i) == "Mage" then return "|cff69CCF0"..name.."|r"
				elseif UnitClass("raid"..i) == "Rogue" then return "|cffFFF569"..name.."|r"
				elseif UnitClass("raid"..i) == "Warlock" then return "|cff9482C9"..name.."|r"
				elseif UnitClass("raid"..i) == "Druid" then return "|cffFF7D0A"..name.."|r"
				elseif UnitClass("raid"..i) == "Shaman" then return "|cff0070DE"..name.."|r"
				elseif UnitClass("raid"..i) == "Priest" then return "|cffFFFFFF"..name.."|r"
				elseif UnitClass("raid"..i) == "Paladin" then return "|cffF58CBA"..name.."|r"
				end
			end
		end
	else
		for i=1,GetNumPartyMembers() do
			if UnitName("party"..i) == name then
				if UnitClass("party"..i) == "Warrior" then return "|cffC79C6E"..name.."|r"
				elseif UnitClass("party"..i) == "Hunter" then return "|cffABD473"..name.."|r"
				elseif UnitClass("party"..i) == "Mage" then return "|cff69CCF0"..name.."|r"
				elseif UnitClass("party"..i) == "Rogue" then return "|cffFFF569"..name.."|r"
				elseif UnitClass("party"..i) == "Warlock" then return "|cff9482C9"..name.."|r"
				elseif UnitClass("party"..i) == "Druid" then return "|cffFF7D0A"..name.."|r"
				elseif UnitClass("party"..i) == "Shaman" then return "|cff0070DE"..name.."|r"
				elseif UnitClass("party"..i) == "Priest" then return "|cffFFFFFF"..name.."|r"
				elseif UnitClass("party"..i) == "Paladin" then return "|cffF58CBA"..name.."|r"
				end
			end
		end
	end
end

-- function to get class of a player

function Rat:GetClass(name)
	if name == UnitName("player") then
		if UnitClass("player") == "Warrior" then return "Warrior"
		elseif UnitClass("player") == "Hunter" then return "Hunter"
		elseif UnitClass("player") == "Mage" then return "Mage"
		elseif UnitClass("player") == "Rogue" then return "Rogue"
		elseif UnitClass("player") == "Warlock" then return "Warlock"
		elseif UnitClass("player") == "Druid" then return "Druid"
		elseif UnitClass("player") == "Shaman" then return "Shaman"
		elseif UnitClass("player") == "Priest" then return "Priest"
		elseif UnitClass("player") == "Paladin" then return "Paladin"
		end
	end
	if GetRaidRosterInfo(1) then
		for i=1,GetNumRaidMembers() do
			if UnitName("raid"..i) == name then
				if UnitClass("raid"..i) == "Warrior" then return "Warrior"
				elseif UnitClass("raid"..i) == "Hunter" then return "Hunter"
				elseif UnitClass("raid"..i) == "Mage" then return "Mage"
				elseif UnitClass("raid"..i) == "Rogue" then return "Rogue"
				elseif UnitClass("raid"..i) == "Warlock" then return "Warlock"
				elseif UnitClass("raid"..i) == "Druid" then return "Druid"
				elseif UnitClass("raid"..i) == "Shaman" then return "Shaman"
				elseif UnitClass("raid"..i) == "Priest" then return "Priest"
				elseif UnitClass("raid"..i) == "Paladin" then return "Paladin"
				end
			end
		end
	end
end

-- function to get correct coords for classes in the 

function Rat:ClassPos(class)
	if(class=="Warrior") then return 0, 0.25, 0, 0.25;	end
	if(class=="Mage")    then return 0.25, 0.5, 0,	0.25;	end
	if(class=="Rogue")   then return 0.5,  0.75,    0,	0.25;	end
	if(class=="Druid")   then return 0.75, 1,       0,	0.25;	end
	if(class=="Hunter")  then return 0,    0.25,    0.25,	0.5;	end
	if(class=="Shaman")  then return 0.25, 0.5,     0.25,	0.5;	end
	if(class=="Priest")  then return 0.5,  0.75,    0.25,	0.5;	end
	if(class=="Warlock") then return 0.75, 1,       0.25,	0.5;	end
	if(class=="Paladin") then return 0,    0.25,    0.5,	0.75;	end
	return 0.25, 0.5, 0.5, 0.75	-- Returns empty next one, so blank
end

-- update function

function Rat:Update(force)
	if uptimer == nil or (GetTime() - uptimer > 0.1) then
		uptimer = GetTime()	
	if Rat_Settings["showhide"] == 1 then
		Rat.Mainframe:Show()
	else
		Rat.Mainframe:Hide()
	end
	if UnitFactionGroup("player") == "Alliance" then
		if not Rat.Mainframe.PaladinFrame:IsVisible() then
			Rat.Mainframe.PaladinFrame:Show()
		end
		if not Rat.Options.Paladin:IsVisible() then
			Rat.Options.Paladin:Show()
		end
		if Rat.Mainframe.ShamanFrame:IsVisible() then
			Rat.Mainframe.ShamanFrame:Hide()
		end
		if Rat.Options.Shaman:IsVisible() then
			Rat.Options.Shaman:Hide()
		end
	elseif UnitFactionGroup("player") == "Horde"  then
		if not Rat.Mainframe.ShamanFrame:IsVisible() then		
			Rat.Mainframe.ShamanFrame:Show()
		end
		if not Rat.Options.Shaman:IsVisible() then
			Rat.Options.Shaman:Show()
		end
		if Rat.Mainframe.PaladinFrame:IsVisible() then
			Rat.Mainframe.PaladinFrame:Hide()
		end
		if Rat.Options.Paladin:IsVisible()  then
			Rat.Options.Paladin:Hide()
		end
	end
	if Rat_Settings["Minimap"] == nil then
		Rat.Minimap:Hide()
	elseif Rat_Settings["Minimap"] == 1 then
		Rat.Minimap:Show()
	end
	if IsRaidOfficer("player") then
		Rat.Options.version:Show()
	elseif not IsRaidOfficer("player") then
		Rat.Options.version:Hide()
	end
		_i =  0
		Rat_sorted = sortDB(name)
		for _, skey in ipairs(Rat_sorted) do
			for name,_ in pairs(RatTbl) do
				for ability, _ in pairs(RatTbl[name]) do
					if RatTbl[name][ability]["duration"] == skey and RatTbl[name][ability]["cd"] ~= nil then 
						local tname = name..ability
						local texture = cdtbl[ability]
						local bardecay = 1-((RatTbl[name][ability]["cd"]-(RatTbl[name][ability]["duration"]-GetTime())) / RatTbl[name][ability]["cd"])
						local cdtime = rtime(RatTbl[name][ability]["duration"]-GetTime())
						if bardecay > 1 then
							bardecay = 1
						end
						if cdtime == nil then cdtime = 0 end
						RatFrames[tname] = RatFrames[tname] or Rat:CreateFrame(tname)
						local frame = RatFrames[tname]
						Rat.Mainframe.Background.Top.Title:SetFont("Interface\\AddOns\\Rat\\fonts\\"..Rat_Font[Rat_Settings["font"]]..".TTF", Rat_FontSize[Rat_Settings["font"]]+1)
						frame:SetWidth(Rat.Mainframe:GetWidth()-4)
						frame:SetHeight(22)
						frame:SetPoint("TOPLEFT",2,(-22*_i)+(-2))
						frame.unit:SetTexture(Rat:GetClassColors(name))
						frame.unit:SetGradientAlpha("Vertical", 1,1,1, 0, 1, 1, 1, 1)
						frame.unitname:SetText(name)
						frame.unitname:SetFont("Interface\\AddOns\\Rat\\fonts\\"..Rat_Font[Rat_Settings["font"]]..".TTF", Rat_FontSize[Rat_Settings["font"]])
						frame.icon:SetTexture(texture)
						frame.bar:SetWidth(bardecay*(Rat.Mainframe:GetWidth()-89))
						frame.bar:SetTexture("Interface\\AddOns\\Rat\\media\\bartextures\\"..Rat_BarTexture[Rat_Settings["bartexture"]]..".tga",true)	
						frame.bar:SetVertexColor(Rat_Settings["abilitybarcolor"]["r"],Rat_Settings["abilitybarcolor"]["g"],Rat_Settings["abilitybarcolor"]["b"],1)
						frame.timer:SetTextColor(Rat_Settings["abilitytextcolor"]["r"],Rat_Settings["abilitytextcolor"]["g"],Rat_Settings["abilitytextcolor"]["b"])
						frame.time:SetTextColor(Rat_Settings["abilitytextcolor"]["r"],Rat_Settings["abilitytextcolor"]["g"],Rat_Settings["abilitytextcolor"]["b"])
						if Rat_Settings["Notify"] == 1 and Rat_Settings[Rat:GetClass(name)] == 1 and Rat_Settings[ability] == 1 and math.floor(RatTbl[name][ability]["duration"]-GetTime()) == 0 then
							if Rat_Settings[tname] == nil or (GetTime()-Rat_Settings[tname]) > 2 or (GetTime()-Rat_Settings[tname]) < 0 then
								UIErrorsFrame:AddMessage(Rat_GetClassColors(name).." |cffFFFF00"..ability.." - READY!")
								Rat_Settings[tname] = GetTime()
							end
						end
						if cdtime ~= 0 then
							frame.timer:SetText(ability)
							frame.time:SetText(cdtime)
							frame.timer:SetFont("Interface\\AddOns\\Rat\\fonts\\"..Rat_Font[Rat_Settings["font"]]..".TTF", Rat_FontSize[Rat_Settings["font"]])
							frame.time:SetFont("Interface\\AddOns\\Rat\\fonts\\"..Rat_Font[Rat_Settings["font"]]..".TTF", Rat_FontSize[Rat_Settings["font"]])
						end
						if bardecay*(Rat.Mainframe:GetWidth()-89) > 0 then
							frame.barglow:SetPoint("RIGHT", -(Rat.Mainframe:GetWidth()-88)+(bardecay*(Rat.Mainframe:GetWidth()-89)),0)
							frame.barglow:Show()
							if Rat_Settings[Rat:GetClass(name)] == 1 then
								if Rat_Settings[ability] == 1 then
									frame:Show()
									_i = _i+1
									Rat.Mainframe:SetHeight(22+(22*_i))
									Rat.Mainframe.Background.Tab1:SetHeight(Rat.Mainframe:GetHeight()-16)
								else
									Rat.Mainframe:SetHeight(22+(22*_i))
									Rat.Mainframe.Background.Tab1:SetHeight(Rat.Mainframe:GetHeight()-16)
									frame:Hide()
								end
							else
								Rat.Mainframe:SetHeight(22+(22*_i))
								Rat.Mainframe.Background.Tab1:SetHeight(Rat.Mainframe:GetHeight()-16)
								frame:Hide()
							end
						else
							frame.barglow:Hide()
							frame:Hide()
						end
					end
				end
			end
		end
		if _i == 0 then
			Rat.Mainframe:SetHeight(22+(22*1))
			Rat.Mainframe.Background.Tab1:SetHeight(Rat.Mainframe:GetHeight()-16)		
		end
	end
end

-- slash commands

function Rat.slash(arg1,arg2,arg3)
	if arg1 == nil or arg1 == "" then
		DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A Rat:|r type |cFFFFFF00 /Rat show|r to show frame",1,1,1)
		DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A Rat:|r type |cFFFFFF00 /Rat hide|r to hide frame",1,1,1)
		DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A Rat:|r type |cFFFFFF00 /Rat options|r to show options menu",1,1,1)
		else
		if arg1 == "show" then
			Rat_Settings["showhide"] = 1
			Rat.Mainframe:Show()
		elseif arg1 == "hide" then
			Rat_Settings["showhide"] = 0
			Rat.Mainframe:Hide()
		elseif arg1 == "options" then
			Rat.Options:Show()
		else
			DEFAULT_CHAT_FRAME:AddMessage(arg1)
			DEFAULT_CHAT_FRAME:AddMessage("|cFFF5F54A Rat:|r unknown command",1,0.3,0.3);
		end
	end
end

SlashCmdList['RAT_SLASH'] = Rat.slash
SLASH_RAT_SLASH1 = '/rat'
SLASH_RAT_SLASH2 = '/RAT'

-- call events

Rat:SetScript("OnEvent", Rat.OnEvent)
Rat:SetScript("OnUpdate", Rat.Update)

-- sort function for our database

function sortDB()
	local sortedKeys = { }
	for k, v in pairs(RatTbl) do 
		for l, _ in pairs(RatTbl[k]) do
		table.insert(sortedKeys, RatTbl[k][l]["duration"]) 
		end
	end
	table.sort(sortedKeys, function(a,b) return a>b end)
	return sortedKeys
end

function Rat:Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage("RAT: "..msg)
end

-- function to format time into 00:00

function rtime(left)
	local min = math.floor(left / 60)
	local sec = math.floor(math.mod(left, 60))

	if (this.min == min and this.sec == sec) then
		return nil
	end

	this.min = min
	this.sec = sec

	return string.format("%02d:%02s", min, sec)
end