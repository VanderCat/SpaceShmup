local state = require('libs/ScreenManager/Screen')
local StateMgr = require('libs/ScreenManager/ScreenManager')
local menu = {}

function menu.new()
    local self = state.new()

    function self:init()
        snd.tags.sfx.volume = settings.Volume.SFX/100
        snd.tags.music.volume = settings.Volume.Music/100
        PC = {}
        PC.pellets = nil
        camera = nil
        test = nil
        world = nil
        spaceship = nil 
        bg = require('bg')
        layout = require('layout/main').new()
        layout:addButton("play",-8, 104, nil,"Play", function() fade:fade("up", function() StateMgr.switch("inGame") end) end,nil,"right")
        layout:addButton("hiscore",-8, 136, nil,"Hi-Score", function() end,nil,"right")
        layout:addButton("settings",-8, 168, nil,"Settings", function() fade:fade("up", function() StateMgr.switch("settings") end) end,nil,"right")
        layout:addButton("quit",95, 200, nil,"Quit :(", function()love.event.quit()end,nil,"left")
        layout:select(0)
        fade:unfade("up")
    end

    function self:keypressed(key)
        if key == 'up' then 
            layout:prev()
            snd.sel:play()
        end
        if key == 'down' then 
            layout:next()
            snd.sel:play()
        end

        if key == 's' then
            fade:fade("up")
        elseif key == 'w' then
            fade:unfade("up")
        elseif key == 'd' then
            fade:fade()
        elseif key == 'e' then
            fade:unfade()
        end

        if key == 'z' then
            snd.activate:play()
            layout:activateSelected()
        end
    end

    function self:update(dt)
    end

    function self:draw()
        bg:draw(time, shaders.movingBg)
        layout:draw(ui, zoom)
    end

    return self
end

return menu