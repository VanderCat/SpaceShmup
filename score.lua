local score = {score = 0}

function score:add(addition)
    self.score = self.score+addition
end

function score:set(score)
    self.score = score
end

function score:get(num)
    local num = num or 12
    local strng = string.rep("0", num-#tostring(self.score))..self.score
    return {string=strng,int=self.score}
end

return score