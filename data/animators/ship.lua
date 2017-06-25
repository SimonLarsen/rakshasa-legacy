{
	default = "idle",

	states = {
		["idle"] = "data/animations/ship_idle.lua",
		["semi_left"] = "data/animations/ship_semi_left.lua",
		["semi_right"] = "data/animations/ship_semi_right.lua",
		["turn_left"] = "data/animations/ship_turn_left.lua",
		["turn_right"] = "data/animations/ship_turn_right.lua"
	},

	properties = {
		["xspeed"] = { value = 0 }
	},

	transitions = {
		{ from = "semi_left", to = "turn_left", property = "xspeed", predicate = function(x) return x < -100 end },
		{ from = "turn_left", to = "semi_left", property = "xspeed", predicate = function(x) return x >= -100 end },
		{ from = "idle", to = "semi_left", property = "xspeed", predicate = function(x) return x < -20 end },
		{ from = "semi_left", to = "idle", property = "xspeed", predicate = function(x) return x >= -20 end },
		{ from = "idle", to = "semi_right", property = "xspeed", predicate = function(x) return x > 20 end },
		{ from = "semi_right", to = "idle", property = "xspeed", predicate = function(x) return x <= 20 end },
		{ from = "semi_right", to = "turn_right", property = "xspeed", predicate = function(x) return x > 100 end },
		{ from = "turn_right", to = "semi_right", property = "xspeed", predicate = function(x) return x <= 100 end }
	}
}
