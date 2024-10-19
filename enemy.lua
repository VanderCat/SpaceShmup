enemy = {enemies={}}

function enemy:update(dt)
    print(json.encode(self.enemies))
    for k, v in ipairs(self.enemies) do
        v.collider:setLinearVelocity(-v.speed.x , -v.speed.y)
        v.collider:setAngle(3.14-(math.atan2((v.pos.x-v.pos.x+v.speed.x),(v.pos.y-v.pos.y+v.speed.y))))
        v.pos.x=v.collider:getX()-5.5
        v.pos.y=v.collider:getY()-8
        if (v.pos.x > 85) or ((v.pos.x < -100) or (v.pos.y < -175)) then enemy:destroy(k) end
        local actualX, actualY, cols, len = world:check("pellet_"..k, self.x, self.y, "cross")
    end
end

function enemy:addEnemy(pos,speed,isFriendly)
    --pos={x=0,y=0}, speed={x=0,y=0}, isFriendly=False
    speed = speed or {x=0, y=100}
    table.insert(self.pellets, {pos=pos, speed=speed, firerate={}})
end

function enemy:destroy(key)
    table.remove(self.enemies, key)
end

function enemy:draw()
    for k, v in ipairs(self.pellets) do
        love.graphics.ellipse("fill", v.pos.x, v.pos.y, 20, 40)
    end
end

return enemy