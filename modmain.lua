-- version 1.3 of sort_inventory
-- sorts into weapons, tools, equips, foods, and others

-- Set this value to false if you don't want the backpack to be sorted. (now a config option)
local sort_backpack = GetModConfigData("BackpackSortConf") -- true
local sort_method = GetModConfigData("SortOrderConf")
local lowest_sort_index = 1
local open_chest = nil
local KEY_SORT = GetModConfigData("Key_SortConf")
local KEY_BACKPACK = GetModConfigData("Key_BackpackConf")


-- Combines 2 stacks of the same item
-- returns false if the 2nd item disappears
combine_stacks = function(item1, item2)
    if not item1.components.stackable then return end
    local size1 = item1.components.stackable.stacksize
    local size2 = item2.components.stackable.stacksize
    local max_size = item1.components.stackable.maxsize
    local combined_size = size1+size2
    local perish_time_1 = nil
    local perish_time_2 = nil
    if item1.components.perishable then
        perish_time_1 = item1.components.perishable.perishremainingtime
        perish_time_2 = item2.components.perishable.perishremainingtime
    end
    if size1 < max_size then
        if combined_size <= max_size then
            --just combine the stacks
            if perish_time_1 then
                -- the item will perish so average the together
                local perish_time_1 = average(perish_time_1, size1, perish_time_2, size2)
                item1.components.perishable.perishremainingtime = perish_time_1
            end
            item1.components.stackable.stacksize = combined_size
            item2:Remove()
            return true
        elseif size1 + size2 > max_size then
            local amount_moved = max_size - size1
            local amount_left = size2 - amount_moved
            if perish_time_1 then
                -- the item will perish so average the together
                local perish_time_1 = average(perish_time_1, size1, perish_time_2, amount_moved)
                item1.components.perishable.perishremainingtime = perish_time_1
                -- perish_time_2 stays the same because nothing is added to it
            end
            item1.components.stackable.stacksize = max_size
            item2.components.stackable.stacksize = amount_left
            return false
        end
    end
    return false
end

average = function(value1, amount1, value2, amount2)
    local total1 = value1*amount1
    local total2 = value2*amount2
    local total = total1 + total2
    return total/(amount1+amount2)
end


-- Requires either the backpack or the inventory to have an empty slot
place_item_at_end = function(item)
	local player = GLOBAL.GetPlayer()
	local backpack = player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.PACK) or player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BACK) or player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY)
	if not sort_backpack then backpack = nil end
	if not backpack or not backpack.components or not backpack.components.container then
		backpack = nil
	end
	local backpack_size = 0
	if backpack then
		backpack_size = backpack.components.container.numslots
	end
	local MAXSLOTS = player.components.inventory.maxslots
	
	local index_br = 0 -- index_backpack_reverse
	local index_ir = 0 -- index_inventory_reverse
	if backpack then
		-- find the index of the last empty slot in the backpack if it's there
		while (index_br < backpack_size) and (backpack.components.container.slots[backpack_size-index_br]) do
			index_br = index_br+1
		end
	end	
	if index_br == backpack_size then
		while (index_ir < MAXSLOTS) and (player.components.inventory.itemslots[MAXSLOTS-index_ir]) do
			index_ir = index_ir+1
		end
		player.components.inventory:GiveItem(item, MAXSLOTS-index_ir, nil)
	else
		backpack.components.container:GiveItem(item, backpack_size-index_br, nil, false)
	end
end

place_item_at_end_no_backpack = function(item)
	local player = GLOBAL.GetPlayer()
	local MAXSLOTS = player.components.inventory.maxslots
    local backpack = nil
	local backpack_size = 0
    local index_br = 0
	local index_ir = 0 -- index_inventory_reverse

    while (index_ir < MAXSLOTS) and (player.components.inventory.itemslots[MAXSLOTS-index_ir]) do
        index_ir = index_ir+1
    end
    player.components.inventory:GiveItem(item, MAXSLOTS-index_ir, nil)
end

