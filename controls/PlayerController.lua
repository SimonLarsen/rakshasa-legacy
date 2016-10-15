local PlayerController = class("controls.PlayerController", prox.Entity)

function PlayerController:enter(binding, ship_left, ship_right, chain)
	self.binding = binding
	self.ship_left = ship_left
	self.ship_right = ship_right
	self.chain = chain
end

return PlayerController
