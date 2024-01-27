local head_start = function()
    -- Check for Freeplay scenario
    if not remote.interfaces["freeplay"] then return end

    -- Give player some additional starting items
    local additional_items = {
        -- Materials
        {name = "coal", count = 100}, {name = "iron-plate", count = 250},
        {name = "copper-plate", count = 150},
        {name = "iron-gear-wheel", count = 50},
        {name = "electronic-circuit", count = 75}, -- Logistics
        {name = "transport-belt", count = 400},
        {name = "underground-belt", count = 200},
        {name = "splitter", count = 25}, {name = "pipe-to-ground", count = 25},
        {name = "pipe", count = 50}, {name = "inserter", count = 50},
        {name = "iron-chest", count = 25}, -- Production
        {name = "stone-furnace", count = 50},
        {name = "assembling-machine-1", count = 25},
        {name = "electric-mining-drill", count = 50}, -- Utilities
        {name = "medium-electric-pole", count = 50},
        {name = "big-electric-pole", count = 25}, {name = "boiler", count = 10},
        {name = "steam-engine", count = 20},
        {name = "offshore-pump", count = 1}, -- Armor/weapons
        {name = "light-armor", count = 1}, {name = "submachine-gun", count = 1},
        {name = "piercing-rounds-magazine", count = 49}
    }

    local freeplay_item_buffer = remote.call("freeplay", "get_created_items")
    for _, item in pairs(additional_items) do
        if game.item_prototypes[item.name] then
            freeplay_item_buffer[item.name] = item.count
        end
    end
    remote.call("freeplay", "set_created_items", freeplay_item_buffer)

    -- Check if crash site is disabled, if so, add spawn a car
    if remote.interfaces["freeplay"].get_disable_crashsite and
        not remote.call("freeplay", "get_disable_crashsite") and
        not remote.call("freeplay", "get_init_ran") then
        local freeplay_parts_buffer = remote.call("freeplay", "get_ship_parts")
        freeplay_parts_buffer[#freeplay_parts_buffer + 1] = {
            name = "car",
            repeat_count = 1,
            angle_deviation = 0.7,
            max_distance = 3
        }
        remote.call("freeplay", "set_ship_parts", freeplay_parts_buffer)
    end
end

script.on_init(function(e) head_start() end)
