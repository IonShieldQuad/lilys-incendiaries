local item_sounds = require("__base__.prototypes.item_sounds")

local napalm_utils = require("prototypes.napalm-utils")

local napalm_boom = napalm_utils.make_napalm_boom(8, 500, {
    {
        distance = 2,
        distance_deviation = 4,
        cluster_count = 12
    },
    {
        distance = 6,
        distance_deviation = 4,
        cluster_count = 16
    },
    {
        distance = 10,
        distance_deviation = 4,
        cluster_count = 20
    }
})

local item = {
    type = "ammo",
    name = "li-napalm-artillery-shell",
    icon = "__lilys-incendiaries__/graphics/icons/napalm-artillery-shell-icon.png",
    ammo_category = "artillery-shell",
    ammo_type =
    {
      target_type = "position",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "artillery",
          projectile = "li-napalm-artillery-projectile",
          starting_speed = 1,
          direction_deviation = 0,
          range_deviation = 0,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "artillery-cannon-muzzle-flash"
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[explosive-cannon-shell]-d[artillery]-napalm",
    inventory_move_sound = item_sounds.artillery_large_inventory_move,
    pick_sound = item_sounds.artillery_large_inventory_pickup,
    drop_sound = item_sounds.artillery_large_inventory_move,
    stack_size = 1,
    weight = 100*kg
  }

local shell = {
    type = "artillery-projectile",
    name = "li-napalm-artillery-projectile",
    flags = { "not-on-map" },
    hidden = true,
    reveal_map = true,
    map_color = { 1, 1, 0 },
    picture =
    {
        filename = "__lilys-incendiaries__/graphics/entity/arti/napalm-artillery-shell.png",
        draw_as_glow = true,
        width = 64,
        height = 64,
        scale = 0.5
    },
    shadow =
    {
        filename = "__lilys-incendiaries__/graphics/entity/arti/shell-shadow.png",
        width = 64,
        height = 64,
        scale = 0.5
    },
    chart_picture =
    {
        filename = "__lilys-incendiaries__/graphics/entity/arti/napalm-artillery-shoot-map-visualization.png",
        flags = { "icon" },
        width = 64,
        height = 64,
        priority = "high",
        scale = 0.25
    },
    action =
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
                    type = "nested-result",
                    action = {
                        type = "cluster",
                        cluster_count = 3,
                        distance = 12,
                        distance_deviation = 4,
                        action_delivery = 
                        {
                            type = "projectile",
                            projectile = "li-napalm-artillery-projectile-cluster",
                            starting_speed = 0.5
                        }
                    }

                }, 
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        radius = 2.0,
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "damage",
                                    damage = { amount = 1000, type = "physical" }
                                }
                            }
                        }
                    }
                },
                {
                    type = "create-trivial-smoke",
                    smoke_name = "artillery-smoke",
                    initial_height = 0,
                    speed_from_center = 0.05,
                    speed_from_center_deviation = 0.005,
                    offset_deviation = { { -4, -4 }, { 4, 4 } },
                    max_radius = 3.5,
                    repeat_count = 4 * 4 * 15
                },
                {
                    type = "create-entity",
                    entity_name = "big-artillery-explosion"
                },
                {
                    type = "show-explosion-on-chart",
                    scale = 16 / 32
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
                    radius = 6.5                 -- large radius for demostrative purposes
                }
            }
        }
    },
    height_from_ground = 280 / 64
}

local cluster = {
    type = "projectile",
    name = "li-napalm-artillery-projectile-cluster",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0,
    action = napalm_boom,
    animation =
    {
        filename = "__base__/graphics/entity/bullet/bullet.png",
        draw_as_glow = true,
        width = 3,
        height = 50,
        priority = "high",
        tint = { 1, 0.3, 0, 1 },
        scale = 2
    }
}


data:extend({item, shell, cluster})

data:extend({ {
    type = "recipe",
    name = "li-napalm-artillery-shell",
    category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
    enabled = false,
    energy_required = 30,
    ingredients =
    {
        { type = "item", name = "artillery-shell", amount = 1 },
        { type = "item",  name = "napalm-cannon-shell",          amount = 3 },
        { type = "fluid", name = "heavy-oil",             amount = 1000 },
        { type = "fluid", name = "lilys-napalm-mix",             amount = 500 },
        { type = "item",  name = "sulfur", amount = 20 }
    },
    results = { { type = "item", name = "li-napalm-artillery-shell", amount = 1 } }
} })


local tech = data.raw["technology"]["burny-explosive-rocketry"]

table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "li-napalm-artillery-shell"
})