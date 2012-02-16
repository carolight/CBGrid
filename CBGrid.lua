
--constants
SQUARE_DEFAULT = 0
SQUARE_SELECTED = 1
SQUARE_NOT_SELECTED = 2


--[[
**************
****CBGrid****
**************]]

CBGrid = gideros.class(Sprite)

--calculates the width and height of the grid
function CBGrid:getSize()
	local size = {	width=self.columns*self.columnSpacing, 
					height=self.rows*self.rowSpacing }
	return size
end

function CBGrid:init(rows, columns, rowSpacing, columnSpacing)
	self.rows = rows
	self.columns = columns
	self.rowSpacing = rowSpacing
	self.columnSpacing = columnSpacing
	
	--Defaults
	self.outerLineSize = 4  -- even numbers work better
	self.outerLineColor = 0x333333
	self.outerLineAlpha = 1.0
	self.innerLineSize = 2
	self.innerLineColor = self.outerLineColor
	self.innerLineAlpha = 1.0
	
	self.backgroundColor = 0xdddddd
	
	self.shouldAllowTouch = true; -- allowTouch set by default
	
	self.focus = false
	
	self.gridSquare = {}
	for i = 1, rows do
		self.gridSquare[i] = {}
		for j = 1, columns do
			local square = CBGridSquare.new(self, i , j)
			self:addChild(square)
			square:setX((j * columnSpacing)-columnSpacing)
			square:setY((i * rowSpacing)-rowSpacing)
			self.gridSquare[i][j] = square
		end
	end
end

function CBGrid:draw(x, y)

	local size = self:getSize()
	local rect = {	x=0,
					y=0,
					width=size.width,
					height=size.height }
	
	for i = 1, self.rows-1 do
	
		local rowLine = Shape.new()
		rowLine:setFillStyle(Shape.NONE)
		rowLine:setLineStyle(self.innerLineSize, self.innerLineColor, self.innerLineAlpha)
		rowLine:beginPath()
		rowLine:moveTo(rect.x, rect.y + (i * self.rowSpacing))
		rowLine:lineTo(rect.x + rect.width, rect.y + (i * self.rowSpacing))
		rowLine:closePath()
		rowLine:endPath()
		self:addChild(rowLine)
	end

	for i = 1, self.columns-1 do
		local columnLine = Shape.new()
		
		columnLine:setFillStyle(Shape.NONE)
		columnLine:setLineStyle(self.innerLineSize, self.innerLineColor, self.innerLineAlpha)
		columnLine:beginPath()
		columnLine:moveTo(rect.x + (i * self.columnSpacing), rect.y)
		columnLine:lineTo(rect.x + (i * self.columnSpacing), rect.y + rect.height)
		columnLine:closePath()
		columnLine:endPath()
		self:addChild(columnLine)
	end
	
		--draw outer borders
	local outerBorders = Shape.new()
	
	outerBorders:setFillStyle(Shape.NONE)
	outerBorders:setLineStyle(self.outerLineSize, self.outerLineColor, self.outerLineAlpha)
	outerBorders:beginPath()
	outerBorders:moveTo(rect.x, rect.y)
	outerBorders:lineTo(rect.x+rect.width, rect.y)
	outerBorders:lineTo(rect.x+rect.width, rect.y+rect.height)
	outerBorders:lineTo(rect.x, rect.y+rect.height)
	outerBorders:closePath()
	outerBorders:endPath()

	self:addChild(outerBorders)
	self:setPosition(x, y)
end


