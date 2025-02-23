local item_sounds = require("__base__.prototypes.item_sounds")


--  basic fire mag item
local incendiary_shells = {
    type = "ammo",
    name = "piercing-incendiary-shotgun-shell",
    icon = "__lilys-incendiaries__/graphics/icons/piercing-incendiary-shotgun-shell.png",
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
                    projectile = "incendiary-shotgun-pellet",
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
    order = "b[shotgun]-c[piercing-incendiary]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_pickup,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 100,
    weight = 20 * kg
}

data:extend({ incendiary_shells })


local incendiary_shot = {
    type = "projectile",
    name = "incendiary-shotgun-pellet",
    flags = { "not-on-map" },
    hidden = true,
    collision_box = { { -0.05, -0.25 }, { 0.05, 0.25 } },
    acceleration = 0,
    direction_only = true,
    piercing_damage = 200,
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
                    damage = { amount = 8, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 4, type = "fire" }
                },
            }
        },
        {
            type = "direct",
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
        tint = { 1.0, 0.6, 0.0, 1 }
    },
    light = { size = 5, intensity = 2, tint = {1, 0.6, 0, 1} }
}

data.extend({incendiary_shot})
if not settings.startup["enable-alt-recipes"].value then
-- recipe
data:extend({
    {
        type = "recipe",
        name = "piercing-incendiary-shotgun-shell",
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
        energy_required = 8,
        ingredients =
        {
            { type = "item",  name = "piercing-shotgun-shell", amount = 1 },
            { type = "fluid", name = "crude-oil",                amount = 100 },
            { type = "item",  name = "sulfur",                   amount = 1 }
        },
        results = { { type = "item", name = "piercing-incendiary-shotgun-shell", amount = 1 } }
    }
})


-- recipe
data:extend({
    {
        type = "recipe",
        name = "piercing-incendiary-shotgun-shell-2",
        category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
        subgroup = "ammo",
        crafting_machine_tint = {
            primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 }, -- #ffbba4ff
            secondary = { r = 0.749, g = 0.557, b = 0.490, a = 1.000 }, -- #bf8e7dff
            tertiary = { r = 0.637, g = 0.637, b = 0.637, a = 1.000 }, -- #a2a2a2ff
            quaternary = { r = 0.283, g = 0.283, b = 0.283, a = 1.000 }, -- #484848ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 8,
        ingredients =
        {
            { type = "item",  name = "piercing-shotgun-shell", amount = 1 },
            { type = "fluid", name = "light-oil",                amount = 100 },
            { type = "item",  name = "sulfur",                   amount = 1 }
        },
        results = { { type = "item", name = "piercing-incendiary-shotgun-shell", amount = 1 } }
    }
})
else
    -- recipe
    data:extend({
        {
            type = "recipe",
            name = "piercing-incendiary-shotgun-shell",
            category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
            subgroup = "ammo",
            crafting_machine_tint = {
                primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 }, -- #ffbba4ff
                secondary = { r = 0.749, g = 0.557, b = 0.490, a = 1.000 }, -- #bf8e7dff
                tertiary = { r = 0.637, g = 0.637, b = 0.637, a = 1.000 }, -- #a2a2a2ff
                quaternary = { r = 0.283, g = 0.283, b = 0.283, a = 1.000 }, -- #484848ff
            },
            allow_productivity = false,
            enabled = false,
            energy_required = 8,
            ingredients =
            {
                { type = "item",  name = "piercing-shotgun-shell", amount = 1 },
                { type = "item", name = "coal",              amount = 1 },
                { type = "item",  name = "sulfur",                 amount = 2 }
            },
            results = { { type = "item", name = "piercing-incendiary-shotgun-shell", amount = 1 } }
        }
    })

end




--technology
data.extend({
    -- technology
    {
        type = "technology",
        name = "piercing-incendiary-shotgun-shells",
        icon_size = 256,
        icon = "__lilys-incendiaries__/graphics/technology/incendiary-rounds-magazine.png",
        prerequisites = { "incendiary-magazines", "military-4" },
        unit =
        {
            count = 400,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 }
            },
            time = 20
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "piercing-incendiary-shotgun-shell"
            }
        }
    }
})

if not settings.startup["enable-alt-recipes"].value then
    table.insert(data.raw["technology"]["piercing-incendiary-shotgun-shells"].effects, 
    {
        type = "unlock-recipe",
        recipe = "piercing-incendiary-shotgun-shell-2"
    })
end



local uranium_incendiary = data.raw["technology"]["incendiary-uranium-ammo"]
table.insert(uranium_incendiary.prerequisites, "piercing-incendiary-shotgun-shells")

