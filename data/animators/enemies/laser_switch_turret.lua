{
	default = "on",

	states = {
		["on"] = "data/animations/enemies/laser_switch_turret_on.lua",
		["off"] = "data/animations/enemies/laser_switch_turret_off.lua"
	},

	properties = {
		["state"] = { value = true }
	},

	transitions = {
		{ from = "on", to = "off", property = "state", value = false }
	}
}
