local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

--item
local methanol_bottle_item = {
    type = "capsule",
    name = "methanol-bottle",
    icon = "__lilys-incendiaries__/graphics/icons/wood-science-pack.png",
    capsule_action =
    {
        type = "throw",

        attack_parameters =
        {
            type = "projectile",
            activation_type = "throw",
            ammo_category = "grenade",
            cooldown = 30,
            projectile_creation_distance = 0.6,
            range = 20,
            ammo_type =
            {
                target_type = "position",
                action =
                {
                    {
                        type = "direct",
                        action_delivery =
                        {
                            type = "projectile",
                            projectile = "methanol-bottle",
                            starting_speed = 1
                        }
                    },
                    {
                        type = "direct",
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "play-sound",
                                    sound = sounds.throw_projectile
                                },
                                {
                                    type = "play-sound",
                                    sound = sounds.throw_grenade
                                },
                            }
                        }
                    }
                }
            }
        }
    },
    subgroup = settings.startup["enable-alt-recipes"].value and "capsule" or "science-pack",
    order = "a[methanol-bottle]",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_move,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 200,
    weight = 1 * kg,
    fuel_category = "chemical",
    fuel_value = "20MJ",
    burnt_result = "iron-plate",
    auto_recycle = false
}
data:extend({ methanol_bottle_item })

local methanol_bottle = {
    type = "projectile",
    name = "methanol-bottle",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.05,
    action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "damage",
                    damage = { amount = 10, type = "physical" }
                },
                {
                    type = "play-sound",
                    sound = {
                        category = "explosion",
                        volume = 2,
                        filename = "__lilys-incendiaries__/sounds/glass-shattering-short.ogg"
                    }
                },
                {
                    type = "create-fire",
                    entity_name = "fire-flame",
                    initial_ground_flame_count = 6,
                    show_in_tooltip = true
                },
                {
                    type = "nested-result",
                    action = {
                        type = "area",
                        radius = 5,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "damage",
                                    damage = { amount = 10, type = "fire" },
                                    apply_damage_to_trees = false
                                },
                                {
                                    type = "create-sticker",
                                    sticker = "fire-sticker",
                                    show_in_tooltip = true
                                },
                            }
                        }
                    }
                },
                {
                    type = "nested-result",
                    action = {
                        type = "cluster",
                        distance = 3,
                        distance_deviation = 4,
                        cluster_count = 6,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                type = "create-fire",
                                entity_name = "fire-flame",
                                show_in_tooltip = true
                            }
                        }
                    }
                }
            }
        }
    },
    light = { intensity = 0.25, size = 1 },
    animation =
    {
        filename = "__lilys-incendiaries__/graphics/icons/wood-science-pack.png",
        frame_count = 1,
        mipmap_coount = 4,
        animation_speed = 0.50,
        width = 64,
        height = 64,
        shift = util.by_pixel(0.5, 0.5),
        priority = "high",
        scale = 0.3
    }
}
data:extend({ methanol_bottle })

-- recipe
data:extend({
    {
        type = "recipe",
        name = "methanol-bottle",
        allow_productivity = false,
        enabled = false,
        energy_required = settings.startup["enable-alt-recipes"].value and 5 or 30,
        ingredients =
        {
            { type = "item", name = "wood",       amount = 50 },
            { type = "item", name = "coal",       amount = 1 },
            { type = "item", name = "iron-plate", amount = 1 }
        },
        results = { { type = "item", name = "methanol-bottle", amount = 1 } },
        ---@diagnostic disable-next-line: assign-type-mismatch
        auto_recycle = false
    }
})

if mods["quality"] then
    local recycling = require("__quality__/prototypes/recycling.lua")
    recycling.generate_self_recycling_recipe(methanol_bottle_item)
end

-- technology
data:extend({
    {
        type = "technology",
        name = "methanol-bottle-production",
        icon_size = 256,
        icon = "__lilys-incendiaries__/graphics/technology/wood-science-pack.png",
        prerequisites = { "automation-science-pack" },
        unit =
        {
            count = 10,
            ingredients =
            {
                { "automation-science-pack", 1 },
            },
            time = 15
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "methanol-bottle"
            }
        },
        order = "a"
    }
})

