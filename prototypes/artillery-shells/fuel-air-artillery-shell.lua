local item_sounds = require("__base__.prototypes.item_sounds")

local fab_utils = require("prototypes.fuel-air-utils")

local fab_boom = fab_utils.make_fuel_air_effect({
    {
        distance = 2,
        distance_deviation = 4,
        cluster_count = 12
    },
    {
        distance = 6,
        distance_deviation = 4,
        cluster_count = 16
    },
    {
        distance = 10,
        distance_deviation = 4,
        cluster_count = 20
    }
}, true)

item = {
    type = "ammo",
    name = "fuel-air-artillery-shell",
    icon = "__lilys-incendiaries__/graphics/icons/fab-artillery-shell-icon.png",
    ammo_category = "artillery-shell",
    ammo_type =
    {
        target_type = "position",
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "artillery",
                projectile = "fuel-air-artillery-projectile",
                starting_speed = 1,
                direction_deviation = 0,
                range_deviation = 0,
                source_effects =
                {
                    type = "create-explosion",
                    entity_name = "artillery-cannon-muzzle-flash"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[explosive-cannon-shell]-d[artillery]-fuel-air",
    inventory_move_sound = item_sounds.artillery_large_inventory_move,
    pick_sound = item_sounds.artillery_large_inventory_pickup,
    drop_sound = item_sounds.artillery_large_inventory_move,
    stack_size = 1,
    weight = 100 * kg
}

local shell = {
    type = "artillery-projectile",
    name = "fuel-air-artillery-projectile",
    flags = { "not-on-map" },
    hidden = true,
    reveal_map = true,
    map_color = { 1, 1, 0 },
    picture =
    {
        filename = "__lilys-incendiaries__/graphics/entity/arti/fab-artillery-shell.png",
        draw_as_glow = true,
        width = 64,
        height = 64,
        scale = 0.5
    },
    shadow =
    {
        filename = "__lilys-incendiaries__/graphics/entity/arti/shell-shadow.png",
        width = 64,
        height = 64,
        scale = 0.5
    },
    chart_picture =
    {
        filename = "__lilys-incendiaries__/graphics/entity/arti/fab-artillery-shoot-map-visualization.png",
        flags = { "icon" },
        width = 64,
        height = 64,
        priority = "high",
        scale = 0.25
    },
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "nested-result",
                    action = fab_boom

                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        radius = 2.0,
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "damage",
                                    damage = { amount = 1000, type = "physical" }
                                }
                            }
                        }
                    }
                },
                {
                    type = "create-trivial-smoke",
                    smoke_name = "artillery-smoke",
                    initial_height = 0,
                    speed_from_center = 0.05,
                    speed_from_center_deviation = 0.005,
                    offset_deviation = { { -4, -4 }, { 4, 4 } },
                    max_radius = 3.5,
                    repeat_count = 4 * 4 * 15
                },
                {
                    type = "show-explosion-on-chart",
                    scale = 16 / 32
                }
            }
        }
    },
    final_action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                }
            }
        }
    },
    height_from_ground = 280 / 64
}


data:extend({ item, shell })

data:extend({ {
    type = "recipe",
    name = "fuel-air-artillery-shell",
    category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
    enabled = false,
    energy_required = 30,
    ingredients =
    {
        { type = "item",  name = "artillery-shell",     amount = 1 },
        { type = "item",  name = "fuel-air-missile", amount = 10 },
        { type = "fluid", name = "petroleum-gas", amount = 2000},
    },
    results = { { type = "item", name = "fuel-air-artillery-shell", amount = 1 } }
} })


local tech = data.raw["technology"]["burny-explosive-rocketry"]

table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "fuel-air-artillery-shell"
})
