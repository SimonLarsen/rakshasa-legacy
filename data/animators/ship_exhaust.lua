{
	default = "large",

	states = {
		["large"] = "data/animations/ship_exhaust_large.lua",
		["small"] = "data/animations/ship_exhaust_small.lua",
		["increase"] = "data/animations/ship_exhaust_increase.lua",
		["decrease"] = "data/animations/ship_exhaust_decrease.lua"
	},

	properties = {
		["shooting"] = { value = false }
	},

	transitions = {
		{ from = {"large","increase"}, to = "decrease", property = "shooting", value = true },
		{ from = "decrease", to = "small", property = "_finished", value = true },
		{ from = {"small","decrease"}, to = "increase", property = "shooting", value = false },
		{ from = "increase", to = "large", property = "_finished", value = true }
	}
}
