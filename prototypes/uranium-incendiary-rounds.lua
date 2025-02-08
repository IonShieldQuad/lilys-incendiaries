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

-- fire sticker that sticks to enemies
local uranium_fire_sticker = table.deepcopy(data.raw["sticker"]["fire-sticker"])
uranium_fire_sticker.name = "fire-sticker-uranium"
uranium_fire_sticker.duration_in_ticks = uranium_fire_sticker.duration_in_ticks * 1.5
uranium_fire_sticker.damage_per_tick = { amount = 20 * 100 / 60, type = "fire" }
uranium_fire_sticker.animation.tint = { r = 0.4, g = 0.8, b = 0.15, a = 0.2 }
uranium_fire_sticker.target_movement_modifier= 0.7
uranium_fire_sticker.damage_interval = 5

data:extend({uranium_fire_sticker})


-- same but simulates them being irradiated
local uranium_fire_sticker_rad = table.deepcopy(data.raw["sticker"]["fire-sticker-uranium"])
uranium_fire_sticker_rad.name = "fire-sticker-uranium-rad"
uranium_fire_sticker_rad.duration_in_ticks = uranium_fire_sticker.duration_in_ticks * 5
if (data.raw["damage-type"]["radiation"] == nil) then
  uranium_fire_sticker_rad.damage_per_tick = { amount = 10 * 100 / 60, type = "poison" }
else
  uranium_fire_sticker_rad.damage_per_tick = { amount = 10 * 100 / 60, type = "radiation" }
end
uranium_fire_sticker_rad.animation.tint = { r = 0.1, g = 0.8, b = 0.0, a = 0.05 }
data:extend({ uranium_fire_sticker_rad })



-- fire that sticks around on map
-- very buffed compared to normal
local uranium_fire = table.deepcopy(data.raw["fire"]["fire-flame"])
uranium_fire.name = "fire-flame-uranium"
uranium_fire.damage_per_tick = { amount = 25 / 60, type = "fire" }
uranium_fire.emissions_per_second = { pollution = 0.05 }
uranium_fire.initial_lifetime = 600
uranium_fire.lifetime_increase_by = 1200
uranium_fire.lifetime_increase_cooldown = 2
uranium_fire.maximum_lifetime = 12000
if (uranium_fire.pictures ~= nil) then
    for i, pic in ipairs(uranium_fire.pictures) do
        pic.tint = { r = 0.3, g = 0.8, b = 0.1, a = 1 }
    end
end

data:extend({ uranium_fire })



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


-- technology
data:extend({
    {
        type = "technology",
        name = "incendiary-uranium-magazines",
        icon_size = 256,
        icon = "__lilys-incendiaries__/graphics/technology/uranium-incendiary-rounds-magazine.png",
        prerequisites = { "uranium-ammo", "incendiary-magazines" },
        unit = {
            count = 2000,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "military-science-pack",   1 },
                { "utility-science-pack",    1 }
            },
            time = 45
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "uranium-incendiary-rounds-magazine"
            },
            {
                type = "unlock-recipe",
                recipe = "uranium-incendiary-rounds-magazine-2"
            },
            {
                type = "unlock-recipe",
                recipe = "uranium-incendiary-rounds-magazine-3"
            }
        }
    }
})

        

