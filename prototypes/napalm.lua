require("__lilys-incendiaries__/prototypes/napalm-im.lua")
require("__lilys-incendiaries__/prototypes/explosion-im.lua")

local item_sounds = require("__base__.prototypes.item_sounds")

local napalm_boom = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "create-fire",
                entity_name = "napalm-flame",
                initial_ground_flame_count = 4
            },
            {
                type = "create-sticker",
                sticker = "napalm-sticker"
            },
            {
                type = "play-sound",
                sound = {
                        category = "explosion",
                        volume = 2,
                        filename = "__lilys-incendiaries__/sounds/fiery-explosion.ogg"
                    }
            },
            {
                type = "create-entity",
                entity_name = "fiery-explosion"
            },
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 6,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 200, type = "fire" },
                                apply_damage_to_trees = false
                            },
                            {
                                type = "create-sticker",
                                sticker = "napalm-sticker",
                                show_in_tooltip = true
                            },
                        }
                    }
                }
            },
            {
                type = "nested-result",
                action = {
                    type = "cluster",
                    distance = 5,
                    distance_deviation = 4,
                    cluster_count = 10,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            type = "create-fire",
                            entity_name = "napalm-flame",
                            show_in_tooltip = true
                        }
                    }
                }
            },
            {
                type = "nested-result",
                action = {
                    type = "cluster",
                    distance = 2,
                    distance_deviation = 4,
                    cluster_count = 10,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            type = "create-fire",
                            entity_name = "napalm-flame",
                            show_in_tooltip = true
                        }
                    }
                }
            }
            
        }
    }
}



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
            damage = {amount = 80, type = "physical"}
          },
          {
            type = "damage",
            damage = {amount = 100, type = "fire"}
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


-- uranium shell
local ushell = table.deepcopy(data.raw["ammo"]["explosive-uranium-cannon-shell"])

ushell.name = "uranium-napalm-cannon-shell"
ushell.icon = "__lilys-incendiaries__/graphics/icons/explosive-uranium-cannon-shell-incendiary.png"
ushell.order = shell.order .. "-napalm"

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
                    radius = 5.25                  -- large radius for demostrative purposes
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
                type = "nested-result",
                action = napalm_boom
            },
            {
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
            { type = "item",  name = "rocket", amount = 1 },
            { type = "fluid", name = "light-oil",    amount = 200 },
            { type = "fluid", name = "heavy-oil",    amount = 400 },
            { type = "item",  name = "sulfur",       amount = 10 }
        },
        results = { { type = "item", name = "napalm-missile", amount = 1 } }
    }
})




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
            { type = "fluid", name = "light-oil",                      amount = 2000 },
            { type = "fluid", name = "heavy-oil",                      amount = 4000 },
            { type = "item",  name = "sulfur",                         amount = 100 },
            { type = "item",  name = "uranium-235",                    amount = 1 },
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
            { type = "item",  name = "napalm-cannon-shell", amount = 10 },
            { type = "item",  name = "uranium-238",          amount = 10 },
            { type = "item", name = "uranium-235",         amount = 1 }
        },
        results = { { type = "item", name = "uranium-napalm-cannon-shell", amount = 10 } }
    }
})


tech = data.raw["technology"]["incendiary-uranium-ammo"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "napalm-cannon-shell"
})

table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-napalm-cannon-shell"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-napalm-cannon-shell-2"
})

local ber_tech = data.raw["technology"]["burny-explosive-rocketry"]
table.insert(ber_tech.effects, {
    type = "unlock-recipe",
    recipe = "napalm-missile"
})