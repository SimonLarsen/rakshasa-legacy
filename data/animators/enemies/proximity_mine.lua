{
	default = "idle",

	states = {
		["idle"] = "data/animations/enemies/proximity_mine_idle.lua",
		["detonate"] = "data/animations/enemies/proximity_mine_detonate.lua"
	},

	properties = {
		["detonate"] = { value = false, isTrigger = true }
	},

	transitions = {
		{ from = "idle", to = "detonate", property = "detonate", value = true }
	}
}
