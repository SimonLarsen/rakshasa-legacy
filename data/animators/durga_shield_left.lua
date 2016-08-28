{
	default = "invulnerable",

	states = {
		["invulnerable"] = "data/animations/durga_shield_left_invulnerable.lua",
		["vulnerable"] = "data/animations/durga_shield_left.lua"
	},

	properties = {
		["vulnerable"] = { value = 0 }
	},

	transitions = {
		{ from = "vulnerable", to = "invulnerable", property = "vulnerable", value = 0 },
		{ from = "invulnerable", to = "vulnerable", property = "vulnerable", value = 1 }
	}
}
