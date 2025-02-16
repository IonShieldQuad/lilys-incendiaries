return {
    make_napalm_boom = function(radius, damage, clusters)
        local napalm_boom = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-fire",
                        entity_name = "napalm-flame",
                        initial_ground_flame_count = 4
                    },
                    {
                        type = "create-sticker",
                        sticker = "napalm-sticker"
                    },
                    {
                        type = "play-sound",
                        sound = {
                            category = "explosion",
                            volume = 2,
                            filename = "__lilys-incendiaries__/sounds/fiery-explosion.ogg"
                        }
                    },
                    {
                        type = "create-entity",
                        entity_name = "fiery-explosion"
                    },
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            radius = radius,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    {
                                        type = "damage",
                                        damage = { amount = damage, type = "fire" },
                                        apply_damage_to_trees = false
                                    },
                                    {
                                        type = "create-sticker",
                                        sticker = "napalm-sticker",
                                        show_in_tooltip = true
                                    },
                                }
                            }
                        }
                    }

                }
            }
        }
        local effects = napalm_boom.action_delivery.target_effects
        for _, data in ipairs(clusters) do
            table.insert(effects, 
                {
                    type = "nested-result",
                    action = {
                        type = "cluster",
                        distance = data.distance,
                        distance_deviation = data.distance_deviation,
                        cluster_count = data.cluster_count,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "create-fire",
                                    entity_name = "napalm-flame",
                                    show_in_tooltip = true
                                }
                            }
                        }
                    }
                
            })

        end

        return napalm_boom
    end
}