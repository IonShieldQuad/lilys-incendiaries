local item_sounds = require("__base__.prototypes.item_sounds")




-- uranium shell
local ushell = table.deepcopy(data.raw["ammo"]["uranium-cannon-shell"])

ushell.name = "uranium-incendiary-cannon-shell"
ushell.icon = "__lilys-incendiaries__/graphics/icons/uranium-cannon-shell-incendiary.png"
ushell.order = ushell.order .. "-incendiary"

ushell.ammo_type.action.action_delivery.projectile = "uranium-incendiary-cannon-projectile"


-- uranium shell projectile
local uproj = {
    type = "projectile",
    name = "uranium-incendiary-cannon-projectile",
    flags = { "not-on-map" },
    hidden = true,
    collision_box = { { -0.3, -1.1 }, { 0.3, 1.1 } },
    acceleration = 0,
    direction_only = true,
    piercing_damage = 2200,
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "damage",
                    damage = { amount = 2000, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 200, type = "explosion" }
                },
                {
                    type = "damage",
                    damage = { amount = 1000, type = "fire" }
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
                    initial_ground_flame_count = 8
                },
                {
                    type = "create-entity",
                    entity_name = "uranium-cannon-explosion"
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
                    type = "create-entity",
                    entity_name = "small-scorchmark-tintable",
                    check_buildability = true
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
        tint = { 0.5, 1, 0, 1 }
    }
}

data.extend({ ushell, uproj })




-- recipe
data:extend({
    {
        type = "recipe",
        name = "uranium-incendiary-cannon-shell",
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
        energy_required = 200,
        ingredients =
        {
            { type = "item",  name = "uranium-cannon-shell", amount = 10 },
            { type = "fluid", name = "crude-oil",            amount = 2000 },
            { type = "item",  name = "sulfur",               amount = 40 },
            { type = "item",  name = "uranium-235",          amount = 1 }
        },
        results = { { type = "item", name = "uranium-incendiary-cannon-shell", amount = 10 } }
    }
})

-- recipe
data:extend({
    {
        type = "recipe",
        name = "uranium-incendiary-cannon-shell-2",
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
        energy_required = 200,
        ingredients =
        {
            { type = "item",  name = "uranium-cannon-shell", amount = 10 },
            { type = "fluid", name = "light-oil",            amount = 2000 },
            { type = "item",  name = "sulfur",               amount = 40 },
            { type = "item",  name = "uranium-235",          amount = 1 }
        },
        results = { { type = "item", name = "uranium-incendiary-cannon-shell", amount = 10 } }
    }
})

-- recipe
data:extend({
    {
        type = "recipe",
        name = "uranium-incendiary-cannon-shell-3",
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
        energy_required = 20,
        ingredients =
        {
            { type = "item", name = "incendiary-cannon-shell", amount = 10 },
            { type = "item", name = "uranium-238",             amount = 10 },
            { type = "item", name = "uranium-235",             amount = 1 }
        },
        results = { { type = "item", name = "uranium-incendiary-cannon-shell", amount = 10 } }
    }
})

local tech = data.raw["technology"]["incendiary-uranium-ammo"]

table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-incendiary-cannon-shell"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-incendiary-cannon-shell-2"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-incendiary-cannon-shell-3"
})
