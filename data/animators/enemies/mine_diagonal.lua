{
	default = "idle",

	states = {
		["idle"] = "data/animations/enemies/mine_diagonal.lua",
		["detonate"] = "data/animations/enemies/mine_diagonal_detonate.lua"
	},

	properties = {
		["detonate"] = { value = false, isTrigger = true }
	},

	transitions = {
		{ from = "idle", to = "detonate", property = "detonate", value = true }
	}
}
