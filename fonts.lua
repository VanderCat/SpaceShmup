local fonts = {
    score = love.graphics.newImageFont("img/ScoreFont.png", "0123456789"),
    nice = love.graphics.newImageFont("img/NiceFont.png",
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ" ..
    "abcdefghijklmnopqrstuvwxyz 0123456789.$-~!?:,;@()[]_")
}

return fonts