-- insert item at first free index
place_item_at_start = function(item)
    local player = GLOBAL.GetPlayer()
	local backpack = player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.PACK) or player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BACK) or player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY)
	if not sort_backpack then backpack = nil end
	if not backpack or not backpack.components or not backpack.components.container then
		backpack = nil
	end
	local backpack_size = 0
	if backpack then
		backpack_size = backpack.components.container.numslots
	end
	local MAXSLOTS = player.components.inventory.maxslots
	
	local index_b = 1 -- index_backpack
	local index_i = 1 -- index_inventory
	while (index_i < MAXSLOTS) and (player.components.inventory.itemslots[index_i]) do
        index_i = index_i+1
    end
    if (index_i <= MAXSLOTS) then
        player.components.inventory:GiveItem(item, index_i, nil)
    else --into the backpack
        while (index_b < backpack_size) and (backpack.components.container.slots[index_b]) do
            index_b = index_b + 1
        end
        backpack.components.container:GiveItem(item, index_b, nil, false)
    end
end

-- Reverse the order of a table
reverse_table = function(t)
	local new_table = {}
	local i = #t --length of original table
	for k,v in ipairs(t) do
		new_table[i] = v
		i = i-1
	end
	return(new_table)
end

quick_stack = function(chest, player_inventory)
    for k,v in pairs(chest.slots) do
        if v and v.components and v.components.stackable then
            for k1,v1 in pairs(player_inventory.itemslots) do
                if v1 and v1.prefab == v.prefab then
                    local item = chest.slots[k]
                    local v_size = item.components.stackable.stacksize
                    local max_stack = item.components.stackable.maxsize
                    local v1_size = v1.components.stackable.stacksize
                    local combined_size = v1_size + v_size
                    local perish_time_chest = nil
                    local perish_time_inv = nil
                    if item.components.perishable then
                        perish_time_chest = item.components.perishable.perishremainingtime
                        perish_time_inv = v1.components.perishable.perishremainingtime
                    end
                    if v_size < max_stack then
                        if combined_size <= max_stack then
                            --just combine the stacks
                            player_inventory:RemoveItemBySlot(k1):Remove() 
                            chest:RemoveItemBySlot(k)
                            if perish_time_chest then
                                -- the item will perish so average the together
                                local perish_time = ((perish_time_chest * v_size) + (perish_time_inv * v1_size))/(v_size+v1_size)
                                item.components.perishable.perishremainingtime = perish_time
                            end
                            item.components.stackable.stacksize = combined_size
                            chest:GiveItem(item, k, nil, false)
                        elseif v1_size + v_size > max_stack then
                            local chest_item = item
                            local inv_item = v1
                            player_inventory:RemoveItemBySlot(k1) 
                            chest:RemoveItemBySlot(k)
                            local amount_moved = max_stack - v_size
                            local amount_left = v1_size - amount_moved
                            if perish_time_chest then
                                -- the item will perish so average the together
                                local perish_time = average(perish_time_chest, v_size, perish_time_inv, amount_moved)
                                chest_item.components.perishable.perishremainingtime = perish_time
                            end
                            chest_item.components.stackable.stacksize = max_stack
                            inv_item.components.stackable.stacksize = amount_left
                            chest:GiveItem(chest_item, k, nil, false)
                            player_inventory:GiveItem(inv_item, k1, nil)
                            break
                        end
                    end
                end
            
            end
        end        
    end
end   

