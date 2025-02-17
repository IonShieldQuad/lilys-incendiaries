local item_sounds = require("__base__.prototypes.item_sounds")


-- standard shell
local shell = table.deepcopy(data.raw["ammo"]["cannon-shell"])

shell.name = "incendiary-cannon-shell"
shell.icon = "__lilys-incendiaries__/graphics/icons/cannon-shell-incendiary.png"
shell.order = shell.order .. "-incendiary"

shell.ammo_type.action.action_delivery.projectile = "incendiary-cannon-projectile"


-- standard shell projectile
local proj = {
    type = "projectile",
    name = "incendiary-cannon-projectile",
    flags = {"not-on-map"},
    hidden = true,
    collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
    acceleration = 0,
    direction_only = true,
    piercing_damage = 1000,
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
            damage = {amount = 1000 , type = "physical"}
          },
          {
            type = "damage",
            damage = {amount = 100 , type = "explosion"}
          },
          {
            type = "damage",
            damage = {amount = 500 , type = "fire"}
          },
          {
            type = "create-sticker",
            sticker = "fire-sticker",
            show_in_tooltip = true
          },
          {
            type = "create-fire",
            entity_name = "fire-flame",
            show_in_tooltip = true,
            initial_ground_flame_count = 8
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
      tint = {1, 0.5, 0, 1}
    }
}

data.extend({shell, proj})


-- recipe
data:extend({
    {
        type = "recipe",
        name = "incendiary-cannon-shell",
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
        energy_required = 10,
        ingredients =
        {
            { type = "item",  name = "cannon-shell", amount = 1 },
            { type = "fluid", name = "crude-oil",                amount = 200 },
            { type = "item",  name = "sulfur",                   amount = 4 }
        },
        results = { { type = "item", name = "incendiary-cannon-shell", amount = 1 } }
    }
})

-- recipe
data:extend({
    {
        type = "recipe",
        name = "incendiary-cannon-shell-2",
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
        energy_required = 10,
        ingredients =
        {
            { type = "item",  name = "cannon-shell", amount = 1 },
            { type = "fluid", name = "light-oil",    amount = 200 },
            { type = "item",  name = "sulfur",       amount = 4 }
        },
        results = { { type = "item", name = "incendiary-cannon-shell", amount = 1 } }
    }
})



tech = data.raw["technology"]["tank"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "incendiary-cannon-shell"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "incendiary-cannon-shell-2"
})
