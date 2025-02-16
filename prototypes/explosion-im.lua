-- imported from old incendiary munitions mod
data:extend({
    {
        type = "explosion",
        name = "fiery-splash",
        flags = { "not-on-map" },
        animations =
        {
            {
                filename = "__lilys-incendiaries__/graphics/entity/fiery-splash.png",
                priority = "extra-high",
                width = 92,
                height = 66,
                frame_count = 15,
                line_length = 5,
                shift = { -0.437, 0.5 },
                animation_speed = 0.35
            }
        },
        sound =
        {
            aggregation =
            {
                max_count = 1,
                remove = true
            },
            variations =
            {
                {
                    filename = "__lilys-incendiaries__/sounds/fiery-splash.ogg",
                    volume = 1.5
                }
            }
        },
    },

    {
        type = "explosion",
        name = "fiery-explosion",
        flags = { "not-on-map" },
        animations =
        {
            {
                filename = "__lilys-incendiaries__/graphics/entity/fiery-explosion.png",
                priority = "extra-high",
                flags = { "always-compressed" },
                width = 197,
                height = 245,
                frame_count = 47,
                line_length = 6,
                axially_symmetrical = false,
                direction_count = 1,
                shift = { 0.1875, -0.75 },
                animation_speed = 0.3
            }
        },
        light = { intensity = 1, size = 50, color = { r = 1.0, g = 1.0, b = 1.0 } },
        sound =
        {
            aggregation =
            {
                max_count = 1,
                remove = true
            },
            variations =
            {
                {
                    filename = "__lilys-incendiaries__/sounds/fiery-explosion.ogg",
                    volume = 1.8
                }
            }
        },
        created_effect =
        {
            type = "direct",
            action_delivery =
            {
                type = "instant",
                target_effects =
                {
                    {
                        type = "create-particle",
                        repeat_count = 5,
                        particle_name = "explosion-remnants-particle",
                        initial_height = 0.5,
                        speed_from_center = 0.06,
                        speed_from_center_deviation = 0.1,
                        initial_vertical_speed = 0.06,
                        initial_vertical_speed_deviation = 0.1,
                        offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } }
                    }
                }
            }
        }
    }
})