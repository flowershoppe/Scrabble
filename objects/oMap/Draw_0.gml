var _scale = 1920 / 1920;

draw_sprite_ext(spr, 0, 0, 0, _scale, _scale, 0, c_white, 1);

var _alpha = sin_oscillate(0, .1, 6)

draw_sprite_solid_color(spr, 0, 0, 0, _scale, _scale, 0, c, _alpha);

