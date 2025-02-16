
-- technology
data:extend({
    {
        type = "technology",
        name = "incendiary-uranium-ammo",
        icon_size = 256,
        icon = "__lilys-incendiaries__/graphics/technology/uranium-incendiary-rounds-magazine.png",
        prerequisites = { "uranium-ammo"--[[, "incendiary-magazines" --]]},
        unit = {
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
            --[[{
                type = "unlock-recipe",
                recipe = "uranium-incendiary-rounds-magazine"
            },
            {
                type = "unlock-recipe",
                recipe = "uranium-incendiary-rounds-magazine-2"
            },
            {
                type = "unlock-recipe",
                recipe = "uranium-incendiary-rounds-magazine-3"
            }--]]
        }
    }
})


data.extend({
    -- technology
    {
        type = "technology",
        name = "burny-explosive-rocketry",
        icon_size = 256,
        icon = "__lilys-incendiaries__/graphics/technology/burny-explosive-rocketry.png",
        prerequisites = { "explosive-rocketry", "utility-science-pack", "flamethrower" },
        unit =
        {
            count = 1000,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "utility-science-pack",    1 }
            },
            time = 60
        },
        effects =
        {
            --[[{
                type = "unlock-recipe",
                recipe = "fuel-air-missile"
            }--]]
        }
    }
})
