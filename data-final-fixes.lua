if mods["distant-misfires"] then

    local pir = data.raw.ammo["piercing-incendiary-rounds-magazine"]
    local uir = data.raw.ammo["uranium-incendiary-rounds-magazine"]

    uir.range_modifier = 1.25

    pir.animation = {
        filename = "__base__/graphics/entity/bullet/bullet.png",
        frame_count = 1,
        width = 3,
        height = 50,
        priority = "high",
        blend_mode = "additive",
        shift = {0, 1},
        tint = {
        r = 1.0,
        g = 0.5,
        b = 0.1,
        a = 1 
        }
      }

      data:extend({pir, uir})

    --[[if (pir.action ~= nil) then
        local actions = ensure_table(pir.action)
        actions:extend({
            {
                type = "area",
                radius = 2.5,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-sticker",
                            sticker = "fire-sticker",
                            show_in_tooltip = true
                        },
                        {
                            type = "damage",
                            damage = { amount = 2, type = "fire" },
                            apply_damage_to_trees = false
                        }
                    }
                }
            }
        })

    end--]]
end