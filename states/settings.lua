local state = require('libs/ScreenManager/Screen')
local StateMgr = require('libs/ScreenManager/ScreenManager')
local menu = {}

function menu.new()
    local self = state.new()

    local function back()
        settings = {
            Volume = {
                SFX = layout.lt.volumesfx.value,
                Music = layout.lt.volumemusic.value
            },
            fps=layout.lt.fps.value
        }
        
        print(love.filesystem.write("settings.bin", bitser.dumps(settings)))
        fade:fade("up", function() StateMgr.switch("Main Menu") end)
    end

    function self:init()
        fade:unfade("up")
        bg = require('bg')
        layout = require('layout/main').new()
        layout:addButton("back",-8, 10, nil,"Back",back, nil,"right")
        layout:addValue("volumesfx",4,25,136,"Volume SFX",settings.Volume.SFX)
        layout:addValue("volumemusic",4,39,136,"Volume Music",settings.Volume.Music)
        layout:addValue("fps",4,53,136,"Show FPS?",settings.fps,0,1)
        layout:select(0)
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
        if key == 'r' then
            fade:fade("up", function() StateMgr.switch("settings") end)
        end
        if key == 'z' then
            snd.activate:play()
            layout:activateSelected()
        end
        if key == 'right' then
            layout:incrementSelected(5)
        end
        if key == 'left' then
            layout:incrementSelected(-5)
        end
    end
    
    function self:draw()
        bg:draw(time, shaders.movingBg)
        layout:draw(ui, zoom)
    end

    return self
end

return menu