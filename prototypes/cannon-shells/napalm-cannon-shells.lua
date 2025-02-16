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



-- standard shell
local shell = table.deepcopy(data.raw["ammo"]["explosive-cannon-shell"])

shell.name = "napalm-cannon-shell"
shell.icon = "__lilys-incendiaries__/graphics/icons/explosive-cannon-shell-incendiary.png"
shell.order = shell.order .. "-napalm"

shell.ammo_type.action.action_delivery.projectile = "napalm-cannon-projectile"


-- standard shell projectile
local proj = {
    type = "projectile",
    name = "napalm-cannon-projectile",
    flags = { "not-on-map" },
    hidden = true,
    collision_box = { { -0.3, -1.1 }, { 0.3, 1.1 } },
    acceleration = 0,
    direction_only = true,
    piercing_damage = 100,
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
                    damage = { amount = 80, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 100, type = "fire" }
                },
                {
                    type = "create-entity",
                    entity_name = "explosion"
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
                type = "nested-result",
                action = napalm_boom
            },
            {
                type = "create-entity",
                entity_name = "medium-scorchmark-tintable",
                check_buildability = true
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
                radius = 4                             -- large radius for demostrative purposes
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
        tint = { 1, 0.3, 0, 1 }
    }
}

data.extend({ shell, proj })


-- recipe
data:extend({
    {
        type = "recipe",
        name = "napalm-cannon-shell",
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
        energy_required = 10,
        ingredients =
        {
            { type = "item",  name = "cannon-shell", amount = 1 },
            { type = "fluid", name = "light-oil",    amount = 200 },
            { type = "fluid", name = "heavy-oil",    amount = 400 },
            { type = "item",  name = "sulfur",       amount = 10 }
        },
        results = { { type = "item", name = "napalm-cannon-shell", amount = 1 } }
    }
})

local tech = data.raw["technology"]["tank"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "napalm-cannon-shell"
})

