local item_sounds = require("__base__.prototypes.item_sounds")

local beam = table.deepcopy(data.raw["explosion"]["railgun-beam"])
beam.name = "uranium-incendiary-railgun-beam"
if beam.animations[0] then
    beam.animations[0].filename = "__lilys-incendiaries__/graphics/entity/uranium-incendiary-railgun-beam.png"
end
if beam.animations[1] then
    beam.animations[1].filename = "__lilys-incendiaries__/graphics/entity/uranium-incendiary-railgun-beam.png"
end
beam.light = {intensity = 4, size = 30, color = {r = 0.7, g = 1, b = 0.05}}

local item = table.deepcopy(data.raw["ammo"]["railgun-ammo"]) 
item.name = "uranium-incendiary-railgun-ammo"
item.icon = "__lilys-incendiaries__/graphics/icons/uranium-incendiary-railgun-ammo.png"
item.ammo_type = {
      target_type = "direction",
      clamp_position = true,
      action =
      {
        type = "line",
        range = 80,
        width = 1,
        range_effects =
        {
          type = "create-explosion",
            entity_name = "uranium-incendiary-railgun-beam"
        },
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
                {
                    type = "damage",
                    damage = {amount = 20000, type = "physical"}
                },
                {
                    type = "destroy-cliffs",
                    radius = 6,
                    explosion_at_cliff = "uranium-cannon-shell-explosion",
                    explosion_at_trigger = "uranium-cannon-shell-explosion",
                    show_in_tooltip = true
                },
                {
                    type = "damage",
                    damage = { amount = 10000, type = "fire" }
                },
                {
                    type = "nested-result",
                    action = {
                        type = "area",
                        radius = 6.25,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "damage",
                                    damage = { amount = 500, type = "fire" },
                                    apply_damage_to_trees = false,
                                    show_in_tooltip = true
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
                                }
                            }
                        }

                    }
                },
                {
                    type = "nested-result",
                    action = {
                        type = "cluster",
                        cluster_count = 20,
                        distance = 6,
                        distance_deviation = 4,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                type = "create-fire",
                                entity_name = "fire-flame-uranium",
                                show_in_tooltip = true
                            }
                        }
                    }
                },
                {
                    type = "nested-result",
                    action = {
                        type = "cluster",
                        cluster_count = 30,
                        distance = 12,
                        distance_deviation = 8,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                type = "create-fire",
                                entity_name = "fire-flame-uranium",
                                show_in_tooltip = true
                            }
                        }
                    }
                },
                --[[{
                    type = "nested-result",
                    action = table.deepcopy(data.raw["projectiles"]["explosive-uranium-cannon-projectile"]).final_action
                }--]]
          },
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          }
        }
      }
    }
item.subgroup = "ammo"
item.order = "e[railgun-ammo]-b[uranium-incendiary]"
item.inventory_move_sound = item_sounds.ammo_large_inventory_move
item.pick_sound = item_sounds.ammo_large_inventory_pickup
item.drop_sound = item_sounds.ammo_large_inventory_move
item.stack_size = 1
item.weight = 1000 * kg

data:extend({beam, item})


-- recipe
data:extend({
    {
        type = "recipe",
        name = "uranium-incendiary-railgun-ammo",
        category = "chemistry-or-cryogenics",
        subgroup = "ammo",
        crafting_machine_tint = {
            primary = { r = 0.800, g = 1.000, b = 0.643, a = 1.000 },    -- #bbffa4ff
            secondary = { r = 0.800, g = 1.000, b = 0.490, a = 1.000 },  -- #bbff7dff
            tertiary = { r = 0.800, g = 1.000, b = 0.637, a = 1.000 },   -- #bbffa2ff
            quaternary = { r = 1.800, g = 1.000, b = 0.283, a = 1.000 }, -- #bbff48ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 200,
        ingredients =
        {
            { type = "item",  name = "railgun-ammo", amount = 10 },
            { type = "fluid", name = "lilys-napalm-mix",            amount = 2000 },
            { type = "fluid", name = "heavy-oil",            amount = 4000 },
            { type = "fluid", name = "fluoroketone-cold",    amount = 1000 },
            { type = "item",  name = "sulfur",               amount = 100 },
            { type = "item",  name = "uranium-238",          amount = 500 },
            { type = "item",  name = "uranium-235",          amount = 50 },
        },
        results = { { type = "item", name = "uranium-incendiary-railgun-ammo", amount = 1 } }
    }
})


local tech = data.raw["technology"]["incendiary-uranium-ammo"]

table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "uranium-incendiary-railgun-ammo"
})