if mods["space-age"] and mods["maraxsis"] and not settings.startup["enable-alt-recipes"].value then
    table.insert(data.raw["lab"]["biolab"].inputs, "methanol-bottle")

    local science_pack = methanol_bottle_item
    local science_pack_name = "methanol-bottle"
    local fill_name = "maraxsis-" .. science_pack_name .. "-research-vessel"
    local empty_name = "maraxsis-" .. science_pack_name .. "-empty-research-vessel"



    local function generate_recipe_icons(icons, science_pack, icon_shift)
        if science_pack.icon then
            table.insert(icons,
                {
                    icon = science_pack.icon,
                    icon_size = (science_pack.icon_size or defines.default_icon_size),
                    scale = 16.0 / (science_pack.icon_size or defines.default_icon_size), -- scale = 0.5 * 32 / icon_size simplified
                    shift = icon_shift
                }
            )
        end

        return icons
    end

    local function add_to_tech(recipe)
        table.insert(data.raw.technology["maraxsis-research-vessel"].effects, { type = "unlock-recipe", recipe = recipe })
    end

    data:extend { {
        type = "item",
        name = fill_name,
        icons = {
            {
                icon = "__maraxsis__/graphics/icons/research-vessel.png",
                icon_size = 64,
            },
            {
                icon = "__maraxsis__/graphics/icons/research-vessel-mask.png",
                tint = {128, 128, 128},
                icon_size = 64,
            }
        },
        stack_size = 20,
        localised_name = { "item-name.maraxsis-full-research-vessel", science_pack.localised_name or { "item-name." .. science_pack_name } },
        hidden_in_factoriopedia = true,
        default_import_location = science_pack.default_import_location,
        weight = 1000000 / 100,
        order = science_pack.order,
        inventory_move_sound = item_sounds.metal_large_inventory_move,
        pick_sound = item_sounds.metal_large_inventory_pickup,
        drop_sound = item_sounds.metal_large_inventory_move,
        subgroup = "maraxsis-fill-research-vessel",
    } }

    data:extend { {
        type = "recipe",
        name = fill_name,
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = "maraxsis-empty-research-vessel", amount = 1 },
            { type = "item", name = science_pack_name,                amount = 100 },
        },
        results = {
            { type = "item", name = fill_name, amount = 1, ignored_by_stats = 1, ignored_by_productivity = 1 },
        },
        allow_productivity = false,
        allow_quality = false,
        category = "chemistry",
---@diagnostic disable-next-line: assign-type-mismatch
        auto_recycle = false,
        hide_from_signal_gui = false,
        allow_decomposition = false,
        hide_from_player_crafting = true,
        factoriopedia_alternative = "maraxsis-empty-research-vessel",
        icons = generate_recipe_icons({
            {
                icon = "__maraxsis__/graphics/icons/research-vessel.png",
                icon_size = 64,
            },
            {
                icon = "__maraxsis__/graphics/icons/research-vessel-mask.png",
                tint = { 128, 128, 128 },
                icon_size = 64,
            }
        }, science_pack, { -8, -8 }),
        subgroup = "maraxsis-fill-research-vessel",
    } }
    add_to_tech(fill_name)

    data:extend { {
        type = "recipe",
        name = empty_name,
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = fill_name, amount = 1 },
        },
        results = {
            { type = "item", name = science_pack_name,                amount = 100, ignored_by_stats = 100, ignored_by_productivity = 100 },
            { type = "item", name = "maraxsis-empty-research-vessel", amount = 1,   ignored_by_stats = 1,   ignored_by_productivity = 1,  probability = 0.99 },
        },
        allow_productivity = false,
        allow_quality = false,
        category = "chemistry",
---@diagnostic disable-next-line: assign-type-mismatch
        auto_recycle = false,
        unlock_results = false,
        icons = generate_recipe_icons({
            {
                icon = "__maraxsis__/graphics/icons/research-vessel-tipped.png",
                icon_size = 64,
            },
            {
                icon = "__maraxsis__/graphics/icons/research-vessel-tipped-mask.png",
                tint = { 128, 128, 128 },
                icon_size = 64,
            }
        }, science_pack, { 8, 8 }),
        localised_name = { "recipe-name.maraxsis-empty-research-vessel", science_pack.localised_name or { "item-name." .. science_pack_name } },
        hide_from_signal_gui = false,
        allow_decomposition = false,
        hide_from_player_crafting = true,
        factoriopedia_alternative = "maraxsis-empty-research-vessel",
        subgroup = "maraxsis-empty-research-vessel",
    } }
    add_to_tech(empty_name)
end