quick_stack_backpack = function(chest, backpack)
    for k,v in pairs(chest.slots) do
        if v and v.components and v.components.stackable then
            for k1,v1 in pairs(backpack.slots) do
                if v1 and v1.prefab == v.prefab then
                    local item = chest.slots[k]
                    local v_size = item.components.stackable.stacksize
                    local max_stack = item.components.stackable.maxsize
                    local v1_size = v1.components.stackable.stacksize
                    local combined_size = v1_size + v_size
                    local perish_time_chest = nil
                    local perish_time_inv = nil
                    if item.components.perishable then
                        perish_time_chest = item.components.perishable.perishremainingtime
                        perish_time_inv = v1.components.perishable.perishremainingtime
                    end
                    if v_size < max_stack then
                        if combined_size <= max_stack then
                            --just combine the stacks
                            backpack:RemoveItemBySlot(k1):Remove()  
                            chest:RemoveItemBySlot(k)
                            if perish_time_chest then
                                -- the item will perish so average the together
                                local perish_time = ((perish_time_chest * v_size) + (perish_time_inv * v1_size))/(v_size+v1_size)
                                item.components.perishable.perishremainingtime = perish_time
                            end
                            item.components.stackable.stacksize = combined_size
                            chest:GiveItem(item, k, nil, false)
                        elseif v1_size + v_size > max_stack then
                            local chest_item = item
                            local inv_item = v1
                            backpack:RemoveItemBySlot(k1) 
                            chest:RemoveItemBySlot(k)
                            local amount_moved = max_stack - v_size
                            local amount_left = v1_size - amount_moved
                            if perish_time_chest then
                                -- the item will perish so average the together
                                local perish_time = ((perish_time_chest * v_size) + (perish_time_inv * amount_moved))/(v_size+amount_moved)
                                chest_item.components.perishable.perishremainingtime = perish_time
                            end
                            chest_item.components.stackable.stacksize = max_stack
                            inv_item.components.stackable.stacksize = amount_left
                            chest:GiveItem(chest_item, k, nil, false)
                            backpack:GiveItem(inv_item, k1, nil, false)
                            break
                        end
                    end
                end
            
            end
        end        
    end
end

-- New function by whis for avoiding repeating the same stuff over & over
local final_sort = function(player,index,object,reverse,mode)
    if object then
        if reverse then
            reverse_table(object)
        end
        for h, x in pairs(object) do
            if mode == 1 then
                player.components.inventory:GiveItem(x, index, nil)
            elseif mode == 2 then
                place_item_at_end(x)
            elseif mode == 3 then
                place_item_at_end_no_backpack(x)
            elseif mode == 4 then
                place_item_at_start(x)
            end
            index = index+1
        end
        return index
    end
end

