PlayState = BaseState:new()


function PlayState:new()
    local o = BaseState:new()
    setmetatable(o, self)
    self.__index = self

    o.paddle = Paddle:new()
    o.paused = false


    o.ball = Ball:new(math.random(7))
    o.ball.dx = math.random(-200, 200)
    o.ball.dy = math.random(-50, -60)

    --give ball position in the center
    o.ball.x = VIRTUAL_WIDTH / 2 - 4
    o.ball.y = VIRTUAL_HEIGHT - 42

    o.bricks = LevelMaker.createMap()

    return o
end


function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    
    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then
        self.ball.dy = -self.ball.dy
        gSounds['paddle-hit']:play()
    end


    for _, brick in pairs(self.bricks) do
        -- checks for collisions among the ball and some brick
        if brick.inPlay and self.ball:collides(brick) then
            brick:hit()
        end
    end


    if love.keyboard.wasPressed('q') then
        love.event.quit()
    end
end


function PlayState:render()
    -- render bricks
    for _, brick in pairs(self.bricks) do
        brick:render()
    end


    self.paddle:render()
    self.ball:render()

    if self.paused then
        love.graphics.setFont(gFonts.large)
        love.graphics.printf('PAUSED', 0, VIRTUAL_HEIGHT/2-16, VIRTUAL_WIDTH, 'center')
    end
end