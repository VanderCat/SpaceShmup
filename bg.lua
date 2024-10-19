local bg = {
     tex = love.graphics.newImage("img/bg.png") -- Текстура фона
     }

function bg:draw(time,shader)
    love.graphics.setShader(shader)
    shader:send('time', time)
    love.graphics.draw(self.tex, 0, 0, 0, 2, 2) -- Отрисовать фон
    love.graphics.setShader()
end


return bg 