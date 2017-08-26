{
	default = "idle",

	states = {
		["idle"] = "data/animations/faces/idle.lua",
		["blink"] = "data/animations/faces/blink.lua",
		["hurt"] = "data/animations/faces/hurt.lua",
		["sword"] = "data/animations/faces/sword.lua",
		["shooting"] = "data/animations/faces/shooting.lua"
	},

	properties = {
		["blink"] = { value = false, isTrigger = true },
		["hurt"] = { value = false, isTrigger = true },
		["sword"] = { value = false, isTrigger = true },
		["shooting"] = { value = false }
	},

	transitions = {
		{ from = "idle", to = "blink", property = "blink", value = true },

		{ from = {"idle","blink"}, to = "shooting", property = "shooting", value = true },
		{ from = "shooting", to = "idle", property = "shooting", value = false},

		{ from = {"blink","hurt","sword"}, to = "idle", property = "_finished", value = true },

		{ from = {"idle","blink","sword","shooting"}, to = "hurt", property = "hurt", value = true },
		{ from = {"idle","blink","hurt","shooting"}, to = "sword", property = "sword", value = true },

	}
}
