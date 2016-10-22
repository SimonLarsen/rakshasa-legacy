{
	default = "deploy",

	states = {
		["deploy"] = "data/animations/purity_drone.lua",
		["disappear"] = "data/animations/purity_drone_disappear.lua"
	},

	properties = {
		["disappear"] = { value = false, isTrigger = true }
	},

	transitions = {
		{ from = "deploy", to = "disappear", property = "disappear", value = true }
	}
}
