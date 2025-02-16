local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

--item
local methanol_bottle_item = {
    type = "capsule",
    name = "methanol-bottle",
    icon = "__lilys-incendiaries__/graphics/icons/wood-science-pack.png",
    capsule_action =
    {
        type = "throw",

        attack_parameters =
        {
            type = "projectile",
            activation_type = "throw",
            ammo_category = "grenade",
            cooldown = 30,
            projectile_creation_distance = 0.6,
            range = 20,
            ammo_type =
            {
                target_type = "position",
                action =
                {
                    {
                        type = "direct",
                        action_delivery =
                        {
                            type = "projectile",
                            projectile = "methanol-bottle",
                            starting_speed = 1
                        }
                    },
                    {
                        type = "direct",
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "play-sound",
                                    sound = sounds.throw_projectile
                                },
                                {
                                    type = "play-sound",
                                    sound = sounds.throw_grenade
                                },
                            }
                        }
                    }
                }
            }
        }
    },
    subgroup = "science-pack",
    order = "a[methanol-bottle]",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_move,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 200,
    weight = 1 * kg,
    fuel_category = "chemical",
    fuel_value = "20MJ",
    burnt_result = "iron-plate",
    auto_recycle = false
}
data:extend({ methanol_bottle_item })

local methanol_bottle = {
    type = "projectile",
    name = "methanol-bottle",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.05,
    action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "damage",
                    damage = {amount = 10, type = "physical"}
                },
                {
                    type = "play-sound",
                    sound = {
                        category = "explosion",
                        volume = 2,
                        filename = "__lilys-incendiaries__/sounds/glass-shattering-short.ogg"
                    }
                },
                {
                    type = "create-fire",
                    entity_name = "fire-flame",
                    initial_ground_flame_count = 6,
                    show_in_tooltip = true
                },
                {
                    type = "nested-result",
                    action = {
                        type = "area",
                        radius = 5,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "damage",
                                    damage = {amount = 10, type = "fire"},
                                    apply_damage_to_trees = false
                                },
                                {
                                    type = "create-sticker",
                                    sticker = "fire-sticker",
                                    show_in_tooltip = true
                                },
                            }
                        }
                    }
                },
                {
                    type = "nested-result",
                    action = {
                        type = "cluster",
                        distance = 3,
                        distance_deviation = 4,
                        cluster_count = 6,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                type = "create-fire",
                                entity_name = "fire-flame",
                                show_in_tooltip = true
                            }
                        }
                    }
                }
            }
        }
    },
    light = { intensity = 0.25, size = 1 },
    animation =
    {
        filename = "__lilys-incendiaries__/graphics/icons/wood-science-pack.png",
        frame_count = 1,
        mipmap_coount = 4,
        animation_speed = 0.50,
        width = 64,
        height = 64,
        shift = util.by_pixel(0.5, 0.5),
        priority = "high",
        scale = 0.3
    }
}
data:extend({ methanol_bottle })

-- recipe
data:extend({
    {
        type = "recipe",
        name = "methanol-bottle",
        allow_productivity = false,
        enabled = false,
        energy_required = 30,
        ingredients =
        {
            { type = "item",  name = "wood", amount = 50 },
            { type = "item", name = "coal", amount = 1 },
            { type = "item",  name = "iron-plate", amount = 1 }
        },
        results = { { type = "item", name = "methanol-bottle", amount = 1 } },
---@diagnostic disable-next-line: assign-type-mismatch
        auto_recycle = false
    }
})

if mods["quality"] then
    local recycling = require("__quality__/prototypes/recycling.lua")
    recycling.generate_self_recycling_recipe(methanol_bottle_item)
end

-- technology
data:extend({ 
    {
        type = "technology",
        name = "methanol-bottle-production",
        icon_size = 256,
        icon = "__lilys-incendiaries__/graphics/technology/wood-science-pack.png",
        prerequisites = { "automation-science-pack" },
        unit =
        {
            count = 10,
            ingredients =
            {
                { "automation-science-pack", 1 },
            },
            time = 15
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "methanol-bottle"
            }
        },
        order = "a"
    }
})
