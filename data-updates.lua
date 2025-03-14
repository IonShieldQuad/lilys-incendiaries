if (data.raw["ammo"]["coal-shotgun-shell"]) then
    local basic_military = data.raw["technology"]["military"]

    table.insert(basic_military.effects, {
        type = "unlock-recipe",
        recipe = "coal-shotgun-shell"
    })
end



if settings.startup["explosions-ignite"].value then
    -- exp shell
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

    -- uranium exp shell
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


    -- exp missile
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
---@diagnostic disable-next-line: assign-type-mismatch
    --data:extend({proj, uproj, mproj})
end

if mods["space-age"] and settings.startup["enable-fireproof-armor"].value then
    require("__lilys-incendiaries__/prototypes/fireproof_armor.lua")
end

local flamer = data.raw["fluid-turret"]["flamethrower-turret"]
table.insert(flamer.attack_parameters.fluids, { type = "lilys-napalm-mix", damage_modifier = 2.0 })
