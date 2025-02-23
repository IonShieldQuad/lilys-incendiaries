data:extend({
    {
        type = "bool-setting",
        name = "enable-methanol-bottles",
        setting_type = "startup",
        default_value = true,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "explosions-ignite",
        setting_type = "startup",
        default_value = true,
        order = "b"
    },
    {
        type = "bool-setting",
        name = "enable-napalm-ticking",
        setting_type = "startup",
        default_value = true,
        order = "d"
    },
    {
        type = "bool-setting",
        name = "enable-molotovs",
        setting_type = "startup",
        default_value = false,
        order = "aa"
    },
    {
        type = "bool-setting",
        name = "enable-alt-recipes",
        setting_type = "startup",
        default_value = false,
        order = "e"
    }
})

if mods["space-age"] then
    data:extend({ 
        {
            type = "bool-setting",
            name = "enable-fireproof-armor",
            setting_type = "startup",
            default_value = true,
            order = "c"
    } 
})
end

if mods["NapalmArtillery"] then
    data:extend({
        {
            type = "string-setting",
            name = "napalm-artillery-compat",
            setting_type = "startup",
            allowed_values = {"theirs", "mine", "both"},
            default_value = "both",
            order = "aaa"
        }
    })
end
