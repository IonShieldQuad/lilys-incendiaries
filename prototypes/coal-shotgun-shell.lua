
local item_sounds = require("__base__.prototypes.item_sounds")

--  coal shot
local coal_shot_item = {
    type = "ammo",
    name = "coal-shotgun-shell",
    icon = "__lilys-incendiaries__/graphics/icons/coal-shotgun-shell.png",
    ammo_category = "shotgun-shell",
    ammo_type =
    {
      target_type = "direction",
      clamp_position = true,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = 12,
          action_delivery =
          {
            type = "projectile",
            projectile = "coal-shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = 0.3,
            range_deviation = 0.3,
            max_range = 15
          }
        }
      }
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "b[shotgun]-a[basic-coal]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_pickup,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 100,
    weight = 10*kg
}
data:extend({ coal_shot_item })


local coal_shot = {
    type = "projectile",
    name = "coal-shotgun-pellet",
    flags = { "not-on-map" },
    hidden = true,
    collision_box = { { -0.05, -0.25 }, { 0.05, 0.25 } },
    acceleration = 0,
    direction_only = true,
    action =
    {
        {
            type = "direct",
            action_delivery =
            {
                type = "instant",
                target_effects =
                {
                    type = "damage",
                    damage = { amount = 4, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 4, type = "fire" }
                },
            }
        },
        {
            type = "direct",
            probability = 0.2,
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-sticker",
                    sticker = "fire-sticker",
                    show_in_tooltip = true
                }
            }
        },
        {
            type = "direct",
            probability = 0.3,
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-fire",
                    entity_name = "fire-flame",
                    show_in_tooltip = true,
                    initial_ground_flame_count = 2
                }
            }
        }
    },
    animation =
    {
        filename = "__base__/graphics/entity/bullet/bullet.png",
        draw_as_glow = true,
        width = 3,
        height = 50,
        priority = "high",
        tint = {1.0, 0.3, 0.0, 1}
    },
    light = {size = 2, intensity = 1}
}

data:extend({ coal_shot })

-- recipe
data:extend({
    {
        type = "recipe",
        name = "coal-shotgun-shell",
        subgroup = "ammo",
        allow_productivity = false,
        enabled = false,
        energy_required = 3,
        ingredients =
        {
            { type = "item", name = "shotgun-shell", amount = 1 },
            { type = "item", name = "coal",                   amount = 10 }
        },
        results = { { type = "item", name = "coal-shotgun-shell", amount = 1 } }
    }
})

