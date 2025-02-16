-- fire sticker that sticks to enemies
local uranium_fire_sticker = table.deepcopy(data.raw["sticker"]["fire-sticker"])
uranium_fire_sticker.name = "fire-sticker-uranium"
uranium_fire_sticker.duration_in_ticks = uranium_fire_sticker.duration_in_ticks * 1.5
uranium_fire_sticker.damage_per_tick = { amount = 20 * 100 / 60, type = "fire" }
uranium_fire_sticker.animation.tint = { r = 0.2, g = 0.3, b = 0.00, a = 0.3 }
uranium_fire_sticker.target_movement_modifier = 0.7
uranium_fire_sticker.damage_interval = 5

data:extend({ uranium_fire_sticker })


-- same but simulates them being irradiated
local uranium_fire_sticker_rad = table.deepcopy(data.raw["sticker"]["fire-sticker-uranium"])
uranium_fire_sticker_rad.name = "fire-sticker-uranium-rad"
uranium_fire_sticker_rad.duration_in_ticks = uranium_fire_sticker.duration_in_ticks * 5
if (data.raw["damage-type"]["radiation"] == nil) then
    uranium_fire_sticker_rad.damage_per_tick = { amount = 10 * 100 / 60, type = "poison" }
else
    uranium_fire_sticker_rad.damage_per_tick = { amount = 10 * 100 / 60, type = "radiation" }
end
uranium_fire_sticker_rad.animation.tint = { r = 0.0, g = 0.05, b = 0.0, a = 0.05 }
data:extend({ uranium_fire_sticker_rad })



-- fire that sticks around on map
-- very buffed compared to normal
local uranium_fire = table.deepcopy(data.raw["fire"]["fire-flame"])
uranium_fire.name = "fire-flame-uranium"
uranium_fire.damage_per_tick = { amount = 25 / 60, type = "fire" }
uranium_fire.emissions_per_second = { pollution = 0.05 }
uranium_fire.initial_lifetime = 600
uranium_fire.lifetime_increase_by = 1200
uranium_fire.lifetime_increase_cooldown = 2
uranium_fire.maximum_lifetime = 12000
if (uranium_fire.pictures ~= nil) then
    for i, pic in ipairs(uranium_fire.pictures) do
        pic.tint = { r = 0.3, g = 0.8, b = 0.1, a = 1 }
    end
end

data:extend({ uranium_fire })
