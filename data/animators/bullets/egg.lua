{
	default = "spawn",

	states = {
		["spawn"] = "data/animations/bullets/egg_spawn.lua",
		["idle"] = "data/animations/bullets/egg.lua"
	},

	properties = {},

	transitions = {
		{ from = "spawn", to = "idle", property = "_finished", value = true }
	}
}
