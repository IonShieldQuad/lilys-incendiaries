local explosion_animations = require("__base__.prototypes.entity.explosion-animations")


-- fuel air bomb canister entity
-- Not used in final version
local fab_canister = {
    name = "fuel-air-canister",
    type = "container",
    flags = {"not-on-map", "placeable-off-grid"},
    inventory_size = 0,
    picture = --[[{
        filename = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
        width = 64,
        height = 64,
        scale = 0.2
    },--]]
    {
        layers = {
        {
            filename = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
            width = 64,
            height = 64,
            scale = 0.2
        }, 
        {
            filename = "__base__/graphics/icons/flying-robot-frame.png",
            priority = "high",
            width = 64,
            height = 64,
            scale = 0.15,
            shift = {0, -0.2}
        }}
    },--]]
    max_health = 100,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{0, 0}, {0, 0}},
    mineable = false,

    alert_when_damaged = false
}

fab_canister.resistances = {}
for i, t in ipairs(data.raw["damage-type"]) do
    if t.name == "fire" or t.name == "explosion" then
        fab_canister.resistances.insert = {type = t, decrease = 0, percent = 0}
    else 
    fab_canister.resistances.insert = {type = t, decrease = 0, percent = 100}
    end
end

data:extend({fab_canister})

-- Fuel-air cloud
local fab_cloud = {
    name = "fuel-air-cloud",
    type = "smoke-with-trigger",
    flags = { "not-on-map" },
    hidden = true,
    show_when_smoke_off = true,
    particle_count = 100,
    particle_spread = { 3.6 * 1.05*2, 3.6 * 0.6 * 1.05*2},
    particle_distance_scale_factor = 0.5, 
    particle_scale_factor = { 2, 1.5 },
    wave_speed = { 1 / 80, 1 / 60 },
    wave_distance = { 0.3, 0.2 },
    spread_duration_variation = 20,
    particle_duration_variation = 60 * 3,
    render_layer = "object",

    affected_by_wind = false,
    cyclic = true,
    duration = 60 * 12,
    fade_away_duration = 60,
    spread_duration = 200,
    color = { 0.4, 0.35, 0.3, 0.2 }, -- #ffeeddb0,
    attach_to_target = true,
    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      animation_speed = 0.5,
      filename = "__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" },
    }
} 
data:extend({fab_cloud})

-- not used
local fab_dummy_particle = {
    name = "fuel-air-particle",
    type = "optimized-particle",
    life_time = 60*30,
    vertical_acceleration = 0
}

data:extend({ fab_dummy_particle })

-- boom
local boom_action = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "create-entity",
                entity_name = "big-scorchmark-tintable",
                check_buildability = true
            },
            {
                type = "create-explosion",
                entity_name = "big-explosion",
                check_buildability = true
            }, 
            {
                type = "destroy-decoratives",
                from_render_layer = "decorative",
                to_render_layer = "object",
                include_soft_decoratives = true, 
                include_decals = false,
                invoke_decorative_trigger = true,
                decoratives_with_trigger_only = false, 
                radius = 8                 
            },
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 8,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 50, type = "physical" }
                            },
                            {
                                type = "damage",
                                damage = { amount = 100, type = "explosion" }
                            },
                            {
                                type = "damage",
                                damage = { amount = 150, type = "fire" }
                            },
                            {
                                type = "invoke-tile-trigger",
                                repeat_count = 1
                            },

                        }
                    }

                },
            },
            {
                type = "nested-result",
                action = {
                    type = "cluster",
                    cluster_count = 16,
                    distance = 6,
                    distance_deviation = 6,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "create-fire",
                                entity_name = "fire-flame",
                                initial_ground_flame_count = 8
                            },
                            --[[{
                                type = "create-entity",
                                entity_name = "big-explosion"
                            },
                            {
                                type = "damage",
                                damage = { amount = 50, type = "explosion" }
                            },--]]
                            {
                                type = "damage",
                                damage = { amount = 50, type = "fire" }
                            }
                        }
                    }
                }
            }
        }
    }
}


-- A "projectile" that spawns when cloud explodes
local fab_dummy_projectile = {
    type = "projectile",
    name = "fuel-air-explosion",
    icon = data.raw["fluid"]["steam"].icon,
    acceleration = 0.00001,
    flags = {"not-on-map"},
    --hidden = true,
    action = boom_action
}

data.extend({fab_dummy_projectile})

-- Ignore this
local fab_delay_trigger = {
    name = "fab-delay-trigger",
    type = "delayed-active-trigger",
    delay = 60*6,
    action = boom_action
}

data:extend({fab_delay_trigger})

-- Invisible projectile for cloud cluster spreading
local fab_spreader_projectile = {
    type = "projectile",
    name = "fuel-air-spreader",
    acceleration = 0,
    flags = { "not-on-map" },
    hidden = true,
    action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "create-entity",
                    entity_name = "fuel-air-cloud",
                    trigger_created_entity = true
                },
                --[[{
                    type = "nested-result",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "delayed",
                            delayed_trigger = "fab-delay-trigger"
                        }

                    }
                }--]]
            }
        }
    }
}

data.extend({ fab_dummy_projectile })
data.extend({fab_spreader_projectile})



-- Ignition after 6 seconds
local delayed_fab_ignition = {
    name = "delayed-fab-ignition",
    type = "delayed-active-trigger",
    delay = 60 * 6,
    action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            target_effects = {
                type = "create-fire",
                entity_name = "fire-flame",
                initial_flame_count = 1
            }
        }
    }
}

data:extend({ delayed_fab_ignition })


