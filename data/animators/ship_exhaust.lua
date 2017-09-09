{
	default = "large",

	states = {
		["large"] = "data/animations/ship_exhaust_large.lua",
		["small"] = "data/animations/ship_exhaust_small.lua"
	},

	properties = {
		["shooting"] = { value = false }
	},

	transitions = {
		{ from = "large", to = "small", property = "shooting", value = true },
		{ from = "small", to = "large", property = "shooting", value = false }
	}
}
