if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

Camera = require("libs/hump/camera")        -- Камера из библеотеки hump
Cron = require("libs/cron")
peachy = require("libs/peachy")
Timer = require("libs/hump/timer")          -- Таймер из библеотеки hump
wf = require("libs/windfield")              -- Проверка коллизий
json = require("libs/json")                 -- Дебаг
Fade = require('fade')
flux = require('libs/flux')
tablex = require("libs/penlight/tablex")
lume = require("libs/lume")
bitser = require("libs/bitser")
ripple = require("libs/ripple")
Vector = require("libs.hump.vector")
zoom = 2                                    -- Увеличение
local StateMgr = require('libs/ScreenManager/ScreenManager')
--RPC = require("libs/discordRPC")
local appID = require("misc/discordAppID")

function love.load()                 -- Исполняется при запуске
    local settingsstring, settingssize = love.filesystem.read("settings.bin")
    if settingsstring == nil then
        settings = {
            Volume = {
                SFX = 100,
                Music = 100,
            },
            fps=0
        }
    else
        settings = bitser.loads(settingsstring)
    end
    --RPC.initialize(appID, true)
    love.graphics.setDefaultFilter("nearest")
    fade = Fade.new()
    local now = os.time(os.date("*t"))

    presence = {
        state = "Just Started",
        details = "Testing a game",
        startTimestamp = now,
    }

    local state = {
        ['inGame'] = require('states/inGame'),
        ['pause'] = require('states/pause'),
        ['Main Menu'] = require('states/MainMenu'),
        ['settings'] = require('states/settings')
    }
    
    snd = require('sounds')
    shaders = require('shaders')
    fnt = require('fonts')
    ui = require('UI')
    ec = require('explosion')

    love.graphics.setFont(fnt.nice)

    time = 0
    StateMgr.init(state, 'Main Menu')
    nextPresenceUpdate = 0
end 

function love.update(dt)             -- Исполняется каждый кадр
    ec:update(dt)
    if nextPresenceUpdate < love.timer.getTime() then
        --RPC.updatePresence(presence)
        nextPresenceUpdate = love.timer.getTime() + 2.0
    end
    flux.update(dt)
    time=time+dt
    StateMgr.update(dt)
    --RPC.runCallbacks()
end

function love.draw()                 -- Отрисовывка
    StateMgr.draw()
    ec:draw(50, 50, 0, 2, 2)
    love.graphics.setColor(0.0941176470588235, 0.0862745098039216, 0.1254901960784314, 1)
    fade:draw()
    love.graphics.setColor(1,1,1,1)
end

function love.keypressed(key, scancode, isrepeat)
    StateMgr.keypressed(key, scancode, isrepeat)
end

function love.mousepressed(x, y)
    ec:add("img/SpaceshipExplosion.json","img/SpaceshipExplosion.png","Explosion", {x=x,y=y,sx=zoom,sy=zoom, ox=24, oy=24})
end

function love.quit()
    --RPC.shutdown()
end