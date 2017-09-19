{
	default = "pant",

	states = {
		["idle"] = "data/animations/bosses/fear_face_idle.lua",
		["blink"] = "data/animations/bosses/fear_face_blink.lua",
		["rage"] = "data/animations/bosses/fear_face_rage.lua",
		["pant"] = "data/animations/bosses/fear_face_pant.lua",
		["puke"] = "data/animations/bosses/fear_face_puke.lua"
	},

	properties = {
		["blink"] = { value = false, isTrigger = true },
		["rage"] = { value = false, isTrigger = true },
		["puke"] = { value = false, isTrigger = true }
	},

	transitions = {
		{ from = "idle", to = "blink", property = "blink", value = true },
		{ from = "blink", to = "idle", property = "_finished", value = true },

		{ from = {"idle","blink"}, to = "rage", property = "rage", value = true },
		{ from = "rage", to = "pant", property = "_finished", value = true },

		{ from = "pant", to = "puke", property = "puke", value = true },
		{ from = "puke", to = "pant", property = "_finished", value = true }
	}
}
