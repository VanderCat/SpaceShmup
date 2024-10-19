layout = {
    logo = {
        x=3*zoom,
        y=36*zoom,
        img=love.graphics.newImage("img/logo.png")
    },
    buttons = {
        play = {
            x = -19,
            y = 104,
            w = 61,
            text = "Play",
            offset = 16,
        },
        options = {
            x = -19,
            y = 136,
            w = 84,
            text = "Options",
            offset = 16
        },
        hiScore = {
            x = -19,
            y = 168,
            w = 91,
            text = "Hi-Score",
            offset = 16
        },
        quit = {
            x = 105,
            y = 200,
            w = 54,
            text = "Quit",
            offset = -16
        }
    }
}

return layout