
-- fuel air bomb canister entity
local fab_canister = {
    type="container",
    flags = {"not-on-map", "placeable-off-grid"},
    inventory_size = 0,
    picture = {
        layers = 
        {
            filename = "__base__/graphics/icons/fluid/barreling/empty-barrel.png"
        }, 
        {
                filename = "__base__/graphics/icons/flying-ribot-frame.png",
                priority = high
        }
    },
    max_health = 100,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{0, 0}, {0, 0}},
    mineable = false,

    alert_when_damaged = false
}

fab_canister.resistances = {}
for i, t in ipairs(data.raw["damage_type"]) do
    if t.name == "fire" or t.name == "explosion" then
        fab_canister.resistances.insert = {type = t, decrease = 0, percent = 0}
    else 
    fab_canister.resistances.insert = {type = t, decrease = 0, percent = 100}
    end
end

data:extend({fab_canister})


local fab_cloud = {} 
data:extend({fab_cloud})