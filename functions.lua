function noisegrid_tree(pos)
	local trees = {
        default.grow_new_pine_tree,
        default.grow_new_jungle_tree,
        default.grow_new_pine_tree,
        default.grow_new_acacia_tree,
        default.grow_new_aspen_tree,
        default.grow_bush,
        default.grow_acacia_bush,
    }
    
    trees[math.random(#trees)](pos)
end


function noisegrid_crop(data, vi)
	local crops = {
        -- {"farming:wheat", 8},
        -- {"farming:cotton", 8},
        {"farming:pumpkin", 8},
        {"farming:melon", 8},
        {"farming:carrot", 8},
        {"farming:tomato", 8},
        {"farming:potato", 4},
        {"farming:coffee", 5},
        {"farming:barley", 7},
        {"farming:hemp", 8},
        {"farming:corn", 8},
        {"farming:beetroot", 5},
        {"farming:blueberry", 4},
        {"farming:chili", 8},
        {"farming:cucumber", 4},
        {"farming:garlic", 5},
        {"farming:onion", 5},
        {"farming:pea", 5},
        {"farming:pepper", 5},
        {"farming:pineapple", 8},
        {"farming:raspberry", 4},
        {"farming:rhubarb", 3},
    }
    
	local crop = crops[math.random(#crops)]
    data[vi] = minetest.get_content_id(crop[1].."_"..crop[2])
end


function noisegrid_grass(data, vi)
	local c_grass1 = minetest.get_content_id("default:grass_1")
	local c_grass2 = minetest.get_content_id("default:grass_2")
	local c_grass3 = minetest.get_content_id("default:grass_3")
	local c_grass4 = minetest.get_content_id("default:grass_4")
	local c_grass5 = minetest.get_content_id("default:grass_5")
	local c_grass_jungle = minetest.get_content_id("default:junglegrass")
	local rand = math.random(5)
	if math.random(15) == 1 then
        data[vi] = c_grass_jungle
	elseif rand == 1 then
		data[vi] = c_grass1
	elseif rand == 2 then
		data[vi] = c_grass2
	elseif rand == 3 then
		data[vi] = c_grass3
	elseif rand == 4 then
		data[vi] = c_grass4
	else
		data[vi] = c_grass5
	end
end


function noisegrid_flower(data, vi)
	local c_danwhi = minetest.get_content_id("flowers:dandelion_white")
	local c_danyel = minetest.get_content_id("flowers:dandelion_yellow")
	local c_rose = minetest.get_content_id("flowers:rose")
	local c_tulip = minetest.get_content_id("flowers:tulip")
	local c_geranium = minetest.get_content_id("flowers:geranium")
	local c_viola = minetest.get_content_id("flowers:viola")
	local rand = math.random(6)
	if rand == 1 then
		data[vi] = c_danwhi
	elseif rand == 2 then
		data[vi] = c_rose
	elseif rand == 3 then
		data[vi] = c_tulip
	elseif rand == 4 then
		data[vi] = c_danyel
	elseif rand == 5 then
		data[vi] = c_geranium
	else
		data[vi] = c_viola
	end
end


-- Appletree sapling ABM

minetest.register_abm({
	nodenames = {"noisegrid:appling"},
	interval = 31,
	chance = 7,
	action = function(pos, node)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local vm = minetest.get_voxel_manip()
		local pos1 = {x = x - 2, y = y - 2, z = z - 2}
		local pos2 = {x = x + 2, y = y + 5, z = z + 2}
		local emin, emax = vm:read_from_map(pos1, pos2)
		local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
		local data = vm:get_data()

		noisegrid_appletree(x, y, z, area, data)

		vm:set_data(data)
		vm:write_to_map()
		vm:update_map()
	end,
})
