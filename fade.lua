local fade = {}

function fade:new()
    local obj = {y=272*zoom,triag=love.graphics.newImage('img/fadetriag.png')}
    obj.w, obj.h = love.graphics.getDimensions()
    obj.wImg = obj.triag:getWidth()
    function obj:draw()
        love.graphics.rectangle("fill", 0, self.y, self.w, self.h)

        for i = 0, self.w/self.wImg do
            love.graphics.draw(self.triag, i*self.wImg*zoom, self.y+self.h, 0, zoom, zoom)
            love.graphics.draw(self.triag, i*self.wImg*zoom, self.y, 0, zoom, -zoom)
        end
    end
    function obj:fade(direction,callback)
        callback = callback or function() end
        local animation = {}
        if direction == "up" then
            self.y = 272*zoom
            animation = {y=0}
        else 
            self.y = -272*zoom
            animation = {y=0}
        end
        flux.to(self, 0.2, animation):oncomplete(callback)
    end
    function obj:unfade(direction,callback)
        callback = callback or function() end
        local animation = {}
        if direction == "up" then
            self.y = 0
            animation = {y=-272*zoom}
        else 
            self.y = 0
            animation = {y=272*zoom}
        end
        flux.to(self, 0.2, animation):oncomplete(callback)
    end
    return obj
end

return fade