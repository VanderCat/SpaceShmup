local state = require('libs/ScreenManager/Screen')
local StateMgr = require('libs/ScreenManager/ScreenManager')
local inGame = {}

function inGame.new()
    local self = state.new()

    world = wf.newWorld(0, 0, true)  -- Создать мир с гравитацией 0
    world:addCollisionClass('Player')
    world:addCollisionClass('Enemy')
    world:addCollisionClass('BulletFriendly', {ignores = {'Player','Enemy'}})
    world:addCollisionClass('BulletEnemy', {ignores = {'Enemy','BulletFriendly','Player'}})
    world:addCollisionClass('PlayerGraze', {ignores = {'Enemy','BulletFriendly','Player','BulletEnemy'}})
    world:addCollisionClass('LevelBounds', {ignores= {'Enemy','BulletFriendly','BulletEnemy'}})

    local bounds = {
        t = world:newRectangleCollider(-63,-128,127,32),
        l = world:newRectangleCollider(-72,-96,9,215),
        r = world:newRectangleCollider(63,-96,9,215),
        d = world:newRectangleCollider(-63,119,126,9)
    }
    for k, v in pairs(bounds) do
        v:setCollisionClass('LevelBounds')
        v:setType('static')
    end
    
    local bg = require('bg')
    local score = {}
    local ss = require("spaceship") -- Загрузить файл космолета
    local PC = require("pelletcontroller") -- Контроллер Выстрелов

    local camera = Camera(0, 0, zoom)      -- Инициализация камеры

    local test = {time = 0, rate = 0.01, counter = 0,}
    
    function self:init()
        local ss = require("spaceship") -- Загрузить файл космолета
        score = require('score')
        spaceship = ss:new(nil,10,10,nil,nil,nil,nil,nil,{timing=0.15,stage=0,power=1},3)
        spaceship:init(PC)
        presence.state="In game"
        fade:unfade("up")
        bgm = snd.loop:play()
        bgm.loop = true
    end

    function self:update(dt)
        if self:isActive() then
            bgm:resume()
            if test.time > test.rate then
                local direction = math.pi*test.counter/2
                PC:addPellet(
                    Vector(
                        math.cos(math.pi-direction+time*10)*15,math.sin(-direction+time*10)*15), Vector(lume.vector(direction+time*10, 200)),spaceship.shottexture, false)
                --PC:addPellet({x=0,y=-40}, {x=-math.sin(time)*200,y=-240},spaceship.shottexture, false)
                test.time = 0
                test.counter = test.counter+1
            end
        
            spaceship:update(dt,score)             -- Управление космолетом и другое связанное с кораблем
            world:update(dt)                 -- Обновление мира
            PC:update(dt)
        
            test.time = test.time + dt
            presence.details = "Score: "..score:get().int
        end
    end

    function self:draw()
        bg:draw(time, shaders.movingBg)

        camera:attach()                  -- Включить отрисовку в камере
            spaceship:draw()             -- Отобразить космический корбаль
            PC:draw()
            --world:draw()
        camera:detach()                  -- Отключить камеру и ее отобразить

        ui:draw(fnt.score,fnt.nice,spaceship.firerate.power*(spaceship.firerate.stage+1),spaceship.health.lives, score:get().string, spaceship)
    end
    
    function self:keypressed( key )
        if key == 'escape' and self:isActive() then
            StateMgr.push('pause')
        end
    end

    function self:close()
        PC.pellets={}
        score:set(0)
    end

    return self
end

return inGame