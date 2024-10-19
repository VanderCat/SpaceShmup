local state = require('libs/ScreenManager/Screen')
local StateMgr = require('libs/ScreenManager/ScreenManager')
local pause = {}

function pause.new()
    local self = state.new()

    function self:init()
        print("paused")
        layout = require('layout/main').new()

        layout:addButton("resume",35, 104, nil,"Resume", function() 
            StateMgr.pop() 
            presence.state="In game" 
            selected = nil 
        end)
        layout:addButton("mainmenu",24.5, 136, nil,"Main Menu", function() 
            fade:fade("up", function() 
                StateMgr.switch("Main Menu") 
            end) 
        end)
        layout:select(1)

        presence.state="Paused"
        bgm:pause()
    end

    function self:draw() 
        local r, g, b, a = love.graphics.getColor()
        local w, h = love.graphics.getDimensions()
        love.graphics.setColor(0, 0, 0, 0.25)
        love.graphics.rectangle("fill", 0, 0, w, h)
        love.graphics.setColor(0.0941176470588235, 0.0862745098039216, 0.1254901960784314, 1)
        love.graphics.print("Paused", w/2-42, 130, 0, 2, 2)
        love.graphics.setColor(r, g, b, a)

        love.graphics.print("Paused", w/2-42, 128, 0, 2, 2)

        layout:draw(ui,zoom)

    end

    function self:update(dt)
    end
    
    function self:keypressed( key )
        if key == 'up' then 
            layout:prev()
            snd.sel:play()
        end
        if key == 'down' then 
            layout:next()
            snd.sel:play()
        end

        if key == 'z' then
            layout:activateSelected()
        end
        if key == 'escape' then
            StateMgr.pop()
            presence.state="In game"
        end
    end
    return self
end

return pause