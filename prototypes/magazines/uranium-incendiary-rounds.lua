local item_sounds = require("__base__.prototypes.item_sounds")

--  uranium fire mag item
local uranium_incendiary_mag = {
    type = "ammo",
    name = "uranium-incendiary-rounds-magazine",
    pictures =
    {
        layers =
        {
            {
                size = 64,
                filename = "__lilys-incendiaries__/graphics/icons/uranium-incendiary-rounds-magazine.png",
                scale = 0.5,
                mipmap_count = 4
            },
            {
                draw_as_light = true,
                size = 64,
                filename = "__base__/graphics/icons/uranium-rounds-magazine-light.png",
                scale = 0.5
            }
        }
    },
    icon = "__lilys-incendiaries__/graphics/icons/uranium-incendiary-rounds-magazine.png",
    ammo_category = "bullet",
    ammo_type =
    {
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "instant",
                source_effects =
                {
                    type = "create-explosion",
                    entity_name = "explosion-gunshot"
                },
                target_effects =
                {
                    {
                        type = "create-entity",
                        entity_name = "explosion-hit",
                        offsets = { { 0, 1 } },
                        offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } }
                    },
                    {
                        type = "damage",
                        damage = { amount = 24, type = "physical" }
                    },
                    {
                        type = "damage",
                        damage = { amount = 10, type = "fire" },
                        apply_damage_to_trees = false
                    },
                    {
                        type = "activate-impact",
                        deliver_category = "bullet"
                    },
                    {
                        type = "create-sticker",
                        sticker = "fire-sticker-uranium",
                        show_in_tooltip = true
                    },
                    {
                        type = "create-sticker",
                        sticker = "fire-sticker-uranium-rad",
                        show_in_tooltip = true
                    },
                    {
                        type = "create-fire",
                        entity_name = "fire-flame-uranium",
                        show_in_tooltip = true,
                        initial_ground_flame_count = 4
                    }
                }
            }
        },

    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "a[basic-clips]-d[uranium-rounds-magazine-incendiary]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_pickup,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 100,
    weight = 40 * kg
}

data:extend({ uranium_incendiary_mag })



data:extend(
    {
        -- recipe as an upgrade to uranium ammo
        {
            type = "recipe",
            name = "uranium-incendiary-rounds-magazine",
            category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
            subgroup = "ammo",
---@diagnostic disable-next-line: missing-fields
            recipe_tint = {
                primary = { r = 1.000, g = 0.835, b = 0.643, a = 1.000 }, -- #ffbba4ff
                secondary = { r = 0.749, g = 0.857, b = 0.490, a = 1.000 }, -- #bf8e7dff
                tertiary = { r = 0.637, g = 0.937, b = 0.637, a = 1.000 }, -- #a2a2a2ff
                quaternary = { r = 0.283, g = 0.883, b = 0.283, a = 1.000 }, -- #484848ff
            },
            allow_productivity = false,
            enabled = false,
            energy_required = 100,
            ingredients =
            {
                { type = "item", name = "uranium-rounds-magazine", amount = 10 },
                { type = "fluid", name = "crude-oil",       amount = 1000 },
                { type = "item", name = "sulfur",                  amount = 10 },
                { type = "item", name = "uranium-235",             amount = 1 }
            },
            results = { { type = "item", name = "uranium-incendiary-rounds-magazine", amount = 10 } }
        },

        -- recipe as an upgrade to uranium ammo
        {
            type = "recipe",
            name = "uranium-incendiary-rounds-magazine-2",
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
            energy_required = 100,
            ingredients =
            {
                { type = "item", name = "uranium-rounds-magazine", amount = 10 },
                { type = "fluid", name = "light-oil",       amount = 1000 },
                { type = "item", name = "sulfur",                  amount = 10 },
                { type = "item", name = "uranium-235",             amount = 1 }
            },
            results = { { type = "item", name = "uranium-incendiary-rounds-magazine", amount = 10 } }
        },

        -- alt recipe as an upgrade to incendiary ammo
        {
            type = "recipe",
            name = "uranium-incendiary-rounds-magazine-3",
            category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
            subgroup = "ammo",
---@diagnostic disable-next-line: missing-fields
            recipe_tint = {
                primary = { r = 1.000, g = 0.835, b = 0.643, a = 1.000 }, -- #ffbba4ff
                secondary = { r = 0.749, g = 0.857, b = 0.490, a = 1.000 }, -- #bf8e7dff
                tertiary = { r = 0.637, g = 0.937, b = 0.637, a = 1.000 }, -- #a2a2a2ff
                quaternary = { r = 0.283, g = 0.883, b = 0.283, a = 1.000 }, -- #484848ff
            },
            allow_productivity = false,
            enabled = false,
            energy_required = 100,
            ingredients =
            {
                { type = "item", name = "piercing-incendiary-rounds-magazine", amount = 10 },
                { type = "item", name = "uranium-238",                         amount = 10 },
                { type = "item", name = "uranium-235",                         amount = 1 }
            },
            results = { { type = "item", name = "uranium-incendiary-rounds-magazine", amount = 10 } }
        }
})


local tech = data.raw["technology"]["incendiary-uranium-ammo"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-incendiary-rounds-magazine"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-incendiary-rounds-magazine-2"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-incendiary-rounds-magazine-3"
})


