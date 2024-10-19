local state = {state=0}

function state.getState()
    if state == 0 then return "game"
    elseif state == 1 then return "pause"
    elseif state == 2 then return "gameover"
    end
end

return state