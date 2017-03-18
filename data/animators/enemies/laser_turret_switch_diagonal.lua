{
	default = "off",

	states = {
		["off"] = "data/animations/enemies/laser_turret_switch_diagonal_off.lua",
		["on"]  = "data/animations/enemies/laser_turret_switch_diagonal_on.lua"
	},

	properties = {
		["state"] = { value = false }
	},

	transitions = {
		{ from = "off", to = "on", property = "state", value = true },
		{ from = "on", to = "off", property = "state", value = false }
	}
}
