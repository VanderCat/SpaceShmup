local ui = {round=love.graphics.newImage("img/angle.png")}

function ui:draw(scorefont,uifont,power,hp, score,spaceship)
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0.0941176470588235, 0.0862745098039216, 0.1254901960784314, 1)
    love.graphics.rectangle("fill", 0, 0, 288, 64)
    love.graphics.rectangle("fill", 0, 64, 18, 430)
    love.graphics.rectangle("fill", 270, 64, 18, 430)
    love.graphics.rectangle("fill", 0, 494, 288, 18)
    love.graphics.setColor(r, g, b, a)

    local font = love.graphics.getFont()

    love.graphics.setFont(scorefont)
    love.graphics.print(score, 24, 16, 0, 2, 2)

    love.graphics.setFont(uifont)
    --Shadow
    love.graphics.setColor(0.0941176470588235, 0.0862745098039216, 0.1254901960784314, 1)
    love.graphics.print("PWR: "..power, 26, 74, 0, 2, 2)
    love.graphics.print("HP:  "..hp, 26, 96, 0, 2, 2)
    if settings.fps == 1 then love.graphics.print("FPS:  "..love.timer.getFPS(), 26, 118, 0, 2, 2) end
    love.graphics.setColor(r, g, b, a)

    love.graphics.print("PWR: "..power, 26, 72, 0, 2, 2)
    love.graphics.print("HP:  "..hp, 26, 94, 0, 2, 2)
    if settings.fps == 1 then love.graphics.print("FPS:  "..love.timer.getFPS(), 26, 116, 0, 2, 2) end

    
    --[[love.graphics.print(         -- Вывести отладочную информацию
        "Spaceship: "..
        "\n\tPos: "..
        "\n\t\tX: "..spaceship.x..
        "\n\t\tY: "..spaceship.y..
        "\n\tSpeed: "..spaceship.speed/(1+(spaceship.isSlowed and 1 or 0))..
        "\n\tIs Slowed?: "..(spaceship.isSlowed and 1 or 0)..
        "\n\tStage: "..spaceship.firerate.stage..
        "\n\tPower: "..spaceship.firerate.power.. 
        "\n\tLives: "..spaceship.health.lives.. 
        "\n\tRecovery: ".. (spaceship.health.recovery.inRecovery and 1 or 0), 18, 120
    )]]
    love.graphics.setFont(font)
end

function ui:angledRec8(x,y,w,zoom,col)
    col = col or {r=1,g=1,b=1,a=1}
    zoom = zoom or 1
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(col.r, col.g, col.b, col.a)
    love.graphics.rectangle("fill", (x+3)*zoom, y*zoom, (w-6)*zoom, 8*zoom)
    love.graphics.draw(self.round, (x+w-3)*zoom, (y+2)*zoom, 0, zoom, zoom)
    love.graphics.draw(self.round, (x+3)*zoom, (y+2)*zoom, 0, -zoom, zoom)
    love.graphics.setColor(r, g, b, a)
end

return ui