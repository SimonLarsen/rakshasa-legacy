local Model = require("bg.Model")
local Curve = class("bg.models.Curve", Model)

function Curve:enter()
	Model.enter(self, "data/models/pipe.edges", 0, -9, -3)
end

function Curve:update(dt, rt)
	self.y = self.y + 2*dt
	self:translate(0, 2*dt, 0)
end

return Curve
