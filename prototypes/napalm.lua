require("__lilys-incendiaries__/prototypes/napalm-im.lua")
require("__lilys-incendiaries__/prototypes/explosion-im.lua")


--napalm fluid
local napalm = {
    type = "fluid",
    name = "napalm",
    icon = "__lilys-incendiaries__/graphics/icons/napalm.png",
    subgroup = "fluid",
    default_temperature = 30,
    max_temperature = 100,
    base_color = { 0.408, 0.290, 0.231, 1 }, --#684a3b
    flow_color = { 0.694, 0.573, 0.482, 1 }, --#b1927b
    heat_capacity = "4kJ",
    emissions_multiplier = 5
}

data:extend({napalm})

-- recipe
data:extend({
    {
        type = "recipe",
        name = "napalm",
        subgroup = "fluid-recipes",
        category = "chemistry",
        allow_productivity = true,
        enabled = false,
        energy_required = 10,
        crafting_machine_tint = {
            primary = {r = 1.000, g = 0.642, b = 0.261, a = 1.000}, -- #ffa342ff
            secondary = {r = 0.408, g = 0.290, b = 0.231, a = 1.000},
            tetriary = {r = 0.694, y = 0.573, b = 0.482, a = 1.000 },
            quaternary = {r = 0.0, y = 0.0, b = 0.0, a = 1.000 }
        },
        ingredients =
        {
            { type = "fluid", name = "light-oil", amount = 100 },
            { type = "item", name = "coal",       amount = 10 },
            { type = "item",  name = "sulfur",    amount = 5 }
        },
        results = { { type = "fluid", name = "napalm", amount = 100 } }
    }
})

data.extend({
    -- technology
    {
        type = "technology",
        name = "napalm",
        icon_size = 256,
        icon = "__lilys-incendiaries__/graphics/technology/napalm.png",
        prerequisites = { "flammables", "military-science-pack", "chemical-science-pack" },
        unit =
        {
            count = 200,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
            },
            time = 30
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "napalm"
            }
        }
    }
})

local t = data.raw["technology"]["incendiary-uranium-ammo"]
table.insert(t.prerequisites, "napalm")

local t2 = data.raw["technology"]["burny-explosive-rocketry"]
table.insert(t2.prerequisites, "napalm")