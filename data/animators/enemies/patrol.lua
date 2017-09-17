{
	default = "enter",

	states = {
		["enter"] = "data/animations/enemies/patrol_enter.lua",
		["transform"] = "data/animations/enemies/patrol_transform.lua",
		["idle"] = "data/animations/enemies/patrol_idle.lua"
	},

	properties = {
		["transform"] = { value = false, isTrigger = true }
	},

	transitions = {
		{ from = "enter", to = "transform", property = "transform", value = true },
		{ from = "transform", to = "idle", property = "_finished", value = true }
	}
}
