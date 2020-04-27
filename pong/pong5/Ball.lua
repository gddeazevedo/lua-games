--Ball class

Ball = {}

--Constructor

function Ball:new(x, y, width, height)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    --setting atributes
    o.x = x
    o.y = y
    o.width = width
    o.height = height
    
    --variables for velocity
    o.dy = math.random(2) == 1 and -100 or 100
    o.dx = math.random(-50, 50)

    return o
end

--[[
    Places the ball in the middle of the screen and a initial random velocity
    for x and y axis
]]

function Ball:reset()
    self.x = (VIRTUAL_WIDTH / 2) - 2
    self.y = (VIRTUAL_HEIGHT / 2) - 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--[[
    Updating the velocity
]]

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

--Rendering the ball
function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end