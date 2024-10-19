local pellet = {pellets={}}

function pellet:update(dt)
    --print(json.encode(self.pellets))
    for k, v in ipairs(self.pellets) do
        v.collider:setLinearVelocity(-v.speed.x , -v.speed.y)
        v.collider:setAngle(3.14-(math.atan2(v.speed.x,v.speed.y)))
        v.pos.x=v.collider:getX()-5.5
        v.pos.y=v.collider:getY()-8
        if (((v.pos.x > 85) or (v.pos.y > 150)) or ((v.pos.x < -100) or (v.pos.y < -175))) then pellet:destroy(k) else
        end
    end
end

function pellet:addPellet(pos,speed, texture, isFriendly)
    --pos={x=0,y=0}, speed={x=0,y=0}, isFriendly=False
    local speed = speed or {x=0, y=100}
    local isFriendly = isFriendly or false
    local collider = world:newRectangleCollider(pos.x-2.5, pos.y-4, 5, 8)
    if isFriendly then
        collider:setCollisionClass('BulletFriendly')
    else 
        collider:setCollisionClass('BulletEnemy')
    end
    collider:setBullet(true)
    collider:setType("kinematic")
    table.insert(self.pellets, {id=self.pelletcount, pos=pos, speed=speed, isFriendly=isFriendly, texture=texture, collider=collider})
end

function pellet:destroy(key)
    self.pellets[key].collider:destroy()
    table.remove(self.pellets, key)
end

function pellet:draw()
    for k, v in ipairs(self.pellets) do
        love.graphics.draw(v.texture, v.pos.x+5.5, v.pos.y+8 , v.collider:getAngle(), 1, 1, v.texture:getWidth()/2, v.texture:getHeight()/2)
    end
end

return pellet