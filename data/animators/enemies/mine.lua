{
	default = "idle",

	states = {
		["idle"] = "data/animations/enemies/mine.lua",
		["detonate"] = "data/animations/enemies/mine_detonate.lua"
	},

	properties = {
		["detonate"] = { value = false, isTrigger = true }
	},

	transitions = {
		{ from = "idle", to = "detonate", property = "detonate", value = true }
	}
}
