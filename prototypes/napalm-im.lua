-- imported from old incendiary munitions mod
require "util"
local math3d = require "math3d"

local napalmtuil = {}

function napalmtuil.foreach(table_, fun_)
    for k, tab in pairs(table_) do fun_(tab) end
    return table_
end

function napalmtuil.create_fire_pictures(opts)
    local fire_blend_mode = opts.blend_mode or "additive"
    local fire_animation_speed = opts.animation_speed or 0.5
    local fire_scale = opts.scale or 1
    local fire_tint = { r = 1, g = 1, b = 1, a = 1 }
    local fire_flags = { "always-compressed" }
    local retval = {
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-13.png",
            line_length = 8,
            width = 60,
            height = 118,
            frame_count = 25,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { -0.0390625, -0.90625 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-12.png",
            line_length = 8,
            width = 63,
            height = 116,
            frame_count = 25,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { -0.015625, -0.914065 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-11.png",
            line_length = 8,
            width = 61,
            height = 122,
            frame_count = 25,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { -0.0078125, -0.90625 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-10.png",
            line_length = 8,
            width = 65,
            height = 108,
            frame_count = 25,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { -0.0625, -0.64844 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-09.png",
            line_length = 8,
            width = 64,
            height = 101,
            frame_count = 25,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { -0.03125, -0.695315 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-08.png",
            line_length = 8,
            width = 50,
            height = 98,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { -0.0546875, -0.77344 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-07.png",
            line_length = 8,
            width = 54,
            height = 84,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { 0.015625, -0.640625 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-06.png",
            line_length = 8,
            width = 65,
            height = 92,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { 0, -0.83594 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-05.png",
            line_length = 8,
            width = 59,
            height = 103,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { 0.03125, -0.882815 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-04.png",
            line_length = 8,
            width = 67,
            height = 130,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { 0.015625, -1.109375 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-03.png",
            line_length = 8,
            width = 74,
            height = 117,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { 0.046875, -0.984375 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-02.png",
            line_length = 8,
            width = 74,
            height = 114,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { 0.0078125, -0.96875 }
        },
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-01.png",
            line_length = 8,
            width = 66,
            height = 119,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = fire_blend_mode,
            animation_speed = fire_animation_speed,
            scale = fire_scale,
            tint = fire_tint,
            flags = fire_flags,
            shift = { -0.0703125, -1.039065 }
        },
    }
    return napalmtuil.foreach(retval, function(tab)
        if tab.shift and tab.scale then tab.shift = { tab.shift[1] * tab.scale, tab.shift[2] * tab.scale } end
    end)
end

local napalmFire = table.deepcopy(data.raw["fire"]["fire-flame"])
napalmFire.name = "napalm-flame"
napalmFire.initial_lifetime = 1200
napalmFire.damage_per_tick = { amount = 40 / 60, type = "fire" }
napalmFire.on_fuel_added_action = nil
napalmFire.damage_multiplier_decrease_per_tick = 0.0005
napalmFire.maximum_damage_multiplier = 1
napalmFire.fade_out_duration = 60
napalmFire.lifetime_increase_by = 0
napalmFire.pictures = napalmtuil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = 0.5 }),

---@diagnostic disable-next-line: redundant-value
data:extend({ napalmFire })

data:extend({
    {
        type = "sticker",
        name = "napalm-sticker",
        flags = {"not-on-map"},

        animation =
        {
            filename = "__lilys-incendiaries__/graphics/entity/napalm/napalm-flame-13.png",
            line_length = 8,
            width = 60,
            height = 118,
            frame_count = 25,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = "normal",
            animation_speed = 1,
            scale = 0.2,
            tint = { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }, --{ r = 1, g = 1, b = 1, a = 0.35 },
            shift = math3d.vector2.mul({-0.078125, -1.8125}, 0.1),
        },

        duration_in_ticks = 90 * 60,
        target_movement_modifier = 0.4,
        damage_per_tick = { amount = 250 / 60, type = "fire" },
        spread_fire_entity = "fire-flame-on-tree",
        fire_spread_cooldown = 30,
        fire_spread_radius = 0.75,
    }
})
