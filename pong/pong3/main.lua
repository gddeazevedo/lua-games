--https://github.com/Ulydev/push
local push = require 'push' --is a resulution handling library

--global window's dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--virtual resolution
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--setting the paddle speed
PADDLE_SPEED = 200


--[[
    Runs at the first start up, only once
    Used to init the game
]]
 
function love.load()
    --changing the default texture scaling
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --font that gives more retro-looking
    smallFont = love.graphics.newFont('font.ttf', 8)

    scoreFont = love.graphics.newFont('font.ttf', 32)

    --seting the love2d's active font
    love.graphics.setFont(smallFont)

    --seting our window
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen=false,
        resizable=false,
        vsync=true
    })

    --init score variables
    player1Score = 0
    player2Score = 0

    --paddle position on the Y axis
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

end


--[[
    Runs every frame, with dt passed in
    dt in secondssince the last frame
]]

function love.update(dt)
    --player 1 movement
    if love.keyboard.isDown('w') then
        --goes up subtracting negative paddle speed to current Y scaled by delta time
        player1Y = player1Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        --goes down, adding paddle speed to the current Y scaled by delta time
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    --player 2 movement
    if love.keyboard.isDown('up') then
        --goes up subtracting negative paddle speed to current Y scaled by delta time
        player2Y = player2Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        --goes down, adding paddle speed to the current Y scaled by delta time
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end


--[[
    Keyboard handling, called by love2d each frame
    Passes in the key we pressed so we can access
]]

function love.keypressed(key)
    --keys can be accessed by string name
    if key == 'q' then
        love.event.quit() --terminates the app
    end
end

--[[
    Called after update by love2d
    Used to draw
]]

function love.draw()
    --begin rendering at virtual resolution
    push:apply('start')

    --clear the screen with a specific color
    --love.graphics.clear(40, 45, 52, 255)

    --[[
        everything between the push:apply('start') and push:apply('end')
        will render at virtual resolution
    ]]

    --draw welcome text toward the top of the screen
    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')



    --draw the score on the left and right center of the screen
    love.graphics.setFont(scoreFont)
    local score1X = (VIRTUAL_WIDTH / 2) - 50
    local score1Y = VIRTUAL_HEIGHT / 3
    local score2X = (VIRTUAL_WIDTH / 2) + 30
    local score2Y = VIRTUAL_HEIGHT / 3
    love.graphics.print(tostring(player1Score), score1X, score1Y)
    love.graphics.print(tostring(player2Score), score2X, score2Y)



    --reder the first paddle (left side)
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    --render the second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10, player2Y, 5, 20)

    --render the ball (center)
    local ballX = (VIRTUAL_WIDTH / 2) - 2
    local ballY = (VIRTUAL_HEIGHT / 2) - 2
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    --end the rendering at virtual resolution
    push:apply('end')
end