-- Main sort inventory function
sort_inv = function() 
	local player = GLOBAL.GetPlayer()
	local backpack = player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.PACK) or player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BACK) or player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY)
	if not sort_backpack then backpack = nil end
	-- Double check that the backpack object is actually a container
	if not backpack or not backpack.components or not backpack.components.container then
		backpack = nil
	end
	local backpack_size = 0
	if backpack then
		backpack_size = backpack.components.container.numslots
	end
	local method = sort_method
	local MIN = lowest_sort_index
	local MAXSLOTS = player.components.inventory.maxslots -- will change depending on mods present
	local MAX = MAXSLOTS + backpack_size
	local temp_inventory = {}
	local weapons = {}
	local tools = {}
    local books = {} --added books & lights categories
    local lights ={} -- burnable component ?
	local equips = {}
	local foods = {}
	local others = {}
    
    -- First see if there's a chest and use quick_stack
    if open_chest then
        local chest = open_chest
        local player_inventory = player.components.inventory
        quick_stack(chest, player_inventory)
        if backpack and backpack.components and backpack.components.container then
            quick_stack_backpack(chest, backpack.components.container)
        end
    end

    -- Next sort the inventory and backpack
	for i = MIN, MAX do
		local item = nil
		if (i <= MAXSLOTS) then
			--Not looking in a backpack or chest yet
			item = player.components.inventory.itemslots[i]
		else
			--backpack exists so start taking items from there
			item = backpack.components.container.slots[i-MAXSLOTS]
		end
		-- equips
		if item then
			if (item["components"]["equippable"]) then -- includes weapons, tools, and other equippable items
                if (item["components"]["tool"]) then
					local new_item_index = #tools+1
                    for n = 1, #tools do
                        o = tools[n]
                        if o["prefab"] == item["prefab"] then
                            new_item_index = n+1 -- stick the identical item in the next spot
                        end
                    end
                    table.insert(tools, new_item_index, item)
                elseif (item["components"]["book"]) then  --books this should work, have component book
                    local new_item_index = #books+1
                    for n = 1, #books do
                        o = books[n]
                        if o["prefab"] == item["prefab"] then
                            new_item_index = n+1 -- stick the identical item in the next spot
                        end
                    end
                    table.insert(weapons, new_item_index, item)
                elseif (item["Light"] or item["fire"] or item.prefab == "molehat") then  --lights 
                    local new_item_index = #lights+1
                    for n = 1, #lights do
                        o = lights[n]
                        if o["prefab"] == item["prefab"] then
                            new_item_index = n+1 -- stick the identical item in the next spot
                        end
                    end
                    table.insert(weapons, new_item_index, item)
				elseif (item["components"]["weapon"]) then
                    local new_item_index = #weapons+1
                    for n = 1, #weapons do
                        o = weapons[n]
                        if o["prefab"] == item["prefab"] then
                            new_item_index = n+1 -- stick the identical item in the next spot
                        end
                    end
                    table.insert(weapons, new_item_index, item)
				elseif (item["components"]["equippable"]) then
					local new_item_index = #equips+1
                    for n = 1, #equips do
                        o = equips[n]
                        if o["prefab"] == item["prefab"] then
                            new_item_index = n+1 -- stick the identical item in the next spot
                        end
                    end
                    table.insert(equips, new_item_index, item)
				end
			-- foods
			elseif (item["components"]["edible"] and not 
						(item["components"]["edible"]["foodtype"] == "ELEMENTAL" or 
						  item["components"]["edible"]["foodtype"] == "WOOD")) then -- includes anything you can eat, sorted by hungervalue               
				if (#foods == 0) then 
					foods[1] = item
				else 
					-- big loop to insert the new food
					local new_food_index = 1
                    local gone = false
					for n = 1, #foods do
						f = foods[n]
						if f["components"]["edible"]["hungervalue"] >= item["components"]["edible"]["hungervalue"] then
							new_food_index = new_food_index+1
                            if f.prefab == item.prefab then
                                gone = combine_stacks(f, item)
                            end
						end
					end
                    if not gone then
                        table.insert(foods, new_food_index, item)
                    end
				end
			-- others
			else 
				local new_item_index = #others+1
                local gone = false
				for n = 1, #others do
					o = others[n]
					if o["prefab"] == item["prefab"] then
                        gone = combine_stacks(o, item)
						new_item_index = n+1 -- stick the identical item in the next spot
					end
				end
                if not gone then
                    table.insert(others, new_item_index, item)
                end
			end
			if i > MAXSLOTS then
				-- remove from backpack instead of inventory
				backpack.components.container:RemoveItemBySlot(i-MAXSLOTS)
			else
				player.components.inventory:RemoveItemBySlot(i)
			end
		end
	end
	
	-- Next add all items from the sorted tables into the inventory/backpack again
	local index = MIN
	-- Method 2: Stick others at end, starting in the pack if present
	if method == 2 then
        index = final_sort(player,index,weapons,false,1) --final_sort 1 is giveitem, 2 is placeatend, 3 is nobackpack, 4 is placeatstart
        index = final_sort(player,index,lights,false,1)
        index = final_sort(player,index,tools,false,1)
        index = final_sort(player,index,books,false,1)
        index = final_sort(player,index,equips,false,1)
        index = final_sort(player,index,foods,false,1)
        index = final_sort(player,index,others,true,2) -- true means reverse table
	-- Method 1: Dump everything in inventory in an intuitive order
	elseif method == 1 then
        index = final_sort(player,index,weapons,false,1)
        index = final_sort(player,index,lights,false,1)
        index = final_sort(player,index,tools,false,1)
        index = final_sort(player,index,books,false,1)
        index = final_sort(player,index,equips,false,1)
        index = final_sort(player,index,foods,false,1)
        index = final_sort(player,index,others,false,1)
	-- Sort method 3: Place all food into backpack if possible. Do food last
	elseif method == 3 then
        index = final_sort(player,index,weapons,false,1)
        index = final_sort(player,index,lights,false,1)
        index = final_sort(player,index,tools,false,1)
        index = final_sort(player,index,books,false,1)
        index = final_sort(player,index,equips,false,1)
        index = final_sort(player,index,others,false,1)
        index = final_sort(player,index,foods,true,2)
    -- keep weapons and tools just left of equipslots, then from left to right:
        -- others, food
    elseif method == 4 then
        index = final_sort(player,index,weapons,true,3)
        index = final_sort(player,index,lights,true,3)
        index = final_sort(player,index,tools,true,3)
        index = final_sort(player,index,books,true,3)
        index = final_sort(player,index,equips,true,3)
        index = final_sort(player,index,others,false,4)
        index = final_sort(player,index,foods,false,4)
	end
end

toggle_method = function()
    if sort_method == 1 then
        sort_method = 2
        print("Sorting method 2")
    elseif sort_method == 2 then
        sort_method = 3
        print("Sorting method 3")
    elseif sort_method == 3 then
        sort_method = 4
        print("Sorting method 4")
    else
        sort_method = 1
        print("Sorting method 1")
    end
end

toggle_hold = function()
    if lowest_sort_index == 1 then
        lowest_sort_index = 2
        print("Left-most slot shall remain unsorted")
    elseif lowest_sort_index == 2 then
        lowest_sort_index = 3
        print("Left-most 2 slots shall remain unsorted")
    else
        lowest_sort_index = 1
        print("All slots shall be sorted")
    end
end

GLOBAL.TheInput:AddKeyUpHandler(KEY_SORT, function()
	local TheInput = GLOBAL.TheInput

	if not GLOBAL.IsPaused() and not TheInput:IsKeyDown(GLOBAL.KEY_CTRL) and not TheInput:IsKeyDown(GLOBAL.KEY_SHIFT) and not TheInput:IsKeyDown(GLOBAL.KEY_ALT) then      
		sort_inv()
	--Ctrl is pressed
	elseif not GLOBAL.IsPaused() and TheInput:IsKeyDown(GLOBAL.KEY_CTRL) and not TheInput:IsKeyDown(GLOBAL.KEY_SHIFT) and not TheInput:IsKeyDown(GLOBAL.KEY_ALT) then  
		toggle_method()
		sort_inv()
    --Shift is pressed
	elseif not GLOBAL.IsPaused() and not TheInput:IsKeyDown(GLOBAL.KEY_CTRL) and TheInput:IsKeyDown(GLOBAL.KEY_SHIFT) and not TheInput:IsKeyDown(GLOBAL.KEY_ALT) then  
		toggle_hold()
	end
end)



GLOBAL.TheInput:AddKeyUpHandler(KEY_BACKPACK, function()
	if sort_backpack then 
		sort_backpack = false
		print("Only sorting inventory and not the backpack.")
	else 
		sort_backpack = true
		print("Sort backpack and inventory together.")
	end
end)

-- Set which chest is open, or null if none are open
local function Set_Open_Chest(self)
    function self:OnOpen()
        self.open = true
    
        if self.opener and self.opener.components.inventory then
            self.opener.components.inventory.opencontainers[self.inst] = true
        end
        
        self.inst:PushEvent("onopen", {doer = self.opener})    
        if self.onopenfn then
            self.onopenfn(self.inst)
        end
        
		if self.type and self.type == "chest" then
			open_chest = self
		end
    end
    
    function self:OnClose(old_opener)
        self.open = false
        
        if old_opener and old_opener.components.inventory then
            old_opener.components.inventory.opencontainers[self.inst] = nil
        end
        
        if self.onclosefn then
            self.onclosefn(self.inst)
        end

        self.inst:PushEvent("onclose")
        
        open_chest = nil
    end
end

AddClassPostConstruct ("components/container", Set_Open_Chest)