{
	default = "idle",

	states = {
		["idle"] = "data/animations/faces/idle.lua",
		["blink"] = "data/animations/faces/blink.lua",
		["hurt"] = "data/animations/faces/hurt.lua",
		["sword"] = "data/animations/faces/sword.lua"
	},

	properties = {
		["blink"] = { value = false, isTrigger = true },
		["hurt"] = { value = false, isTrigger = true },
		["sword"] = { value = false, isTrigger = true }
	},

	transitions = {
		{ from = "idle", to = "blink", property = "blink", value = true },
		{ from = "idle", to = "hurt", property = "hurt", value = true },
		{ from = "idle", to = "sword", property = "sword", value = true },

		{ from = "blink", to = "idle", property = "_finished", value = true },
		{ from = "blink", to = "hurt", property = "hurt", value = true },
		{ from = "blink", to = "sword", property = "blink", value = true },

		{ from = "hurt", to = "idle", property = "_finished", value = true },
		{ from = "hurt", to = "sword", property = "sword", value = true },

		{ from = "sword", to = "idle", property = "_finished", value = true },
		{ from = "sword", to = "hurt", property = "hurt", value = true }
	}
}
