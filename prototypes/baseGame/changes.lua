--I wrote a lot of comments bc i didn't use functions so i'd myself be lost on what the code does


-- =============================== research ===============================
local research = data.raw.technology
local research_mini = data.raw["technology"]["mini-trains"]
local research_vanilla = data.raw["technology"]["railway"]
local research_vanilla_fluid = data.raw["technology"]["fluid-wagon"]

-- ===== mini-trains and combaining both technologies =====
if settings.startup["krt-vanilla-train-research-change"].value ~= "vanilla" then

    if settings.startup["krt-mini-train-research-change"].value ~= "original" then

        --remove fluid wagons
        for i in pairs(research) do
            if research[i].effects ~= nil then
                for k,v in pairs(research[i].effects) do
                    if v.recipe == "mini-fluid-wagon" or v.recipe == "fluid-wagon" then
                        table.remove(research[i].effects, k)
                    end
                end
            end
        end
        --now we remove rails and sticks from vanilla train technology and add them to mini-trains
        for k,v in pairs(research_vanilla.effects) do 
            if v.recipe == "iron-stick" or v.recipe == "rail" then
                table.remove(research_vanilla.effects, k)
            end
        end
        table.insert(research_mini.effects,1,{
        type = "unlock-recipe",
        recipe = "rail"
        })
        table.insert(research_mini.effects,4,{
            type = "unlock-recipe",
            recipe = "iron-stick"
        })

        --super nesting incoming for replacing every dependency for railway technology to mini-trains
        for _, i in pairs(research) do
            if i.prerequisites then
                for x, y in ipairs(i.prerequisites) do
                    if y == "railway" then
                        i.prerequisites[x] = "mini-trains"
                    end
                end
            end
        end
        --now we do settings for mini-train research
        if settings.startup["krt-mini-train-research-change"].value == "automation" then
            
            research_mini.prerequisites = {"automation-2", "engine"}
            research_mini.unit.count = 75
            table.insert(research_vanilla_fluid.effects,1,{
                type = "unlock-recipe",
                recipe = "mini-fluid-wagon"
            })
            research_vanilla_fluid.icon = "__Mini_Trains__/data/icons/fluid128.png"
        else
            research_mini.prerequisites = {"logistics-2", "engine"}
            table.insert(research_vanilla_fluid.effects,1,{
                type = "unlock-recipe",
                recipe = "mini-fluid-wagon"
            })
            research_vanilla_fluid.icon = "__Mini_Trains__/data/icons/fluid64.png"
        end
    end
else
    --mash together both technologies
    research["mini-trains"]=nil     --this took me so long to get right... i shouldn't have mode this mod without expierience with lua... "all launguages work the same way"-I thought-"its not gonna be THAT hard"
    table.insert(research_vanilla.effects,4,{
        type = "unlock-recipe",
        recipe = "mini-locomotive"
    })
    table.insert(research_vanilla.effects,5,{
        type = "unlock-recipe",
        recipe = "mini-cargo-wagon"
    })
    table.insert(research_vanilla_fluid.effects,2,{
        type = "unlock-recipe",
        recipe = "mini-fluid-wagon"
    })
end

