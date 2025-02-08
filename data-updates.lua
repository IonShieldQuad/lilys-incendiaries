if (data.raw["ammo"]["coal-shotgun-shell"]) then
    local basic_military = data.raw["technology"]["military"]

    table.insert(basic_military.effects, {
        type = "unlock-recipe",
        recipe = "coal-shotgun-shell"
    })
end