uniform float time;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec4 texturecolor = Texel(tex, fract(texture_coords-vec2(0, time/45)));
    return texturecolor * color;
}