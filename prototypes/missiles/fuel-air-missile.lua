local item_sounds = require("__base__.prototypes.item_sounds")
local fab_utils = require("prototypes.fuel-air-utils")

local fuel_air_missile_item = {
    type = "ammo",
    name = "fuel-air-missile",
    icon = "__lilys-incendiaries__/graphics/icons/fuel-air-missile.png",
    ammo_category = "rocket",
    ammo_type =
    {
        target_type = "position",
        clamp_position = false,
        range_modifier = 2,
        cooldown_modifier = 20,
        action = {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "fuel-air-missile",
                starting_speed = 0.3,
                source_effects =
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-d[fuel-air]",
    inventory_move_sound = item_sounds.ammo_large_inventory_move,
    pick_sound = item_sounds.ammo_large_inventory_pickup,
    drop_sound = item_sounds.ammo_large_inventory_move,
    stack_size = 10,
    weight = 500 * kg
}
data:extend({ fuel_air_missile_item })

--entity
local fuel_air_missile = table.deepcopy(data.raw["projectile"]["rocket"])
fuel_air_missile.name = "fuel-air-missile"
fuel_air_missile.action = fab_utils.make_fuel_air_effect({
    {
        cluster_count = 12,
        distance = 12,
        distance_deviation = 12
    },
    {
        cluster_count = 6,
        distance = 4,
        distance_deviation = 6
    },
}, true)

fuel_air_missile.animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({ 0.4, 0.4, 0.4 })

data:extend({ fuel_air_missile })

--recipe
data:extend({
    {
        type = "recipe",
        name = "fuel-air-missile",
        category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
        subgroup = "ammo",
        crafting_machine_tint = {
            primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 },    -- #ffbba4ff
            secondary = { r = 0.749, g = 0.557, b = 0.490, a = 1.000 },  -- #bf8e7dff
            tertiary = { r = 0.637, g = 0.637, b = 0.637, a = 1.000 },   -- #a2a2a2ff
            quaternary = { r = 0.283, g = 0.283, b = 0.283, a = 1.000 }, -- #484848ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 20,
        ingredients =
        {
            { type = "item",  name = "rocket",               amount = 1 },
            { type = "fluid", name = "petroleum-gas",        amount = 2000 },
            { type = "item",  name = "rocket-fuel",          amount = 10 },
            { type = "item",  name = "electric-engine-unit", amount = 1 },
            { type = "item",  name = "battery",              amount = 1 }
        },
        results = { { type = "item", name = "fuel-air-missile", amount = 1 } }
    }
})

local tech = data.raw["technology"]["burny-explosive-rocketry"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "fuel-air-missile"
})