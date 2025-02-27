local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")

local napalm_utils = require("prototypes.napalm-utils")

local napalm_boom = napalm_utils.make_napalm_boom(6, 50, {
    {
        distance = 2,
        distance_deviation = 4,
        cluster_count = 10
    },
    {
        distance = 5,
        distance_deviation = 4,
        cluster_count = 10
    }
})


local item = {
    type = "item",
    name = "napalm-land-mine",
    icon = "__lilys-incendiaries__/graphics/icons/land-mine-napalm.png",
    subgroup = "defensive-structure",
    order = "f[land-mine-napalm]",
    inventory_move_sound = item_sounds.explosive_inventory_move,
    pick_sound = item_sounds.explosive_inventory_pickup,
    drop_sound = item_sounds.explosive_inventory_move,
    place_result = "napalm-land-mine",
    stack_size = 100
}

local entity = {
    type = "land-mine",
    name = "napalm-land-mine",
    icon = "__lilys-incendiaries__/graphics/icons/land-mine-napalm.png",
    flags =
    {
        "placeable-player",
        "placeable-enemy",
        "player-creation",
        "placeable-off-grid",
        "not-on-map"
    },
    minable = { mining_time = 0.5, result = "napalm-land-mine" },
    fast_replaceable_group = "land-mine",
    mined_sound = sounds.deconstruct_small(1.0),
    max_health = 15,
    corpse = "land-mine-remnants",
    dying_trigger_effect = {
        type = "nested-result",
        action = napalm_boom
    },
    force_die_on_attack = true,
    resistances = {
        {
            type = "fire",
            percent = 100
        }
    },
    collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    picture_safe =
    {
        layers = {
            {
                filename = "__lilys-incendiaries__/graphics/entity/land-mine-napalm.png",
                priority = "medium",
                width = 64,
                height = 64,
                scale = 0.5
            },
            {
                filename = "__lilys-incendiaries__/graphics/entity/land-mine-napalm-glow.png",
                priority = "medium",
                width = 64,
                height = 64,
                scale = 0.5,
                draw_as_light = true
            }
        }
    },
    picture_set =
    {
        layers = {
            {
                filename = "__lilys-incendiaries__/graphics/entity/land-mine-napalm-set.png",
                priority = "medium",
                width = 64,
                height = 64,
                scale = 0.5
            },
            {
                filename = "__lilys-incendiaries__/graphics/entity/land-mine-napalm-set-glow.png",
                priority = "medium",
                width = 64,
                height = 64,
                scale = 0.5,
                draw_as_light = true
            }
        }
    },
    picture_set_enemy =
    {
        filename = "__base__/graphics/entity/land-mine/land-mine-set-enemy.png",
        priority = "medium",
        width = 32,
        height = 32
    },
    trigger_radius = 2.5,
    ammo_category = "landmine",
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            source_effects =
            {
                {
                    type = "nested-result",
                    affects_target = true,
                    action = napalm_boom
                }
            }
        }
    }
}


data:extend({item, entity})

data:extend({
    {
        type = "recipe",
        name = "napalm-land-mine",
        enabled = false,
        category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
        energy_required = 5,
        ingredients =
        {
            { type = "item", name = "steel-plate", amount = 1 },
            { type = "fluid", name = "lilys-napalm-mix",   amount = 50 }
        },
        results = { { type = "item", name = "napalm-land-mine", amount = 4 } }
    }
})

local tech = data.raw["technology"]["land-mine"]

table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "napalm-land-mine"
})