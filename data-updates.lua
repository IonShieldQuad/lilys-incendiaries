if (data.raw["ammo"]["coal-shotgun-shell"]) then
    local basic_military = data.raw["technology"]["military"]

    table.insert(basic_military.effects, {
        type = "unlock-recipe",
        recipe = "coal-shotgun-shell"
    })
end

if (data.raw["ammo"]["uranium-incendiary-rounds-magazine"]) then
    local uranium_incendiary = data.raw["technology"]["incendiary-uranium-ammo"]
    table.insert(uranium_incendiary.prerequisites, "piercing-incendiary-shotgun-shells")
    table.insert(uranium_incendiary.effects, {
        type = "unlock-recipe",
        recipe = "uranium-piercing-incendiary-shotgun-shell"
    })
end