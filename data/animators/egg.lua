{
	default = "spawn",

	states = {
		["spawn"] = "data/animations/egg_spawn.lua",
		["idle"] = "data/animations/egg_idle.lua",
		["burst"] = "data/animations/egg_burst.lua"
	},

	properties = {
		["pop"] = { value = false, isTrigger = true }
	},

	transitions = {
		{ from = "spawn", to = "idle", property = "_finished", value = true },
		{ from = "idle", to = "burst", property = "pop", value = true }
	}
}
