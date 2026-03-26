-- so much manual work... I'm going crazy, kill me
data:extend({
    --bools
    {
        type = "bool-setting",
        name = "krt-mini-train-speed-and-power-increase",
        setting_type = "startup",
        default_value = true,
        order = "aaa" --1st
    },
    {
        type = "bool-setting",
        name = "krt-mini-cargo-wagon-capacity-buff",
        setting_type = "startup",
        default_value = true,
        order = "abb" --5th
    },
    {
        type = "bool-setting",
        name = "krt-mini-train-recipe-change",
        setting_type = "startup",
        default_value = true,
        order = "aab" --2nd
    },
    {
        type = "bool-setting",
        name = "krt-mini-cargo-wagon-recipe-change",
        setting_type = "startup",
        default_value = true,
        order = "aba" --4th
    },
    {
        type = "bool-setting",
        name = "krt-mini-fluid-wagon-recipe-change",
        setting_type = "startup",
        default_value = true,
        order = "aca" --6th
    },
        {
        type = "bool-setting",
        name = "krt-mini-fluid-wagon-capacity-buff",
        setting_type = "startup",
        default_value = true,
        order = "acb" --7th
    },
    {
        type = "bool-setting",
        name = "krt-vanilla-cargo-wagon-capacity-buff",
        setting_type = "startup",
        default_value = true,
        order = "bba" --11th
    },
    {
        type = "bool-setting",
        name = "krt-vanilla-cargo-wagon-recipe-change",
        setting_type = "startup",
        default_value = true,
        order = "bbb" --12th    too nad there's no bbc :/ . You know why :3
    },
        {
        type = "bool-setting",
        name = "krt-vanilla-fluid-wagon-capacity-buff",
        setting_type = "startup",
        default_value = true,
        order = "bca" --13th
    },
    {
        type = "bool-setting",
        name = "krt-vanilla-fluid-wagon-recipe-change",
        setting_type = "startup",
        default_value = true,
        order = "bcb" --14th
    },
    {
        type = "bool-setting",
        name = "krt-vanilla-train-speed-and-power-increase",
        setting_type = "startup",
        default_value = true,
        order = "baa" --8th
    },
    --strings
    {
        type = "string-setting",
        name = "krt-mini-train-research-change",
        setting_type = "startup",
        default_value = "automation",
        allowed_values = {"original","vanilla","automation"},
        order = "aac" --3rd
    },
})

--did you know that the game doesn't check if you own space age on steam? if you get your hands on the copy of the space age "mod" you can paste it (into steam mod dir) and play normally with steam achigments!

if not mods["space-age"] then data:extend({
        {
            type = "string-setting",
            name = "krt-vanilla-train-recipe-change",
            setting_type = "startup",
            default_value = "changed",
            allowed_values = {"vanilla","changed"},
            order = "bab" --9th     "bab" lol
        },
        {
            type = "string-setting",
            name = "krt-vanilla-train-research-change",
            setting_type = "startup",
            default_value = "automation",
            allowed_values = {"vanilla","logistics","automation"},
            order = "bac" --10th
        },
    })
else data:extend({ 
        {
            type = "string-setting",
            name = "krt-vanilla-train-recipe-change",
            setting_type = "startup",
            default_value = "vulcanus",
            allowed_values = {"vanilla","changed"--[[,"vulcanus"]]}, --for now
            order = "bab" --9th     it's no fun no more
        },
        {
            type = "string-setting",
            name = "krt-vanilla-train-research-change",
            setting_type = "startup",
            default_value = "vulcanus",
            allowed_values = {"vanilla","logistics","automation"--[[,"vulcanus"]]},
            order = "bac" --10th
        },
    })
end