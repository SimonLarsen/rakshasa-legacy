{
	default = "invulnerable",

	states = {
		["invulnerable"] = "data/animations/bosses/durga_shield_right_invulnerable.lua",
		["vulnerable"] = "data/animations/bosses/durga_shield_right.lua"
	},

	properties = {
		["vulnerable"] = { value = 0 }
	},

	transitions = {
		{ from = "vulnerable", to = "invulnerable", property = "vulnerable", value = 0 },
		{ from = "invulnerable", to = "vulnerable", property = "vulnerable", value = 1 }
	}
}
