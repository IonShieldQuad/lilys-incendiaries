local item_sounds = require("__base__.prototypes.item_sounds")

local napalm_utils = require("prototypes.napalm-utils")

local napalm_boom = napalm_utils.make_napalm_boom(6, 200, {
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


-- uranium shell
local ushell = table.deepcopy(data.raw["ammo"]["explosive-uranium-cannon-shell"])

ushell.name = "uranium-napalm-cannon-shell"
ushell.icon = "__lilys-incendiaries__/graphics/icons/explosive-uranium-cannon-shell-incendiary.png"
ushell.order = ushell.order .. "-napalm"

ushell.ammo_type.action.action_delivery.projectile = "uranium-napalm-cannon-projectile"


-- uranium shell projectile
local uproj = {
    type = "projectile",
    name = "uranium-napalm-cannon-projectile",
    flags = { "not-on-map" },
    hidden = true,
    collision_box = { { -0.3, -1.1 }, { 0.3, 1.1 } },
    acceleration = 0,
    direction_only = true,
    piercing_damage = 150,
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
                    damage = { amount = 150, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 200, type = "fire" }
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
                    type = "nested-result",
                    action = napalm_boom
                },
                {
                    type = "create-entity",
                    entity_name = "medium-scorchmark-tintable",
                    check_buildability = true
                },
                {
                    type = "create-entity",
                    entity_name = "uranium-cannon-shell-explosion"
                },
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                },
                {
                    type = "destroy-decoratives",
                    from_render_layer = "decorative",
                    to_render_layer = "object",
                    include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                    include_decals = false,
                    invoke_decorative_trigger = true,
                    decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                    radius = 5.25                          -- large radius for demostrative purposes
                },
                {
                    type = "nested-result",
                    action = {
                        type = "area",
                        radius = 4.25,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "create-sticker",
                                    sticker = "fire-sticker-uranium",
                                    probability = 0.3
                                },
                                {
                                    type = "create-sticker",
                                    sticker = "fire-sticker-uranium-rad",
                                    probability = 0.6
                                }
                            }
                        }

                    }
                },
                {
                    type = "nested-result",
                    action = {
                        type = "cluster",
                        cluster_count = 8,
                        distance = 4,
                        distance_deviation = 4,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                type = "create-fire",
                                entity_name = "fire-flame-uranium",
                                probability = 0.5
                            }
                        }
                    }
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
        tint = { 0.8, 1, 0, 1 }
    }
}

data.extend({ ushell, uproj })


-- recipe
data:extend({
    {
        type = "recipe",
        name = "uranium-napalm-cannon-shell",
        category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
        subgroup = "ammo",
        ---@diagnostic disable-next-line: missing-fields
        recipe_tint = {
            primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 },    -- #ffbba4ff
            secondary = { r = 1.000, g = 0.557, b = 0.490, a = 1.000 },  -- #ff8e7dff
            tertiary = { r = 1.000, g = 0.637, b = 0.637, a = 1.000 },   -- #ffa2a2ff
            quaternary = { r = 1.000, g = 0.283, b = 0.283, a = 1.000 }, -- #ff4848ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 200,
        ingredients =
        {
            { type = "item",  name = "uranium-cannon-shell", amount = 10 },
            { type = "fluid", name = "light-oil",            amount = 2000 },
            { type = "fluid", name = "heavy-oil",            amount = 4000 },
            { type = "item",  name = "sulfur",               amount = 100 },
            { type = "item",  name = "uranium-235",          amount = 1 },
        },
        results = { { type = "item", name = "uranium-napalm-cannon-shell", amount = 10 } }
    }
})

-- recipe
data:extend({
    {
        type = "recipe",
        name = "uranium-napalm-cannon-shell-2",
        category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
        subgroup = "ammo",
        ---@diagnostic disable-next-line: missing-fields
        recipe_tint = {
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
            { type = "item", name = "napalm-cannon-shell", amount = 10 },
            { type = "item", name = "uranium-238",         amount = 10 },
            { type = "item", name = "uranium-235",         amount = 1 }
        },
        results = { { type = "item", name = "uranium-napalm-cannon-shell", amount = 10 } }
    }
})


local tech = data.raw["technology"]["incendiary-uranium-ammo"]

table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-napalm-cannon-shell"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-napalm-cannon-shell-2"
})
