Config = {}

ConsumeablesEat = {
    ["sandwich"] = math.random(35, 54),
    ["apple"] = math.random(10, 25),
    ["cannedbeans"] = math.random(40, 50),
	["bread"] = math.random(20, 40),
	["chocolate"] = math.random(30, 50),
}

ConsumeablesDrink = {
    ["water_bottle"] = math.random(35, 54),
    ["coffee"] = math.random(40, 50),
}

ConsumeablesAlcohol = {
    ["whiskey"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
    ["vodka"] = math.random(20, 40),
}

Config.DisableEvents = {
    [`EVENT_CHALLENGE_GOAL_COMPLETE`] = true,
    [`EVENT_CHALLENGE_REWARD`] = true,
    [`EVENT_DAILY_CHALLENGE_STREAK_COMPLETED`] = true,
}

Config.BlacklistedModels = {
    -- PEDS
    [`s_m_y_ranger_01`] = true,

    --VEHICLES
    [`gatling_gun`] = true,
    [`gatlingMaxim02`] = true,
    [`breach_cannon`] = true,
    [`hotchkiss_cannon`] = true,
    [`policeWagongatling01x`] = true,

    -- OBJECTS
    [`prop_sec_barier_02b`] = true,
    [`prop_sec_barier_02a`] = true
}

Config.Teleports = {
     --Template (needs changing to some default stuff)
     [1] = {
         [1] = {
             coords = vector4(1401.03, 352.71, 87.64, 19.36),
             text = 'Take Elevator Up'
         },
         [2] = {
             coords = vector4(1379.09, 347.07, 87.8, 15.73),
             text = 'Take Elevator Down'
         },
     },
}