-- ===== vanilla train =====
if settings.startup["krt-vanilla-train-research-change"].value ~= "vulcanus" and settings.startup["krt-vanilla-train-recipe-change"].value ~= "vulcanus" then

    if settings.startup["krt-vanilla-train-research-change"].value == "automation" then

        if settings.startup["krt-mini-train-research-change"].value == "original" then -- stupid scienie loop made me do this

            for x,y in pairs(research["production-science-pack"].prerequisites) do
               
                if y == "railway" then
                    research["production-science-pack"].prerequisites[x]= nil
                end
            end
            table.insert(research["production-science-pack"].effects,{
            type = "unlock-recipe",
            recipe = "rail"
            })
        end
        if settings.startup["krt-mini-train-research-change"].value ~= "original" then -- 2X stupid scienie loop made me do this
            research_vanilla.prerequisites = {"automation-3", "engine","mini-trains","fluid-wagon"}
        else
            research_vanilla.prerequisites = {"automation-3", "engine","fluid-wagon"}
            research_mini.unit.count = 50
            research_mini.unit.time = 1
            table.insert(research_mini.unit.ingredients,{
                "chemical-science-pack",1
            })
            table.insert(research_mini.unit.ingredients,{
                "production-science-pack",1
            })
        end
        research_vanilla.unit.count = 300
        research_vanilla.unit.time = 60
        table.insert(research_vanilla.unit.ingredients,{
            "chemical-science-pack",1
        })
        table.insert(research_vanilla.unit.ingredients,{
            "production-science-pack",1
        })
    elseif settings.startup["krt-vanilla-train-research-change"].value == "logistics" then
        
        research_vanilla.unit.count = 300
        research_vanilla.unit.time = 60
        table.insert(research_vanilla.unit.ingredients,{
            "chemical-science-pack",1
        })
        table.insert(research_vanilla.unit.ingredients,{
            "production-science-pack",1
        })
        if settings.startup["krt-vanilla-train-recipe-change"].value == "changed" then

            if settings.startup["krt-mini-train-research-change"].value ~= "original" then -- 3X stupid scienie loop made me do this
                research_vanilla.prerequisites = {"logistics-3", "engine","speed-module","mini-trains","fluid-wagon"}
            else
                for x,y in pairs(research["production-science-pack"].prerequisites) do
               
                    if y == "railway" then
                        research["production-science-pack"].prerequisites[x]= nil
                    end
                end
                table.insert(research["production-science-pack"].effects,{
                type = "unlock-recipe",
                recipe = "rail"
                })
                research_vanilla.prerequisites = {"logistics-3", "engine","speed-module","fluid-wagon"}
                research_mini.unit.count = 50
                research_mini.unit.time = 1
                table.insert(research_mini.unit.ingredients,{
                    "chemical-science-pack",1
                })
                table.insert(research_mini.unit.ingredients,{
                    "production-science-pack",1
                })
            end
        else
            if settings.startup["krt-mini-train-research-change"].value ~= "original" then -- 4X stupid scienie loop made me do this
                research_vanilla.prerequisites = {"logistics-3", "engine","mini-trains","fluid-wagon"}
            else
                research_vanilla.prerequisites = {"logistics-3", "engine","fluid-wagon"}
                research_mini.unit.count = 50
                research_mini.unit.time = 1
                table.insert(research_mini.unit.ingredients,{
                    "chemical-science-pack",1
                })
                table.insert(research_mini.unit.ingredients,{
                    "production-science-pack",1
                })
            end
        end
    end
    if settings.startup["krt-mini-train-research-change"].value ~= "original" then
        table.insert(research_vanilla.effects,3,{
            type = "unlock-recipe",
            recipe = "fluid-wagon"
        })
    else
        research_vanilla_fluid.unit.count = 100
        research_vanilla_fluid.unit.time = 30
        table.insert(research_vanilla_fluid.unit.ingredients,{
            "chemical-science-pack",1
        })
        table.insert(research_vanilla_fluid.unit.ingredients,{
            "production-science-pack",1
        })
        table.insert(research["automated-rail-transportation"].unit.ingredients,{
            "chemical-science-pack",1
        })
        table.insert(research["automated-rail-transportation"].unit.ingredients,{
            "production-science-pack",1
        })
        table.insert(research["braking-force-1"].unit.ingredients,{
            "production-science-pack",1
        })
        table.insert(research["braking-force-2"].unit.ingredients,{
            "production-science-pack",1
        })
    end
end

-- =============================== recipes ===============================
local recipe_mini_train = data.raw["recipe"]["mini-locomotive"]
local recipe_mini_fluid = data.raw["recipe"]["mini-fluid-wagon"]
local recipe_mini_cargo = data.raw["recipe"]["mini-cargo-wagon"]
local recipe_vanilla_train = data.raw["recipe"]["locomotive"]
local recipe_vanilla_cargo = data.raw["recipe"]["cargo-wagon"]
local recipe_vanilla_fluid = data.raw["recipe"]["fluid-wagon"]

-- ===== mini =====
if settings.startup["krt-mini-train-recipe-change"].value == true then

    recipe_mini_train.ingredients = {
        {type="item", name="engine-unit", amount=10},
        {type="item", name="steel-plate", amount=20},
        {type="item", name="electronic-circuit", amount=10}
    }
end
if settings.startup["krt-mini-fluid-wagon-recipe-change"].value == true then

    recipe_mini_fluid.ingredients = {
        {type="item", name="storage-tank", amount=1},
        {type="item", name="steel-plate", amount=10},
        {type="item", name="iron-gear-wheel", amount=6},
        {type="item", name="pipe", amount=20}
    }
