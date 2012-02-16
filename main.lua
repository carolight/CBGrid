--[[
*****CBGrid by Caroline Begbie
******************************

This grid allows you to specify number of rows, columns and size of row and columns.

Each square is clickable - 0 = no color, 1 = blue, 2 = red. 
The square colors cycle 0-1-2-0 when clicked.
]]

--CBGrid uses (no of rows, no of columns, size of row, size of columns)
local grid = CBGrid.new(5,6, 40,40)

grid:draw(20,20)

stage:addChild(grid)
