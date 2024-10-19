local sounds = {
    tags = {
        music = ripple.newTag(),
        sfx = ripple.newTag()
    }
}

sounds.shot     = ripple.newSound(love.audio.newSource("sounds/shot.wav",     "static"), {tags={sounds.tags.sfx  }})
sounds.hitPl    = ripple.newSound(love.audio.newSource("sounds/hit.wav",      "static"), {tags={sounds.tags.sfx  }})
sounds.graze    = ripple.newSound(love.audio.newSource("sounds/graze.wav",    "static"), {tags={sounds.tags.sfx  }})
sounds.hitEn    = ripple.newSound(love.audio.newSource("sounds/hitenemy.wav", "static"), {tags={sounds.tags.sfx  }})
sounds.loopold  = ripple.newSound(love.audio.newSource("sounds/loop.wav",     "stream"), {tags={sounds.tags.music}})
sounds.loop     = ripple.newSound(love.audio.newSource("sounds/bgm.flac",     "stream"), {tags={sounds.tags.music}})
sounds.sel      = ripple.newSound(love.audio.newSource("sounds/select.wav",   "static"), {tags={sounds.tags.sfx  }})
sounds.activate = ripple.newSound(love.audio.newSource("sounds/activate.wav", "static"), {tags={sounds.tags.sfx  }})

return sounds