end
    if settings.startup["krt-mini-cargo-wagon-recipe-change"].value == true then

    recipe_mini_cargo.ingredients = {
        {type="item", name="iron-chest", amount=4},
        {type="item", name="steel-plate", amount=10},
        {type="item", name="iron-gear-wheel", amount=6},
        {type="item", name="iron-plate", amount=10}
    }
end

-- ===== vanilla =====
if settings.startup["krt-vanilla-train-recipe-change"].value ~= "vulcanus" then
    if settings.startup["krt-vanilla-train-recipe-change"].value == "changed" then

        recipe_vanilla_train.ingredients = {
            {type="item", name="mini-locomotive", amount=2},
            {type="item", name="speed-module", amount=2},
            {type="item", name="steam-engine", amount=2},
        }
    end
        if settings.startup["krt-vanilla-cargo-wagon-recipe-change"].value == true then

        recipe_vanilla_cargo.ingredients = {
            {type="item", name="steel-chest", amount=4},
            {type="item", name="steel-plate", amount=16},
            {type="item", name="iron-gear-wheel", amount=12},
            {type="item", name="iron-plate", amount=20}
        }
    end
        if settings.startup["krt-vanilla-fluid-wagon-recipe-change"].value == true then

        recipe_vanilla_fluid.ingredients = {
            {type="item", name="storage-tank", amount=2},
            {type="item", name="steel-plate", amount=16},
            {type="item", name="iron-gear-wheel", amount=12},
            {type="item", name="pipe", amount=30}
        }
    end
end --wow this was quick to code

-- =============================== buffs ===============================
local stats_mini_train = data.raw["locomotive"]["mini-locomotive"]
local stats_mini_cargo = data.raw["cargo-wagon"]["mini-cargo-wagon"]
local stats_mini_fluid = data.raw["fluid-wagon"]["mini-fluid-wagon"]
local stats_vanilla_train = data.raw["locomotive"]["locomotive"]
local stats_vanilla_cargo = data.raw["cargo-wagon"]["cargo-wagon"]
local stats_vanilla_fluid = data.raw["fluid-wagon"]["fluid-wagon"]

-- ===== mini =====
if settings.startup["krt-mini-train-speed-and-power-increase"].value == true then

    stats_mini_train.max_speed = 1.25
    stats_mini_train.max_power = "480kW"
    stats_mini_train.energy_source.effectivity = 0.8
    stats_mini_train.energy_source.fuel_inventory_size = 2
    stats_mini_train.friction_force = 0.4
    stats_mini_train.air_resistance = 0.0076
    stats_mini_cargo.air_resistance = 0.01013
    stats_mini_fluid.air_resistance = 0.01013
    stats_vanilla_train.braking_force = 7
end
if settings.startup["krt-mini-cargo-wagon-capacity-buff"].value == true then

    stats_mini_cargo.inventory_size = 30
end
if settings.startup["krt-mini-fluid-wagon-capacity-buff"].value == true then

    stats_mini_fluid.capacity = 37500
end

-- ===== vanilla =====
if settings.startup["krt-vanilla-train-speed-and-power-increase"].value == true then

    stats_vanilla_train.max_speed = 2
    stats_vanilla_train.max_power = "1200kW"
    stats_vanilla_train.energy_source.effectivity = 1
    stats_vanilla_cargo.max_speed = 2.5 --fun number, I just realized that 1.2 (vanilla train speed) is 0.6 of 2 (chanaged speed), so I did the same to wagons: 1.5/0.6=2.5 which is funnilly enough a nice number
    stats_vanilla_fluid.max_speed = 2.5
    stats_vanilla_train.air_resistance = 0.0105
    stats_vanilla_train.friction_force = 0.7
    stats_vanilla_train.braking_force = 6
    stats_vanilla_cargo.braking_force = 2
    stats_vanilla_fluid.braking_force = 2
end
if settings.startup["krt-vanilla-cargo-wagon-capacity-buff"].value == true then

    stats_vanilla_cargo.inventory_size = 60
end
if settings.startup["krt-vanilla-fluid-wagon-capacity-buff"].value == true then

    stats_vanilla_fluid.capacity = 75000
end --damn 80% of time wasted here was for testing balance changes