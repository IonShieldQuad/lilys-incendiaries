
function update_range(source, target)
    if target then
        if source.ammo_type.action.action_delivery.max_range and source.ammo_type.action.action_delivery.max_range > target.ammo_type.action.action_delivery.max_range then
            target.ammo_type.action.action_delivery.max_range = source.ammo_type.action.action_delivery.max_range
        end
        data:extend({target})
    end
end

function update_piercing(source, target)
    if target then
        if source.piercing_damage and source.piercing_damage > target.piercing_damage then
            target.piercing_damage = source.piercing_damage
        end
    end
end

update_range(data.raw["ammo"]["cannon-shell"], data.raw["ammo"]["incendiary-cannon-shell"])
update_range(data.raw["ammo"]["explosive-cannon-shell"], data.raw["ammo"]["napalm-cannon-shell"])
update_range(data.raw["ammo"]["uranium-cannon-shell"], data.raw["ammo"]["uranium-incendiary-cannon-shell"])
update_range(data.raw["ammo"]["explosive-uranium-cannon-shell"], data.raw["ammo"]["uranium-napalm-cannon-shell"])

update_piercing(data.raw["projectile"]["cannon-projectile"], data.raw["projectile"]["incendiary-cannon-projectile"])
update_piercing(data.raw["projectile"]["explosive-cannon-projectile"], data.raw["projectile"]
["napalm-cannon-projectile"])
update_piercing(data.raw["projectile"]["uranium-cannon-projectile"], data.raw["projectile"]
    ["uranium-incendiary-cannon-projectile"])
update_piercing(data.raw["projectile"]["explosive-uranium-cannon-projectile"],
    data.raw["projectile"]["uranium-napalm-cannon-projectile"])
