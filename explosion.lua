exp = {explosions={}}

function exp:add(json, path, tag, drawtable)
    --drawtable = {x, y, rot, sx, sy, ox, oy}
    local explosion = {
        anim=peachy.new(json, love.graphics.newImage(path), tag),
        isEnded=false,
        draw=drawtable
    }
    explosion.anim:onLoop(function() explosion.anim:pause() explosion.isEnded=true end)
    table.insert(self.explosions, explosion)
end

function exp:update(dt)
    for k,v in ipairs(self.explosions) do 
        if v.isEnded then
            self:destroy(k)
        else
            v.anim:update(dt)
        end
    end
end

function exp:draw()
    for k,v in ipairs(self.explosions) do 
            v.anim:draw(v.draw.x, v.draw.y, v.draw.rot, v.draw.sx, v.draw.sy, v.draw.ox, v.draw.oy)
    end
end

function exp:destroy(key)
    table.remove(self.explosions, key)
end

return exp