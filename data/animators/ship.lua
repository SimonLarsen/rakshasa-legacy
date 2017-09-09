{
	default = "idle",

	states = {
		["idle"] = "data/animations/ship_idle.lua",
		["windup"] = "data/animations/ship_windup.lua",
		["winddown"] = "data/animations/ship_winddown.lua",
		["shooting"] = "data/animations/ship_shooting.lua"
	},

	properties = {
		["shooting"] = { value = false }
	},

	transitions = {
		{ from = {"idle", "winddown"}, to = "windup", property="shooting", value = true },
		{ from = "windup", to = "shooting", property = "_finished", value = true },
		{ from = {"windup", "shooting"}, to = "winddown", property = "shooting", value = false },
		{ from = "winddown", to = "idle", property = "_finished", value = true }
	}
}
