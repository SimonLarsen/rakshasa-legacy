{
	default = "armed",

	states = {
		["armed"] = "data/animations/enemies/bunker_armed.lua",
		["unarmed"] = "data/animations/enemies/bunker_unarmed.lua"
	},

	properties = {
		["armed"] = { value = true }

	},

	transitions = {
		{ from = "armed", to = "unarmed", property = "armed", value = false }
	}
}
