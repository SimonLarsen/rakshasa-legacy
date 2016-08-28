{
	default = "idle",

	states = {
		["idle"] = "data/animations/enemy_mine.lua",
		["detonate"] = "data/animations/enemy_mine_detonate.lua"
	},

	properties = {
		["detonate"] = { value = false, isTrigger = true }
	},

	transitions = {
		{ from = "idle", to = "detonate", property = "detonate", value = true }
	}
}
