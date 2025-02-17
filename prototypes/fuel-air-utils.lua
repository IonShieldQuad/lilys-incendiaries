return {
    make_fuel_air_effect = function(clusters, self_ignition)
        local boom_action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {}
            }
        }

        local effects = boom_action.action_delivery.target_effects

        if self_ignition then
            table.insert(effects, {
                type = "nested-result",
                action = {
                    type = "direct",
                    action_delivery = {
                        type = "delayed",
                        delayed_trigger = "delayed-fab-ignition"
                    }
                }
            })
        end


        for _, data in ipairs(clusters) do
            table.insert(effects, 
            {
                type = "nested-result",
                action = {
                    type = "cluster",
                    cluster_count = data.cluster_count,
                    distance = data.distance,
                    distance_deviation = data.distance_deviation,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            type = "create-entity",
                            entity_name = "fuel-air-cloud",
                            trigger_created_entity = true,
                            show_in_tooltip = true
                        }
                    }
                }
            })
            

        end
        return boom_action
    end
}

