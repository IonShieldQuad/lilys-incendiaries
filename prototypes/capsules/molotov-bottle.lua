local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")
local napalm_utils = require("prototypes.napalm-utils")

--item
local item = {
    type = "capsule",
    name = "molotov-bottle",
    icon = "__lilys-incendiaries__/graphics/icons/molotov-cocktail.png",
    icon_size = 32,
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
                            projectile = "molotov-bottle",
                            starting_speed = 0.6
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
    subgroup = "capsule",
    order = "a[molotov-bottle]",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_move,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 100,
    weight = 10 * kg
}
data:extend({ item })

local projectile = {
    type = "projectile",
    name = "molotov-bottle",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.05,
    action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "play-sound",
                    sound = {
                        category = "explosion",
                        volume = 2,
                        filename = "__lilys-incendiaries__/sounds/glass-shattering-short.ogg"
                    }
                },
                {
                    type = "nested-result",
                    action = napalm_utils.make_napalm_boom(8, 100, {{
                            distance = 2,
                            distance_deviation = 4,
                            cluster_count = 8
                        },
                        {
                            distance = 4,
                            distance_deviation = 6,
                            cluster_count = 12
                        }})
                },
                {
                    type = "create-entity",
                    entity_name = "fiery-splash"
                },
                {
                    type = "create-entity",
                    entity_name = "small-scorchmark-tintable",
                    check_buildability = true
                },
                
            }
        }
    },
    light = { intensity = 0.25, size = 1 },
    animation =
    {
        filename = "__lilys-incendiaries__/graphics/entity/molotov-in-flight.png",
        frame_count = 1,
        animation_speed = 0.50,
        width = 24,
        height = 24,
        shift = util.by_pixel(0.5, 0.5),
        priority = "high",
        scale = 1.0
    }
}
data:extend({ projectile })

-- recipe
data:extend({
    {
        type = "recipe",
        name = "molotov-bottle",
        allow_productivity = false,
        enabled = false,
        category = "crafting-with-fluid",
        energy_required = 5,
        ingredients =
        {
            { type = "fluid", name = "heavy-oil",       amount = 50 },
            { type = "item", name = "coal",       amount = 5 },
            { type = "item", name = "iron-plate", amount = 1 }
        },
        results = { { type = "item", name = "molotov-bottle", amount = 1 } },
    }
})

local tech = data.raw["technology"]["flammables"]
if tech.effects == nil then
    tech.effects = {}
end
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "molotov-bottle"
})
