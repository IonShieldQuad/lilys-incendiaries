local item_sounds = require("__base__.prototypes.item_sounds")


--  uranium shells
local uranium_incendiary_shells = {
    type = "ammo",
    name = "uranium-piercing-incendiary-shotgun-shell",
    icon = "__lilys-incendiaries__/graphics/icons/uranium-incendiary-shotgun-shell.png",
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
                repeat_count = 16,
                action_delivery =
                {
                    type = "projectile",
                    projectile = "uranium-incendiary-shotgun-pellet",
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
    order = "b[shotgun]-d[uranium-piercing-incendiary]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_pickup,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 100,
    weight = 50 * kg
}

data:extend({ uranium_incendiary_shells })


local uranium_incendiary_shot = {
    type = "projectile",
    name = "uranium-incendiary-shotgun-pellet",
    flags = { "not-on-map" },
    hidden = true,
    collision_box = { { -0.05, -0.25 }, { 0.05, 0.25 } },
    acceleration = 0,
    direction_only = true,
    piercing_damage = 800,
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
                    damage = { amount = 24, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 10, type = "fire" }
                },
            }
        },
        {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-sticker",
                    sticker = "fire-sticker-uranium",
                    show_in_tooltip = true
                }
            }
        },
        {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-sticker",
                    sticker = "fire-sticker-uranium-rad",
                    show_in_tooltip = true
                }
            }
        },
        {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-fire",
                    entity_name = "fire-flame-uranium",
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
        tint = { 0.6, 1, 0.0, 1 }
    },
    light = { size = 8, intensity = 3, tint = { 0.6, 1, 0, 1 } }
}

data.extend({ uranium_incendiary_shot })

data:extend(
    {
        -- upgrade to incendiary ammo
        {
            type = "recipe",
            name = "uranium-piercing-incendiary-shotgun-shell",
            category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
            subgroup = "ammo",
            ---@diagnostic disable-next-line: missing-fields
            recipe_tint = {
                primary = { r = 1.000, g = 0.835, b = 0.643, a = 1.000 },    -- #ffbba4ff
                secondary = { r = 0.749, g = 0.857, b = 0.490, a = 1.000 },  -- #bf8e7dff
                tertiary = { r = 0.637, g = 0.937, b = 0.637, a = 1.000 },   -- #a2a2a2ff
                quaternary = { r = 0.283, g = 0.883, b = 0.283, a = 1.000 }, -- #484848ff
            },
            allow_productivity = false,
            enabled = false,
            energy_required = 50,
            ingredients =
            {
                { type = "item", name = "piercing-incendiary-shotgun-shell", amount = 1 },
                { type = "item", name = "uranium-238",                         amount = 10 },
                { type = "item", name = "uranium-235",                         amount = 1 }
            },
            results = { { type = "item", name = "uranium-piercing-incendiary-shotgun-shell", amount = 1 } }
        }
    })

local uranium_incendiary = data.raw["technology"]["incendiary-uranium-ammo"]
table.insert(uranium_incendiary.effects, {
    type = "unlock-recipe",
    recipe = "uranium-piercing-incendiary-shotgun-shell"
})
