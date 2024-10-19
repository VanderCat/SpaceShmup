--[[
    Copyright © 2021 VanderCat

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the “Software”), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is furnished
    to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
    INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
    PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
    USE OR OTHER DEALINGS IN THE SOFTWARE.
]]
layout = {}

function layout.new()
    local obj = {
        lt={},
        ltcount=0,
        selected=0
    }
    function obj:addButton(name, x, y, w, text, func, selOffset, textAlign, buttonColor, textColor, selButtonColor, selTextColor, animationSelected, animationDeselected)
        textAlign = textAlign or "center"
        buttonColor = buttonColor or {r=0.0941176470588235, g=0.0862745098039216, b=0.1254901960784314, a=1}
        selButtonColor = selButtonColor or buttonColor
        selTextColor = selTextColor or {r=1,g=0.9882352941176471,b=0.2509803921568627,a=1}
        textColor = textColor or {r=1,g=1,b=1,a=1}
        animationSelected = animationSelected or {time=1, ease="elasticout"}
        animationDeselected = animationDeselected or {time=0.25, ease="quadout"}
        selOffset = selOffset or 16
        w = w or (#text*7)+32
        local to = {}
        if textAlign == "center" then 
            to = {w=w+selOffset,x=x-(selOffset/2)}
        elseif textAlign == "right" then
            to = {w=w+selOffset}
        elseif textAlign == "left" then
            to = {w=w+selOffset, x=x-selOffset}
        end
        local button = {
            type="button",
            x=x,
            y=y,
            w=w,
            const={
                x=x,
                y=y,
                w=w
            },
            text=text,
            align=textAlign,
            selected=false,
            colors={
                text=textColor, 
                button=buttonColor, 
                selected={
                    text=selTextColor,
                    button=selButtonColor
                }
            },
            anim = {
                selected=animationSelected,
                deselected=animationDeselected,
                selectionOffset=selOffset,
                to=to
            },
            activate=func,
            id=self.ltcount
        }
        self.ltcount=self.ltcount+1
        print(button.id)
        function button:draw(ui, zoom)
            local r,g,b,a = love.graphics.getColor()
            local col = {}

            if self.selected then 
                col = self.colors.selected.button
                love.graphics.setColor(self.colors.selected.text.r, self.colors.selected.text.g, self.colors.selected.text.b, self.colors.selected.text.a)
            else
                col = self.colors.button
                love.graphics.setColor(self.colors.text.r, self.colors.text.g, self.colors.text.b, self.colors.text.a)
            end

            ui:angledRec8(self.x, self.y, self.w, zoom, col)
            love.graphics.printf(self.text, (self.x+16)*zoom, (self.y-4)*zoom, math.floor(self.w-32), self.align, 0, zoom, zoom)

            love.graphics.setColor(r,g,b,a)
        end

        function button:select(callback)
            callback = callback or function() end
            self.selected = true
            flux.to(self, self.anim.selected.time, self.anim.to):ease(self.anim.selected.ease)
            callback()
        end

        function button:deselect(callback)
            callback = callback or function() end
            self.selected = false
            flux.to(self, self.anim.deselected.time, {w=self.const.w,x=self.const.x,y=self.const.y}):ease(self.anim.deselected.ease)
            callback()
        end
        self.lt[name]=button
    end
    function obj:addValue(name, x, y, w, text, value, minValue, maxValue, valueColor, textColor, selValueColor, selTextColor, animationSelected, animationDeselected) 
        maxValue = maxValue or 100
        minValue = minValue or 0
        valueColor = valueColor or {r=1, g=1, b=1, a=1}
        selValueColor = selValueColor or valueColor
        selTextColor = selTextColor or {r=1,g=0.9882352941176471,b=0.2509803921568627,a=1}
        textColor = textColor or {r=1,g=1,b=1,a=1}
        animationSelected = animationSelected or {time=1, ease="elasticout"}
        animationDeselected = animationDeselected or {time=0.25, ease="quadout"}
        local to = {w=w,x=x}
        local value = {
            type="value",
            x=x+5,
            y=y,
            w=w-10,
            const={
                x=x+5,
                y=y,
                w=w-10
            },
            text=text,
            maxValue=maxValue,
            minValue=minValue,
            value=value,
            selected=false,
            colors={
                text=textColor, 
                value=valueColor, 
                selected={
                    text=selTextColor,
                    value=selValueColor
                }
            },
            anim = {
                selected=animationSelected,
                deselected=animationDeselected,
                to=to
            },
            activate=function() end,
            id=self.ltcount
        }
        self.ltcount=self.ltcount+1
        print(value.id)

        function value:draw(ui, zoom)
            local r,g,b,a = love.graphics.getColor()
            local colV = {}
            local colT = {}
            if self.selected then 
                colV = self.colors.selected.value
                colT = self.colors.selected.text
            else
                colV = self.colors.value
                colT = self.colors.text
            end
            love.graphics.setColor(colV.r, colV.g, colV.b, colV.a)
            love.graphics.printf(self.value, self.x*zoom, self.y*zoom, self.w, "right", 0, zoom, zoom)
            love.graphics.setColor(colT.r, colT.g, colT.b, colT.a)
            love.graphics.printf(self.text, self.x*zoom, self.y*zoom, self.w, "left", 0, zoom, zoom)

            love.graphics.setColor(r,g,b,a)
        end

        function value:select(callback)
            callback = callback or function() end
            self.selected = true
            flux.to(self, self.anim.selected.time, self.anim.to):ease(self.anim.selected.ease)
            callback()
        end

        function value:deselect(callback)
            callback = callback or function() end
            self.selected = false
            flux.to(self, self.anim.deselected.time, {w=self.const.w,x=self.const.x,y=self.const.y}):ease(self.anim.deselected.ease)
            callback()
        end
        self.lt[name]=value
    end
    function obj:draw(ui, zoom)
        for k, v in pairs(self.lt) do
            v:draw(ui, zoom)
        end
    end

    function obj:select(id)
        for k,v in pairs(self.lt) do
            if v.id == id then
                v:select()
            else
                v:deselect()
            end
        end
        self.selected=id
    end

    function obj:prev()
        self.selected=self.selected-1
        if self.selected < 0 then
            self.selected = self.ltcount-1
        end
        self:select(self.selected)
    end
    function obj:next()
        self.selected=self.selected+1
        if self.selected > self.ltcount-1 then
            self.selected = 0
        end
        self:select(self.selected)
    end

    function obj:activateSelected()
        for k,v in pairs(self.lt) do
            if v.id == self.selected then
                v:activate()
            end
        end
    end

    function obj:incrementSelected(step)
        for k,v in pairs(self.lt) do
            if v.id == self.selected and v.type == "value" then
                v.value=lume.clamp(v.value+step, v.minValue, v.maxValue)
            end
        end
    end
    return obj
end

return layout