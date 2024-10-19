local spaceship = {              -- Объект космического корабля
    type="player",               -- Тип
    x=10,                        -- Начальное положение квадрата по оси X
    y=10,                        -- Начальное положение квадрата по оси Y
    vel={
        x=0,
        y=0
    },
    speed = 85,                  -- Скорость передвижения квадрата
    texture = love.graphics.newImage("img/spaceship.png"),          -- Текстура космического корабля
    firetexture = love.graphics.newImage("img/spaceshipfire.png"),  -- Текстура космического корабля
    shottexture = love.graphics.newImage("img/shot.png"),           -- Текстура выстрела
    hitboxtexture = love.graphics.newImage("img/hitbox.png"),       -- Текстура хитбокса
    isSlowed = false,            -- Корабль замедлен?
    firerate = {                 -- Класс
        timing=0.15,             -- Время между выстрелами
        stage=0,                 -- Уровень мощи
        power=1                  -- Сила
    },
    health = {lives=3, recovery={timing=2.5, inRecovery=false}},
    notVisible = false
}

function spaceship:new(type,x,y,speed,texture,firetexture,shottexture,hitboxtexture,firerate,lives,recovery)
    local temp = self
    temp.type=type or self.type                     -- Тип
    temp.x=x or self.x                        -- Начальное положение квадрата по оси X
    temp.y=y or self.y                        -- Начальное положение квадрата по оси Y
    temp.vel.y=0
    temp.vel.y=0
    temp.speed = speed or self.speed                   -- Скорость передвижения квадрата
    temp.texture = texture or self.texture                -- Текстура космического корабля
    temp.firetexture = firetexture or self.firetexture            -- Текстура космического корабля
    temp.shottexture = shottexture or self.shottexture            -- Текстура выстрела
    temp.hitboxtexture = hitboxtexture or self.hitboxtexture          -- Текстура хитбокса
    temp.firerate = firerate or self.firerate
    temp.health = {lives=lives or self.health.lives, recovery=recovery or self.health.recovery}
    temp.collider = world:newCircleCollider(temp.x+22, temp.y+12, 3)
    temp.collider:setCollisionClass('Player')
    temp.graze = world:newCircleCollider(temp.x+22, temp.y+12, 10)
    temp.graze:setCollisionClass('PlayerGraze')
    temp.graze:setSensor(true)
    return temp
end
function spaceship:fire(PC)
    if (love.keyboard.isDown("z")) then
        if spaceship.firerate.stage == 0 then
            PC:addPellet({x=spaceship.x+16.5,y=spaceship.y-4}, {x=0,y=200*spaceship.firerate.power},spaceship.shottexture,true)
        elseif spaceship.firerate.stage == 1 then 
            PC:addPellet({x=spaceship.x+28.5,y=spaceship.y+2},{x=0,y=200*spaceship.firerate.power},spaceship.shottexture,true)
            PC:addPellet({x=spaceship.x+4.5,y=spaceship.y+2},{x=0,y=200*spaceship.firerate.power},spaceship.shottexture,true)
        elseif spaceship.firerate.stage == 2 then 
            PC:addPellet({x=spaceship.x+28.5,y=spaceship.y+2},{x=-20,y=200*spaceship.firerate.power},spaceship.shottexture,true)
            PC:addPellet({x=spaceship.x+4.5,y=spaceship.y+2},{x=20,y=200*spaceship.firerate.power},spaceship.shottexture,true)
            PC:addPellet({x=spaceship.x+16.5,y=spaceship.y-4},{x=0,y=200*spaceship.firerate.power},spaceship.shottexture,true)
        end
        snd.shot:play()
    end
end
function spaceship:init(PC)
    self.firerate.clock = Cron.every(self.firerate.timing, self.fire, self, PC)
    self.health.recovery.clockHide = Cron.every(0.1, function() self.notVisible = not self.notVisible end)
    self.health.recovery.clock = Cron.after(self.health.recovery.timing, function() self.health.recovery.inRecovery = false end)
end
function spaceship:update(dt,score)    -- функция для управления
    if (love.keyboard.isDown("lshift")) then 
        self.isSlowed = true 
    else 
        self.isSlowed = false 
    end                          -- Если нажата клавиша X то замедлить Корабль
    self.firerate.clock:update(dt)
    self.health.recovery.clock:update(dt)
    if self.firerate.power > 3 then 
        self.firerate.power=1
        self.firerate.stage=self.firerate.stage+1
    end
    if (love.keyboard.isDown("=")) then self.firerate.power=self.firerate.power+1 end
    if (love.keyboard.isDown("-")) then score:add(200) end
    spaceship.collider:setLinearVelocity(
        (self.speed/(1+(self.isSlowed and 1 or 0)))*((love.keyboard.isDown("left") and -1 or 0)+(love.keyboard.isDown("right") and 1 or 0)),
        (self.speed/(1+(self.isSlowed and 1 or 0)))*((love.keyboard.isDown("up") and -1 or 0)+(love.keyboard.isDown("down") and 1 or 0)))
    self.x = spaceship.collider:getX()-22
    self.y = spaceship.collider:getY()-12
    spaceship.graze:setPosition(self.x+22, self.y+12)
    self.health.recovery.clock:update(dt)
    if self.collider:enter('BulletEnemy') and not self.health.recovery.inRecovery then
        print('hit')
        self.health.lives=self.health.lives-1
        self.health.recovery.inRecovery = true
        if self.health.recovery.inRecovery then self.health.recovery.clock = Cron.after(self.health.recovery.timing, function() self.health.recovery.inRecovery = false end) end
        snd.hitPl:play()
    end
    if self.graze:exit('BulletEnemy') and not self.health.recovery.inRecovery then 
        score:add(250)
        snd.graze:play()
    end
    if self.health.recovery.inRecovery then self.health.recovery.clockHide:update(dt) else self.notVisible = false end 
end

function spaceship:draw()
    love.graphics.draw(spaceship.texture, spaceship.x, spaceship.y, 0, 1-(self.notVisible and 1 or 0), 1-(self.notVisible and 1 or 0)) -- Отобразить космический корбаль с заданными параметрами
    if not self.isSlowed then
        love.graphics.draw(spaceship.firetexture, spaceship.x+10, spaceship.y+20) -- Отобразить работу огня когда объект не замедлен
    else 
        love.graphics.draw(spaceship.hitboxtexture, spaceship.x+19, spaceship.y+9) -- Отобразить работу огня когда объект не замедлен
    end
end

return spaceship -- Вернуть объект