require 'Paddle'
require 'Ball'

--https://github.com/Ulydev/push
push = require 'push' --is a resulution handling library

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

    math.randomseed(os.time())

    --font that gives more retro-looking
    smallFont = love.graphics.newFont('font.ttf', 8)

    --seting the love2d's active font
    love.graphics.setFont(smallFont)

    love.window.setTitle("Pong")

    --seting our window
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen=false,
        resizable=false,
        vsync=true
    })

    --initialize the players
    player1 = Paddle:new(10, 30, 5, 20)
    player2 = Paddle:new(VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT-30, 5, 20)

    --place the ball in the middle of the screen
    ball = Ball:new(VIRTUAL_WIDTH/2-2, VIRTUAL_HEIGHT/2-2, 4, 4)


    --game state variable used to transition between different parts of the game
    gameState = 'start'
end


--[[
    Runs every frame, with dt passed in
    dt in secondssince the last frame
]]

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    --update our ball based on its dx and dy only if we're in play state
    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end


--[[
    Keyboard handling, called by love2d each frame
    Passes in the key we pressed so we can access
]]

function love.keypressed(key)
    --keys can be accessed by string name
    if key == 'q' then
        love.event.quit() --terminates the app
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            --reseting the ball
            ball:reset()
        end
    end
end


--[[
    Called after update by love2d
    Used to draw
]]

function love.draw()
    --begin rendering at virtual resolution
    push:apply('start')
    --[[
        everything between the push:apply('start') and push:apply('end')
        will render at virtual resolution
    ]]

    --draw welcome text toward the top of the screen
    love.graphics.setFont(smallFont)

    local text = nil

    if gameState == 'start' then
        text = 'Hello Start State!'
    else
        text = 'Hello Play State!'
    end

    love.graphics.printf(text, 0, 20, VIRTUAL_WIDTH, 'center')

    
    --rendering the paddles
    player1:render()
    player2:render()

    --rendering the ball
    ball:render()


    --end the rendering at virtual resolution
    push:apply('end')
end