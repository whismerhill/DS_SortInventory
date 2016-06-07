name = "Sort Inventory"
description = "Sorts inventory by weapons, equipment, food, etc when you press z. Ctrl+z changes the sorting method. Shift+z toggles whether the first 1-2 slots are sorted. (See Workshop page for v1.2 updates!)"
author = "Brody & Whismerhill"
version = "1.4"
forumthread = ""
api_version = 6
icon_atlas = "modicon.xml"
icon = "modicon.tex"
restart_required = false
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true


configuration_options = 
{
	{
		name = "BackpackSortConf",
		label = "Sort Backpack",
		options =
		{
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = true,
		hover = "Whether or not to sort the backpack content as well",
	},
	{
		name = "SortOrderConf",
		label = "Sorting Order",
		options =
		{
			{description = "1: wltbefo ", data = 1}, --Dump everything in inventory in an intuitive order
			{description = "2: wltbef..o", data = 2}, --Stick others at end, starting in the pack if present
			{description = "3: wltbeo..f", data = 3}, --Place all food into backpack if possible. Do food last
			{description = "4: of.ebtlw", data = 4}, --keep weapons and tools just left of equipslots, then from left to right: others, food
			{description = "5: Custom", data = 5},
		},
		default = 1,
		hover = "Controls the default order for autosorting (changeable with keybind)",
	},
    {
        name = "Key_SortConf",
        label = "Sorting Keybind",
        options =
        {
			{description = "A", data = 97},
			{description = "B", data = 98},
			{description = "C", data = 99},
			{description = "D", data = 100},
			{description = "E", data = 101},
			{description = "F", data = 102},
			{description = "G", data = 103},
			{description = "H", data = 104},
			{description = "I", data = 105},
			{description = "J", data = 106},
			{description = "K", data = 107},
			{description = "L", data = 108},
			{description = "M", data = 109},
			{description = "N", data = 110},
			{description = "O", data = 111},
			{description = "P", data = 112},
			{description = "Q", data = 113},
			{description = "R", data = 114},
			{description = "S", data = 116},
			{description = "T", data = 116},
			{description = "U", data = 117},
			{description = "V", data = 118},
			{description = "W", data = 119},
			{description = "X", data = 120},
			{description = "Y", data = 121},
			{description = "Z(default)", data = 122},
			{description = "F1", data = 282},
			{description = "F2", data = 283},
			{description = "F3", data = 284},
			{description = "F4", data = 285},
			{description = "F5", data = 286},
			{description = "F6", data = 287},
			{description = "F7", data = 288},
			{description = "F8", data = 289},
			{description = "F9", data = 290},
			{description = "F10", data = 291},
			{description = "F11", data = 292},
			{description = "F12", data = 293},
        },
        default = 122,
    },	
    {
        name = "Key_BackpackConf",
        label = "Backpack Sort Keybind",
        options =
        {
			{description = "A", data = 97},
			{description = "B", data = 98},
			{description = "C", data = 99},
			{description = "D", data = 100},
			{description = "E", data = 101},
			{description = "F", data = 102},
			{description = "G", data = 103},
			{description = "H", data = 104},
			{description = "I", data = 105},
			{description = "J", data = 106},
			{description = "K", data = 107},
			{description = "L", data = 108},
			{description = "M", data = 109},
			{description = "N", data = 110},
			{description = "O", data = 111},
			{description = "P(default)", data = 112},
			{description = "Q", data = 113},
			{description = "R", data = 114},
			{description = "S", data = 116},
			{description = "T", data = 116},
			{description = "U", data = 117},
			{description = "V", data = 118},
			{description = "W", data = 119},
			{description = "X", data = 120},
			{description = "Y", data = 121},
			{description = "Z", data = 122},
			{description = "F1", data = 282},
			{description = "F2", data = 283},
			{description = "F3", data = 284},
			{description = "F4", data = 285},
			{description = "F5", data = 286},
			{description = "F6", data = 287},
			{description = "F7", data = 288},
			{description = "F8", data = 289},
			{description = "F9", data = 290},
			{description = "F10", data = 291},
			{description = "F11", data = 292},
			{description = "F12", data = 293},
        },
        default = 112,
    },
    {
		name = "CustomSortConf",
		label = "Custom sorting order",
		options =
		{
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = false,
	},
	{
		name = "Placement1Conf",
		label = "First group of items",
		options =
		{
			{description = "Weapons", data = "w"},
			{description = "Lights", data = "l"},
			{description = "Tools", data = "t"},
			{description = "Books", data = "b"},
			{description = "Equips", data = "e"},
			{description = "Foods", data = "f"},
			{description = "Others", data = "o"},
		},
		default = "w",
	},
	{
		name = "Placement2Conf",
		label = "Second group of items",
		options =
		{
			{description = "Weapons", data = "w"},
			{description = "Lights", data = "l"},
			{description = "Tools", data = "t"},
			{description = "Books", data = "b"},
			{description = "Equips", data = "e"},
			{description = "Foods", data = "f"},
			{description = "Others", data = "o"},
		},
		default = "l",
	},
	{
		name = "Placement3Conf",
		label = "Third group of items",
		options =
		{
			{description = "Weapons", data = "w"},
			{description = "Lights", data = "l"},
			{description = "Tools", data = "t"},
			{description = "Books", data = "b"},
			{description = "Equips", data = "e"},
			{description = "Foods", data = "f"},
			{description = "Others", data = "o"},
		},
		default = "t",
	},
	{
		name = "Placement4Conf",
		label = "Fourth group of items",
		options =
		{
			{description = "Weapons", data = "w"},
			{description = "Lights", data = "l"},
			{description = "Tools", data = "t"},
			{description = "Books", data = "b"},
			{description = "Equips", data = "e"},
			{description = "Foods", data = "f"},
			{description = "Others", data = "o"},
		},
		default = "b",
	},
	{
		name = "Placement5Conf",
		label = "Fifth group of items",
		options =
		{
			{description = "Weapons", data = "w"},
			{description = "Lights", data = "l"},
			{description = "Tools", data = "t"},
			{description = "Books", data = "b"},
			{description = "Equips", data = "e"},
			{description = "Foods", data = "f"},
			{description = "Others", data = "o"},
		},
		default = "e",
	},
	{
		name = "Placement6Conf",
		label = "Sixth group of items",
		options =
		{
			{description = "Weapons", data = "w"},
			{description = "Lights", data = "l"},
			{description = "Tools", data = "t"},
			{description = "Books", data = "b"},
			{description = "Equips", data = "e"},
			{description = "Foods", data = "f"},
			{description = "Others", data = "o"},
		},
		default = "f",
	},
	{
		name = "Placement7Conf",
		label = "Last group of items",
		options =
		{
			{description = "Weapons", data = "w"},
			{description = "Lights", data = "l"},
			{description = "Tools", data = "t"},
			{description = "Books", data = "b"},
			{description = "Equips", data = "e"},
			{description = "Foods", data = "f"},
			{description = "Others", data = "o"},
		},
		default = "o",
	},
	{
		name = "Reverse1Conf",
		label = "First: Reverse order",
		options =
		{
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = false,
	},
	{
		name = "Reverse2Conf",
		label = "Second: Reverse order",
		options =
		{
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = false,
	},
	{
		name = "Reverse3Conf",
		label = "Third: Reverse order",
		options =
		{
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = false,
	},
	{
		name = "Reverse4Conf",
		label = "Fourth: Reverse order",
		options =
		{
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = false,
	},
	{
		name = "Reverse5Conf",
		label = "Fifth: Reverse order",
		options =
		{
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = false,
	},
	{
		name = "Reverse6Conf",
		label = "Sixth: Reverse order",
		options =
		{
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = false,
	},
	{
		name = "Reverse7Conf",
		label = "Last: Reverse order",
		options =
		{
			{description = "Yes", data = true},
			{description = "No", data = false},
		},
		default = false,
	},
	{
		name = "Order1Conf",
		label = "First: how to sort",
		options =
		{
			{description = "basic", data = 1},
			{description = "place at end", data = 2},
			{description = "end + no backpack", data = 3},
			{description = "place at start", data = 4},
		},
		default = 1,
	},
	{
		name = "Order2Conf",
		label = "Second: how to sort",
		options =
		{
			{description = "basic", data = 1},
			{description = "place at end", data = 2},
			{description = "end + no backpack", data = 3},
			{description = "place at start", data = 4},
		},
		default = 1,
	},
	{
		name = "Order3Conf",
		label = "Third: how to sort",
		options =
		{
			{description = "basic", data = 1},
			{description = "place at end", data = 2},
			{description = "end + no backpack", data = 3},
			{description = "place at start", data = 4},
		},
		default = 1,
	},
	{
		name = "Order4Conf",
		label = "Fourth: how to sort",
		options =
		{
			{description = "basic", data = 1},
			{description = "place at end", data = 2},
			{description = "end + no backpack", data = 3},
			{description = "place at start", data = 4},
		},
		default = 1,
	},
	{
		name = "Order5Conf",
		label = "Fifth: how to sort",
		options =
		{
			{description = "basic", data = 1},
			{description = "place at end", data = 2},
			{description = "end + no backpack", data = 3},
			{description = "place at start", data = 4},
		},
		default = 1,
	},
	{
		name = "Order6Conf",
		label = "Sixth: how to sort",
		options =
		{
			{description = "basic", data = 1},
			{description = "place at end", data = 2},
			{description = "end + no backpack", data = 3},
			{description = "place at start", data = 4},
		},
		default = 1,
	},
	{
		name = "Order7Conf",
		label = "Last: how to sort",
		options =
		{
			{description = "basic", data = 1},
			{description = "place at end", data = 2},
			{description = "end + no backpack", data = 3},
			{description = "place at start", data = 4},
		},
		default = 1,
	},
}
