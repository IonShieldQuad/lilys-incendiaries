local armor = table.deepcopy(data.raw["armor"]["mech-armor"])
armor.name = "mech-armor-fireproof"
armor.icon = "__lilys-incendiaries__/graphics/icons/mech-armor-fireproof.png"

for _, res in ipairs(armor.resistances) do
    if (res.type == "fire") then
        res.percent = 100
    else
      res.percent = res.percent + 10
      res.decrease = res.decrease + 10
    end
end

armor.order = armor.order .. "fireproof"

data:extend({armor})

-- recipe
data:extend({
    {
        type = "recipe",
        name = "mech-armor-fireproof",
        category = "cryogenics",
        subgroup = "armor",
        allow_productivity = false,
        allow_quality = false,
        enabled = false,
        energy_required = 60,
        main_product = "mech-armor-fireproof",
        ingredients =
        {
            { type = "item",  name = "mech-armor", amount = 1 },
            { type = "item", name = "tungsten-carbide",              amount = 200 },
            { type = "item", name = "tungsten-plate",              amount = 100 },
            { type = "item",  name = "low-density-structure",                 amount = 100 },
            { type = "item", name = "plastic-bar", amount = 100 },
            { type = "fluid", name = "fluoroketone-cold", amount = 5000 }
        },
        results = { { type = "item", name = "mech-armor-fireproof", amount = 1 },
                    {type ="fluid", name = "fluoroketone-hot", amount = 2000} }
    },
    {
      type = "recipe",
      name = "mech-armor-fireproof-disassembly",
      category = "advanced-crafting",
      subgroup = "armor",
      icons = {
        {
            icon = "__lilys-incendiaries__/graphics/icons/mech-armor-fireproof.png"
        },
        {
            icon = "__lilys-incendiaries__/graphics/icons/signal-deny.png"
        }
      },
      allow_productivity = false,
      allow_quality = false,
      enabled = false,
      energy_required = 60,
      main_product = "mech-armor",
      ingredients =
      {
        { type = "item", name = "mech-armor-fireproof", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 2000 }
      },
      results = { 
        { type = "item", name = "mech-armor",            amount = 1 },
        { type = "item", name = "tungsten-carbide",      amount = 200 },
        { type = "item", name = "tungsten-plate",        amount = 100 },
        { type = "item", name = "low-density-structure", amount = 100 },
        { type = "item", name = "plastic-bar",           amount = 100 },
        {type ="fluid", name = "fluoroketone-hot", amount = 5000} }
    }
})

data.extend({
    -- technology
    {
    type = "technology",
    name = "mech-armor-fireproof",
    icon = "__lilys-incendiaries__/graphics/technology/mech-armor-fireproof.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "mech-armor-fireproof"
      },
      {
        type = "unlock-recipe",
        recipe = "mech-armor-fireproof-disassembly"
      }
    },
    prerequisites = {"mech-armor", "metallurgic-science-pack"},
    unit =
    {
      count = 10000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"metallurgic-science-pack", 1}
      },
      time = 60
    }
  },
})
