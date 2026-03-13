local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

EZArenaFrames.classIDs = {

	-- Warrior
	[1] = {
		specIDs = {

			-- Arms
			[71] = {
				powerType = 1, -- Rage
			},

			-- Fury
			[72] = {
				powerType = 1, -- Rage
			},

			-- Protection
			[73] = {
				powerType = 1, -- Rage
			},
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

			-- Holy
			[65] = {
				powerType = 0, -- Mana
			},

			-- Protection
			[66] = {
				powerType = 0, -- Mana
			},

			-- Retribution
			[70] = {
				powerType = 0, -- Mana
			},
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

			-- Beast Mastery
			[253] = {
				powerType = 2, -- Focus
			},

			-- Marksmanship
			[254] = {
				powerType = 2, -- Focus
			},

			-- Survival
			[255] = {
				powerType = 2, -- Focus
			},
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

			-- Assassination
			[259] = {
				powerType = 3, -- Energy
			},

			-- Outlaw
			[260] = {
				powerType = 3, -- Energy
			},

			-- Subtlety
			[261] = {
				powerType = 3, -- Energy
			},
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

			-- Discipline
			[256] = {
				powerType = 0, -- Mana
			},

			-- Holy
			[257] = {
				powerType = 0, -- Mana
			},

			-- Shadow
			[258] = {
				powerType = 0, -- Mana
			},
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

			-- Blood
			[250] = {
				powerType = 6, -- Runic Power
			},

			-- Frost
			[251] = {
				powerType = 6, -- Runic Power
			},

			-- Unholy
			[252] = {
				powerType = 6, -- Runic Power
			},
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

			-- Elemental
			[262] = {
				powerType = 11, -- Maelstrom
			},

			-- Enhancement
			[263] = {
				powerType = 11, -- Maelstrom
			},

			-- Restoration
			[264] = {
				powerType = 0, -- Mana
			},
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

			-- Arcane
			[62] = {
				powerType = 0, -- Mana
			},

			-- Fire
			[63] = {
				powerType = 0, -- Mana
			},

			-- Frost
			[64] = {
				powerType = 0, -- Mana
			},
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

			-- Affliction
			[265] = {
				powerType = 0, -- Mana
			},

			-- Demonology
			[266] = {
				powerType = 0, -- Mana
			},

			-- Destruction
			[267] = {
				powerType = 0, -- Mana
			},
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

			-- Brewmaster
			[268] = {
				powerType = 3, -- Energy
			},

			-- Windwalker
			[269] = {
				powerType = 3, -- Energy
			},

			-- Mistweaver
			[270] = {
				powerType = 0, -- Mana
			},
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

			-- Balance
			[102] = {
				powerType = 8, -- Astral Power
			},

			-- Feral
			[103] = {
				powerType = 3, -- Energy
			},

			-- Guardian
			[104] = {
				powerType = 1, -- Rage
			},

			-- Restoration
			[105] = {
				powerType = 0, -- Mana
			},
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

			-- Havoc
			[577] = {
				powerType = 17, -- Fury
			},

			-- Vengeance
			[581] = {
				powerType = 17, -- Fury
			},

			-- Devourer
			[1480] = {
				powerType = 17, -- Fury
			},
		},
		raceIDs = {
			4, -- Night Elf
			10, -- Blood Elf
		},
	},

	-- Evoker
	[13] = {
		specIDs = {

			-- Devastation
			[1467] = {
				powerType = 0, -- Mana
			},

			-- Preservation
			[1468] = {
				powerType = 0, -- Mana
			},

			-- Augmentation
			[1473] = {
				powerType = 0, -- Mana
			},
		},
		raceIDs = {
			52, -- Dracthyr (Alliance)
			70, -- Dracthyr (Horde)
		},
	},
}
