--https://github.com/Ulydev/push
local push = require 'push' --is a resulution handling library

--global window's dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--virtual resolution
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


--[[
    Runs at the first start up, only once
    Used to init the game
]]
 
function love.load()
    --changing the default texture scaling
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --seting our window
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen=false,
        resizable=false,
        vsync=true
    })
end


--[[
    Keyboard handling, called by love2d each frame
    Passes in the key we pressed so we can access
]]

function love.keypressed(key)
    --keys can be accessed by string name
    if key == 'escape' then
        love.event.quit() --terminates the app
    end
end

--[[
    Called after update by love2d
    Used to draw
]]

function love.draw()
    local text = "Hello Pong!"
    local x = 0
    local y = (VIRTUAL_HEIGHT / 2) - 6

    --begin rendering at virtual resolution
    push:apply('start')

    --[[
        everything between the push:apply('start') and push:apply('end')
        will render at virtual resolution
    ]]

    love.graphics.printf(text, x, y, VIRTUAL_WIDTH, 'center')

    --end the rendering at virtual resolution
    push:apply('end')
end