--[[
**************
****CBGridSquare****
**************]]

CBGridSquare = gideros.class(Sprite)

function CBGridSquare:createShape(color)

	--remove the old shape
	for index = 1, self:getNumChildren() do
		self:removeChildAt(1)
	end
	
	--create the shape
	
	local x = 0
	local y = 0
	
	local shape = Shape.new()
	shape:setFillStyle(Shape.SOLID, color)
	shape:setLineStyle(0)
	shape:beginPath()
	shape:moveTo(x, y)
	shape:lineTo(x + self.width, y)
	shape:lineTo(x + self.width, y + self.height)
	shape:lineTo(x, y + self.height)
	shape:closePath()
	shape:endPath()
	self:addChild(shape)
end

function CBGridSquare:onMouseUp(event)
	local grid = self:getParent()
	self.focus = false
	if self:hitTestPoint(event.x, event.y) then
		event:stopPropagation()

		self.focus = true
		grid.focusSquare = self
		
		self.selected = self.selected + 1
		if self.selected > SQUARE_NOT_SELECTED then
			self.selected = SQUARE_DEFAULT
		end
	
		local color = grid.backgroundColor
		if self.selected == SQUARE_SELECTED then
			color = 0x0000ff
		elseif self.selected == SQUARE_NOT_SELECTED then
			color = 0xff0000
		end
		self:createShape(color)
	end
end


function CBGridSquare:init(grid, row, column)
	self.row = row
	self.column = column
	self.width = grid.columnSpacing
	self.height = grid.rowSpacing
	self.selected = SQUARE_DEFAULT
	self.shape = nil 
	self.focus = false
	if grid.shouldAllowTouch then
		self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
	end
	
	self:createShape(grid.backgroundColor)
end




