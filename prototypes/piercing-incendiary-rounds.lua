local item_sounds = require("__base__.prototypes.item_sounds")


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
      order = "a[basic-clips]-c[piercing-rounds-magazine-incendiary]",
      inventory_move_sound = item_sounds.ammo_small_inventory_move,
      pick_sound = item_sounds.ammo_small_inventory_pickup,
      drop_sound = item_sounds.ammo_small_inventory_move,
      stack_size = 100,
      weight = 20 * kg
}

data:extend({incendiary_mag})


-- recipe
data:extend({
    {
        type = "recipe",
        name = "piercing-incendiary-rounds-magazine",
        category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
        subgroup = "ammo",
        ---@diagnostic disable-next-line: missing-fields
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
            { type = "item", name = "piercing-rounds-magazine", amount = 1 },
            { type = "fluid", name = "crude-oil",        amount = 100 },
            { type = "item", name = "sulfur",                   amount = 1 }
        },
        results = { { type = "item", name = "piercing-incendiary-rounds-magazine", amount = 1 } }
    }
})

-- recipe
data:extend({
  {
    type = "recipe",
    name = "piercing-incendiary-rounds-magazine-2",
    category = (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry"),
    subgroup = "ammo",
    ---@diagnostic disable-next-line: missing-fields
    recipe_tint = {
      primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 },          -- #ffbba4ff
      secondary = { r = 0.749, g = 0.557, b = 0.490, a = 1.000 },        -- #bf8e7dff
      tertiary = { r = 0.637, g = 0.637, b = 0.637, a = 1.000 },         -- #a2a2a2ff
      quaternary = { r = 0.283, g = 0.283, b = 0.283, a = 1.000 },       -- #484848ff
    },
    allow_productivity = false,
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      { type = "item",  name = "piercing-rounds-magazine", amount = 1 },
      { type = "fluid", name = "light-oil",                amount = 100 },
      { type = "item",  name = "sulfur",                   amount = 1 }
    },
    results = { { type = "item", name = "piercing-incendiary-rounds-magazine", amount = 1 } }
  }
})

--technology
data.extend({
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
      },
      {
        type = "unlock-recipe",
          recipe = "piercing-incendiary-rounds-magazine-2"
      }
    }
    }
})