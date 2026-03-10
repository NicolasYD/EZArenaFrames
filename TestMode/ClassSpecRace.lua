local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

EZArenaFrames.classIDs = {

	-- Warrior
	[1] = {
		specIDs = {
			71, -- Arms
			72, -- Fury
			73, -- Protection
		},
		raceIDs = {
			1, -- Human
			2, -- Orc
			3, -- Dwarf
			4, -- Night Elf
			5, -- Undead
			6, -- Tauren
			7, -- Gnome
			8, -- Troll
			9, -- Goblin
			10, -- Blood Elf
			11, -- Draenei
			22, -- Worgen
			25, -- Pandaren (Alliance)
			26, -- Pandaren (Horde)
			27, -- Nightborne
			28, -- Highmountain Tauren
			29, -- Void Elf
			30, -- Lightforged Draenei
			31, -- Zandalari Troll
			32, -- Kul Tiran
			34, -- Dark Iron Dwarf
			35, -- Vulpera
			36, -- Mag'har Orc
			37, -- Mechagnome
			52, -- Dracthyr (Alliance)
			70, -- Dracthyr (Horde)
			84, -- Earthen (Horde)
			85, -- Earthen (Alliance)
			86, -- Haranir (Alliance)
			91, -- Haranir (Horde)
		},
	},

	-- Paladin
	[2] = {
		specIDs = {
			65, -- Holy
			66, -- Protection
			70, -- Retribution
		},
		raceIDs = {
			1, -- Human
			3, -- Dwarf
			6, -- Tauren
			8, -- Troll
			10, -- Blood Elf
			11, -- Draenei
			30, -- Lightforged Draenei
			31, -- Zandalari Troll
			34, -- Dark Iron Dwarf
			84, -- Earthen (Horde)
			85, -- Earthen (Alliance)
		},
	},

	-- Hunter
	[3] = {
		specIDs = {
			253, -- Beast Mastery
			254, -- Marksmanship
			255, -- Survival
		},
		raceIDs = {
			1, -- Human
			2, -- Orc
			3, -- Dwarf
			4, -- Night Elf
			5, -- Undead
			6, -- Tauren
			7, -- Gnome
			8, -- Troll
			9, -- Goblin
			10, -- Blood Elf
			11, -- Draenei
			22, -- Worgen
			25, -- Pandaren (Alliance)
			26, -- Pandaren (Horde)
			27, -- Nightborne
			28, -- Highmountain Tauren
			29, -- Void Elf
			30, -- Lightforged Draenei
			31, -- Zandalari Troll
			32, -- Kul Tiran
			34, -- Dark Iron Dwarf
			35, -- Vulpera
			36, -- Mag'har Orc
			37, -- Mechagnome
			52, -- Dracthyr (Alliance)
			70, -- Dracthyr (Horde)
			84, -- Earthen (Horde)
			85, -- Earthen (Alliance)
			86, -- Haranir (Alliance)
			91, -- Haranir (Horde)
		},
	},

	-- Rogue
	[4] = {
		specIDs = {
			259, -- Assassination
			260, -- Outlaw
			261, -- Subtlety
		},
		raceIDs = {
			1, -- Human
			2, -- Orc
			3, -- Dwarf
			4, -- Night Elf
			5, -- Undead
			6, -- Tauren
			7, -- Gnome
			8, -- Troll
			9, -- Goblin
			10, -- Blood Elf
			11, -- Draenei
			22, -- Worgen
			25, -- Pandaren (Alliance)
			26, -- Pandaren (Horde)
			27, -- Nightborne
			28, -- Highmountain Tauren
			29, -- Void Elf
			30, -- Lightforged Draenei
			31, -- Zandalari Troll
			32, -- Kul Tiran
			34, -- Dark Iron Dwarf
			35, -- Vulpera
			36, -- Mag'har Orc
			37, -- Mechagnome
			52, -- Dracthyr (Alliance)
			70, -- Dracthyr (Horde)
			84, -- Earthen (Horde)
			85, -- Earthen (Alliance)
			86, -- Haranir (Alliance)
			91, -- Haranir (Horde)
		},
	},

	-- Priest
	[5] = {
		specIDs = {
			256, -- Discipline
			257, -- Holy
			258, -- Shadow
		},
		raceIDs = {
			1, -- Human
			2, -- Orc
			3, -- Dwarf
			4, -- Night Elf
			5, -- Undead
			6, -- Tauren
			7, -- Gnome
			8, -- Troll
			9, -- Goblin
			10, -- Blood Elf
			11, -- Draenei
			22, -- Worgen
			25, -- Pandaren (Alliance)
			26, -- Pandaren (Horde)
			27, -- Nightborne
			28, -- Highmountain Tauren
			29, -- Void Elf
			30, -- Lightforged Draenei
			31, -- Zandalari Troll
			32, -- Kul Tiran
			34, -- Dark Iron Dwarf
			35, -- Vulpera
			36, -- Mag'har Orc
			37, -- Mechagnome
			52, -- Dracthyr (Alliance)
			70, -- Dracthyr (Horde)
			84, -- Earthen (Horde)
			85, -- Earthen (Alliance)
			86, -- Haranir (Alliance)
			91, -- Haranir (Horde)
		},
	},

	-- Death Knight
	[6] = {
		specIDs = {
			250, -- Blood
			251, -- Frost
			252, -- Unholy
		},
		raceIDs = {
			1, -- Human
			2, -- Orc
			3, -- Dwarf
			4, -- Night Elf
			5, -- Undead
			6, -- Tauren
			7, -- Gnome
			8, -- Troll
			9, -- Goblin
			10, -- Blood Elf
			11, -- Draenei
			22, -- Worgen
			25, -- Pandaren (Alliance)
			26, -- Pandaren (Horde)
			27, -- Nightborne
			28, -- Highmountain Tauren
			29, -- Void Elf
			30, -- Lightforged Draenei
			31, -- Zandalari Troll
			32, -- Kul Tiran
			34, -- Dark Iron Dwarf
			35, -- Vulpera
			36, -- Mag'har Orc
			37, -- Mechagnome
		},
	},

	-- Shaman
	[7] = {
		specIDs = {
			262, -- Elemental
			263, -- Enhancement
			264, -- Restoration
		},
		raceIDs = {
			2, -- Orc
			3, -- Dwarf
			4, -- Night Elf
			6, -- Tauren
			8, -- Troll
			9, -- Goblin
			11, -- Draenei
			25, -- Pandaren (Alliance)
			26, -- Pandaren (Horde)
			28, -- Highmountain Tauren
			31, -- Zandalari Troll
			32, -- Kul Tiran
			34, -- Dark Iron Dwarf
			35, -- Vulpera
			36, -- Mag'har Orc
			84, -- Earthen (Horde)
			85, -- Earthen (Alliance)
			86, -- Haranir (Alliance)
			91, -- Haranir (Horde)
		},
	},

	-- Mage
	[8] = {
		specIDs = {
			62, -- Arcane
			63, -- Fire
			64, -- Frost
		},
		raceIDs = {
			1, -- Human
			2, -- Orc
			3, -- Dwarf
			4, -- Night Elf
			5, -- Undead
			6, -- Tauren
			7, -- Gnome
			8, -- Troll
			9, -- Goblin
			10, -- Blood Elf
			11, -- Draenei
			22, -- Worgen
			25, -- Pandaren (Alliance)
			26, -- Pandaren (Horde)
			27, -- Nightborne
			28, -- Highmountain Tauren
			29, -- Void Elf
			30, -- Lightforged Draenei
			31, -- Zandalari Troll
			32, -- Kul Tiran
			34, -- Dark Iron Dwarf
			35, -- Vulpera
			36, -- Mag'har Orc
			37, -- Mechagnome
			52, -- Dracthyr (Alliance)
			70, -- Dracthyr (Horde)
			84, -- Earthen (Horde)
			85, -- Earthen (Alliance)
			86, -- Haranir (Alliance)
			91, -- Haranir (Horde)
		},
	},

	-- Warlock
	[9] = {
		specIDs = {
			265, -- Affliction
			266, -- Demonology
			267, -- Destruction
		},
		raceIDs = {
			1, -- Human
			2, -- Orc
			3, -- Dwarf
			4, -- Night Elf
			5, -- Undead
			6, -- Tauren
			7, -- Gnome
			8, -- Troll
			9, -- Goblin
			10, -- Blood Elf
			11, -- Draenei
			22, -- Worgen
			25, -- Pandaren (Alliance)
			26, -- Pandaren (Horde)
			27, -- Nightborne
			28, -- Highmountain Tauren
			29, -- Void Elf
			30, -- Lightforged Draenei
			31, -- Zandalari Troll
			32, -- Kul Tiran
			34, -- Dark Iron Dwarf
			35, -- Vulpera
			36, -- Mag'har Orc
			37, -- Mechagnome
			52, -- Dracthyr (Alliance)
			70, -- Dracthyr (Horde)
			84, -- Earthen (Horde)
			85, -- Earthen (Alliance)
			86, -- Haranir (Alliance)
			91, -- Haranir (Horde)
		},
	},

	-- Monk
	[10] = {
		specIDs = {
			268, -- Brewmaster
			269, -- Windwalker
			270, -- Mistweaver
		},
		raceIDs = {
			1, -- Human
			2, -- Orc
			3, -- Dwarf
			4, -- Night Elf
			5, -- Undead
			6, -- Tauren
			7, -- Gnome
			8, -- Troll
			9, -- Goblin
			10, -- Blood Elf
			11, -- Draenei
			22, -- Worgen
			25, -- Pandaren (Alliance)
			26, -- Pandaren (Horde)
			27, -- Nightborne
			28, -- Highmountain Tauren
			29, -- Void Elf
			30, -- Lightforged Draenei
			31, -- Zandalari Troll
			32, -- Kul Tiran
			34, -- Dark Iron Dwarf
			35, -- Vulpera
			36, -- Mag'har Orc
			37, -- Mechagnome
			84, -- Earthen (Horde)
			85, -- Earthen (Alliance)
			86, -- Haranir (Alliance)
			91, -- Haranir (Horde)
		},
	},

	-- Druid
	[11] = {
		specIDs = {
			102, -- Balance
			103, -- Feral
			104, -- Guardian
			105, -- Restoration
		},
		raceIDs = {
			4, -- Night Elf
			6, -- Tauren
			8, -- Troll
			22, -- Worgen
			28, -- Highmountain Tauren
			32, -- Kul Tiran
		},
	},

	-- Demon Hunter
	[12] = {
		specIDs = {
			577, -- Havoc
			581, -- Vengeance
			583, -- Devourer
		},
		raceIDs = {
			4, -- Night Elf
			10, -- Blood Elf
		},
	},

	-- Evoker
	[13] = {
		specIDs = {
			1467, -- Devastation
			1468, -- Preservation
			1473, -- Augmentation
		},
		raceIDs = {
			52, -- Dracthyr (Alliance)
			70, -- Dracthyr (Horde)
		},
	},
}
