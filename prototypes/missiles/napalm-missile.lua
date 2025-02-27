local item_sounds = require("__base__.prototypes.item_sounds")
local napalm_utils = require("prototypes.napalm-utils")

local napalm_boom = napalm_utils.make_napalm_boom(8, 25, {
    {
        distance = 3,
        distance_deviation = 6,
        cluster_count = 16
    },
    {
        distance = 6,
        distance_deviation = 6,
        cluster_count = 16
    }
})


local napalm_missile_item = {
    type = "ammo",
    name = "napalm-missile",
    icon = "__lilys-incendiaries__/graphics/icons/napalm-missile.png",
    ammo_category = "rocket",
    ammo_type =
    {
        target_type = "entity",
        action = {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "napalm-missile",
                starting_speed = 0.1,
                source_effects =
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-d[napalm]",
    inventory_move_sound = item_sounds.ammo_large_inventory_move,
    pick_sound = item_sounds.ammo_large_inventory_pickup,
    drop_sound = item_sounds.ammo_large_inventory_move,
    stack_size = 100,
    weight = 40 * kg
}
data:extend({ napalm_missile_item })

--entity
local napalm_missile = table.deepcopy(data.raw["projectile"]["rocket"])
napalm_missile.name = "napalm-missile"
napalm_missile.action = {
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
                    radius = 4 -- large radius for demostrative purposes
                }
            }
        }
    }
napalm_missile.animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({ 1.0, 0.3, 0.0 })

data:extend({ napalm_missile })


-- recipe
data:extend({
    {
        type = "recipe",
        name = "napalm-missile",
        category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
        subgroup = "ammo",
        crafting_machine_tint = {
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
            { type = "item",  name = "rocket",    amount = 1 },
            { type = "fluid", name = "lilys-napalm-mix", amount = 200 },
        },
        results = { { type = "item", name = "napalm-missile", amount = 1 } }
    }
})

local tech = data.raw["technology"]["burny-explosive-rocketry"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "napalm-missile"
})