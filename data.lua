
local tech = require("__space-age__.prototypes.technology")
local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")
local explosion_animations = require("__base__.prototypes.entity.explosion-animations")



--  basic fire mag item
local incendiary_mag = {
      type = "ammo",
      name = "piercing-incendiary-rounds-magazine",
      icon = "__lilys-incendiaries__/graphics/icons/incendiary-rounds-magazine.png",
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
                damage = { amount = 8, type = "physical" }
              },
              {
                type = "activate-impact",
                deliver_category = "bullet"
              },
              {
                type = "create-sticker",
                sticker = "fire-sticker",
                show_in_tooltip = true
              },
              {
                type = "damage",
                damage = { amount = 2, type = "fire" },
                apply_damage_to_trees = false
              },
              {
                type = "create-fire",
                entity_name = "fire-flame",
                show_in_tooltip = true,
                initial_ground_flame_count = 2
              }
            }
          }
        },
--[[        {
          type = "area",
          radius = 2.5,
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              {
                type = "create-sticker",
                sticker = "fire-sticker",
                show_in_tooltip = true
              },
              {
                type = "damage",
                damage = { amount = 2, type = "fire" },
                apply_damage_to_trees = false
              }
            }
          }
        },
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              {
                type = "create-fire",
                entity_name = "fire-flame",
                show_in_tooltip = true,
                initial_ground_flame_count = 2
              }
            }
          }
        }--]]
      },
      magazine_size = 10,
      subgroup = "ammo",
      order = "a[basic-clips]-b[piercing-incendiary-rounds-magazine]",
      inventory_move_sound = item_sounds.ammo_small_inventory_move,
      pick_sound = item_sounds.ammo_small_inventory_pickup,
      drop_sound = item_sounds.ammo_small_inventory_move,
      stack_size = 100,
      weight = 20 * kg
}

data:extend({incendiary_mag})


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
  icon = "__lilys-incendiaries__/",
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
            type = "activate-impact",
            deliver_category = "bullet"
          },
          {
            type = "create-sticker",
            sticker = "fire-sticker",
            show_in_tooltip = true
          },
          {
            type = "damage",
            damage = { amount = 10, type = "fire" },
            apply_damage_to_trees = false
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
  order = "a[basic-clips]-c[uranium-incendiary-rounds-magazine]",
  inventory_move_sound = item_sounds.ammo_small_inventory_move,
  pick_sound = item_sounds.ammo_small_inventory_pickup,
  drop_sound = item_sounds.ammo_small_inventory_move,
  stack_size = 100,
  weight = 40 * kg
}

data:extend({ uranium_incendiary_mag })

local uranium_fire_sticker = data.raw.deepcopy("fire-flame")
uranium_fire_sticker.name = "fire-flame-uranium"
uranium_fire_sticker.duration_in_ticks = uranium_fire_sticker.duration_in_ticks * 2
uranium_fire_sticker.damage_per_tick = { { amount = 20 * 100 / 60, type = "fire" }, { amount = 20 * 100 / 60, type = "radiation" } }
uranium_fire_sticker.animation.tint = { r = 0.5, g = 0.8, b = 0.0, a = 0.2 }
uranium_fire_sticker.target_movement_modifier= 0.7

data:extend({uranium_fire_sticker})


data:extend(
{
  -- recipe
  {
    type = "recipe",
    name = "piercing-incendiary-rounds-magazine",
    category = "chemistry-or-cryogenics",
    subgroup = "ammo",
      recipe_tint = {
        primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 }, -- #ffbba4ff
        secondary = { r = 0.749, g = 0.557, b = 0.490, a = 1.000 }, -- #bf8e7dff
        tertiary = { r = 0.637, g = 0.637, b = 0.637, a = 1.000 }, -- #a2a2a2ff
        quaternary = { r = 0.283, g = 0.283, b = 0.283, a = 1.000 }, -- #484848ff
      },
    allow_productivity = false,
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type = "item", name = "piercing-rounds-magazine", amount = 1},
      {type = "item", name = "flamethrower-ammo", amount = 1},
      { type = "item", name = "sulfur", amount = 1 }
    },
    results = {{type="item", name="piercing-incendiary-rounds-magazine", amount=1}}
  },
    -- recipe
    {
      type = "recipe",
      name = "uranium-incendiary-rounds-magazine",
      category = "chemistry-or-cryogenics",
      subgroup = "ammo",
      recipe_tint = {
        primary = { r = 1.000, g = 0.835, b = 0.643, a = 1.000 },    -- #ffbba4ff
        secondary = { r = 0.749, g = 0.857, b = 0.490, a = 1.000 },  -- #bf8e7dff
        tertiary = { r = 0.637, g = 0.937, b = 0.637, a = 1.000 },   -- #a2a2a2ff
        quaternary = { r = 0.283, g = 0.883, b = 0.283, a = 1.000 }, -- #484848ff
      },
      allow_productivity = false,
      enabled = false,
      energy_required = 10,
      ingredients =
      {
        { type = "item", name = "uranium-rounds-magazine", amount = 1 },
        { type = "item", name = "flamethrower-ammo",        amount = 1 },
        { type = "item", name = "sulfur",                   amount = 1 }
      },
      results = { { type = "item", name = "uranium-incendiary-rounds-magazine", amount = 1 } }
    },

    -- recipe
    {
      type = "recipe",
      name = "uranium-incendiary-rounds-magazine-2",
      category = "chemistry-or-cryogenics",
      subgroup = "ammo",
      recipe_tint = {
        primary = { r = 1.000, g = 0.835, b = 0.643, a = 1.000 },    -- #ffbba4ff
        secondary = { r = 0.749, g = 0.857, b = 0.490, a = 1.000 },  -- #bf8e7dff
        tertiary = { r = 0.637, g = 0.937, b = 0.637, a = 1.000 },   -- #a2a2a2ff
        quaternary = { r = 0.283, g = 0.883, b = 0.283, a = 1.000 }, -- #484848ff
      },
      allow_productivity = false,
      enabled = false,
      energy_required = 10,
      ingredients =
      {
        { type = "item", name = "piercing-incendiary-rounds-magazine", amount = 1 },
        { type = "item", name = "uranium-238", amount = 1 }
      },
      results = { { type = "item", name = "uranium-incendiary-rounds-magazine", amount = 1 } }
    },


  -- technology
  {
    type = "technology",
    name = "incendiary-magazines",
    icon_size = 256,
    icon = "__lilys-incendiaries__/graphics/technology/incendiary-rounds-magazine.png",
    prerequisites = {"flamethrower", "military-2", "military-science-pack"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack",   1},
        {"logistic-science-pack",     1},
        {"military-science-pack",     1}
      },
      time = 20
    },
    effects =
    {
      {
        type = "unlock-recipe",
          recipe = "piercing-incendiary-rounds-magazine"
      }
    }
    }, 
    {
    type = "technology",
    name = "incendiary-uranium-magazines",
    icon_size = 256,
    icon = "__lilys-incendiaries__/graphics/technology/uranium-incendiary-rounds-magazine.png",
    prerequisites = { "uranium-ammo,", "incendiary-magazines" },
    {
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
          recipe = "uranium-incendiary-rounds-magazine-2"
      },
        {
          type = "unlock-recipe",
          recipe = "uranium-incendiary-rounds-magazine"
        }
    }
  }
})