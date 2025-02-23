local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")
local napalm_utils = require("prototypes.napalm-utils")

--item
local item = {
    type = "capsule",
    name = "napalm-capsule",
    icon = "__lilys-incendiaries__/graphics/icons/napalm-capsule.png",
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
            range = 30,
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
                            projectile = "napalm-capsule",
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
                                }
                            }
                        }
                    }
                }
            }
        }
    },
    subgroup = "capsule",
    order = "a[napalm-capsule]",
    inventory_move_sound = item_sounds.grenade_inventory_move,
    pick_sound = item_sounds.grenade_inventory_pickup,
    drop_sound = item_sounds.grenade_inventory_move,
    stack_size = 100,
    weight = 20 * kg
}
data:extend({ item })

local projectile = {
    type = "projectile",
    name = "napalm-capsule",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.05,
    action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "nested-result",
                    action = napalm_utils.make_napalm_boom(10, 200, { {
                        distance = 4,
                        distance_deviation = 4,
                        cluster_count = 16
                        },
                        {
                            distance = 10,
                            distance_deviation = 6,
                            cluster_count = 24
                        } })
                },
                {
                    type = "create-entity",
                    entity_name = "fiery-explosion"
                },
                {
                    type = "create-entity",
                    entity_name = "medium-scorchmark-tintable",
                    check_buildability = true
                }

            }
        }
    },
    light = { intensity = 0.5, size = 2 },
    animation =
    {
      filename = "__lilys-incendiaries__/graphics/entity/napalm-capsule.png",
      draw_as_glow = true,
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 58,
      height = 59,
      shift = util.by_pixel(1, 0.5),
      priority = "high",
      scale = 0.5
    },
    shadow =
    {
      filename = "__lilys-incendiaries__/graphics/entity/napalm-capsule-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 54,
      height = 42,
      shift = util.by_pixel(1, 2),
      priority = "high",
      draw_as_shadow = true,
      scale = 0.5
    },
}
data:extend({ projectile })

-- recipe
data:extend({
    {
        type = "recipe",
        name = "napalm-capsule",
        allow_productivity = false,
        enabled = false,
        category = "chemistry",
        energy_required = 5,
        ingredients =
        {
            { type = "fluid", name = "napalm",  amount = 80 },
            { type = "item",  name = "iron-plate", amount = 1 }
        },
        results = { { type = "item", name = "napalm-capsule", amount = 1 } },
    }
})

local tech = data.raw["technology"]["napalm"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "napalm-capsule"
})
