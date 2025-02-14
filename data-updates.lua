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



if settings.startup["explosions-ignite"] then
    local proj = data.raw["projectile"]["explosive-cannon-projectile"]
    table.insert(proj.final_action.action_delivery.target_effects, {
        type = "nested-result",
        action = {
            type = "area",
            radius = 4,
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-sticker",
                    sticker = "fire-sticker",
                    probability = 0.3
                }
            }
        }
    })
    table.insert(proj.final_action.action_delivery.target_effects, {
        type = "nested-result",
        action = {
            type = "cluster",
            cluster_count = 8,
            distance = 4,
            distance_deviation = 4,
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-fire",
                    entity_name = "fire-flame",
                    probability = 0.5
                }
            }
        }
    })

    local uproj = data.raw["projectile"]["explosive-uranium-cannon-projectile"]

    table.insert(uproj.final_action.action_delivery.target_effects, {
        type = "nested-result",
        action = {
            type = "area",
            radius = 4.25,
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-sticker",
                        sticker = "fire-sticker-uranium",
                        probability = 0.3
                    },
                    {
                        type = "create-sticker",
                        sticker = "fire-sticker-uranium-rad",
                        probability = 0.6
                    }
                }
            }
            
        }
    })
    table.insert(uproj.final_action.action_delivery.target_effects, {
        type = "nested-result",
        action = {
            type = "cluster",
            cluster_count = 8,
            distance = 4,
            distance_deviation = 4,
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-fire",
                    entity_name = "fire-flame-uranium",
                    probability = 0.5
                }
            }
        }
    })



    local mproj = data.raw["projectile"]["explosive-rocket"]
    table.insert(mproj.action.action_delivery.target_effects, {
        type = "nested-result",
        action = {
            type = "area",
            radius = 6.5,
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-sticker",
                    sticker = "fire-sticker",
                    probability = 0.3
                }
            }
            
        }
    })
    table.insert(mproj.action.action_delivery.target_effects, {
        type = "nested-result",
        action = {
            type = "cluster",
            cluster_count = 12,
            distance = 6.5,
            distance_deviation = 6.5,
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "create-fire",
                    entity_name = "fire-flame",
                    probability = 0.5
                }
            }
        }
    })
    data:extend({proj, uproj, mproj})
end