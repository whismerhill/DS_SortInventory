name = "Sort Inventory by me"
description = "Sorts inventory by weapons, equipment, food, etc when you press z. Ctrl+z changes the sorting method. Shift+z toggles whether the first 1-2 slots are sorted. (See Workshop page for v1.2 updates!)"
author = "Brody & Whismerhill"
version = "1.3a"
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
			{description = "1: ", data = 1}, --Dump everything in inventory in an intuitive order
			{description = "2: ", data = 2}, --Stick others at end, starting in the pack if present
			{description = "3: ", data = 3}, --Place all food into backpack if possible. Do food last
			{description = "4: ", data = 4}, --keep weapons and tools just left of equipslots, then from left to right: others, food
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
}