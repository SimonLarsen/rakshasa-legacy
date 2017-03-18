{
	default = "off",

	states = {
		["off"] = "data/animations/enemies/laser_turret_switch_orthogonal_off.lua",
		["on"]  = "data/animations/enemies/laser_turret_switch_orthogonal_on.lua"
	},

	properties = {
		["state"] = { value = false }
	},

	transitions = {
		{ from = "off", to = "on", property = "state", value = true },
		{ from = "on", to = "off", property = "state", value = false }
	}
}
