# DS_SortInventory
Don't starve mod : Sort Inventory by Brody & Whismerhill

Features:
- Sorts inventory by weapons, equipment, food, etc when you press z. (keybind configurable)
- Changes sort method when you press Ctrl+z.
- Toggles whether the first 1-2 slots get sorted when you press Shift+z.
- Food is sorted by hungervalue.
- Multiple stacks of items that aren't equipment or food are set next to eachother.
- compatible with RoG & SW
- Works with items from other mods, and variable inventory/backpack sizes!


Sorting Methods (CTRL + Z or chosen keybind)
Note: in the configuration menu, there is no space to write all this, so only the first letter were kept in an approximate of how it's gonna appear.
- --1: Weapons, lights, tools, books, equips, food, others
- --2: Weapons, lights, tools, books, equips, food, others at end of inventory(or in backpack)
- --3: Weapons, lights, tools, books, equips, others, food at end of inventory
- --4: Weapons, lights, tools, books, equips to left of equipslots. Others, food from left to right.
- --5: CUSTOM SORTING

Skip first slots of inventory:
- --default: none
- --1 held: 1st item of inventory will not be sorted
- --2 held: 1st 2 items of inventory will not be sorted

CUSTOM SORTING DOCUMENTATION
in the mod option menu
- 1 : Begin by enabling "Custom sorting order" (Yes)
- 2 : Choose whether or not "Sorting Order" is set to "5 Custom" 
this is the default sorting order which you can change with CTRL+Z or keybind
- 3 : Choose the order you want for your objects with the "First group of items" to "Last group of items"
IT IS VERY IMPORTANT THAT THERE'S ONLY 1 OF EACH HERE otherwise custom sorting will be disabled.
- 4 : Choose whether or not the objects in a group are in reversed order. Please note that most objects are not sorted
inside their group except foods
- 5 : Choose "how to sort"
- -- "basic" just puts items as if you just picked them up in the sorting order.
- -- "place at end" puts items at the end of your inventory (inside the backpack if available)
- -- "end + no backpack" puts items at the end of your inventory but will skip the backpack
- -- "place at start" puts items at the start ????



-----------------------------------------------------------
-------------------------CHANGELOG-------------------------
-----------------------------------------------------------
v1.4
- custom sorting, even more configuration options
v1.3
- configurable keybinds
v1.1
- Now works with backpacks
- Works with other mods (RPG HUD, and several others which introduce new items have been tested)!
- Ctrl+z now toggles the sorting method
- Shift+z toggles whether the first 1-2 items are also sorted

Bugs:
- Keybind reset when controls or options are modified.
x Modicon crashed mod page - Fixed. Thanks to KARAS for help!

Future updates:
- Sort chests
