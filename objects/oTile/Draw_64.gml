font		= oGame.tile_font;
font_color	= oGame.tile_font_color;
var _old_halign = draw_get_halign();
var _old_valign = draw_get_valign();
var _old_font = draw_get_font();

if(wait_for_input)
{
	var t = scribble("[fa_center][fa_middle]Please enter a character.");
	t.starting_format(font_get_name(font), c_white)
	t.sdf_outline(c_black, 2);
	t.draw(display_get_gui_width() / 2, display_get_gui_height() / 3);
}

if(on_board){exit;}

//draw self
if(hover)
{
	image_xscale = 2.3;
	image_yscale = 2.3;
}
else
{
	image_xscale = 2;
	image_yscale = 2;
}
draw_self();

if(selected)
{
	draw_sprite_ext(spSelected, 0, x, y, xscale, yscale, 0, c_white, 1);
}

var _x_offset = 0//(sprite_width * xscale) * 0.15;
var _y_offset = 0//(sprite_height * yscale) * 0.15;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(font);

//draw letter
draw_text_transformed_color(x - _x_offset, y - _y_offset, letter, xscale * 2, yscale * 2, 
							image_angle, font_color, font_color, font_color, font_color, 100);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

_x_offset = (sprite_width * xscale) * 0.3;
_y_offset = (sprite_height * yscale) * 0.3;

//draw point value	
if(pointvalue > global.letters[? letter])
{
	font_color = c_green;
}
if(pointvalue < global.letters[? letter])
{
	font_color = c_red;
}

var _scale = (font_scale / 3) * image_xscale;
draw_text_transformed_color(
    x + lengthdir_x(cornerNumDist * 2, cornerNumDir + image_angle) * xscale,
    y + lengthdir_y(cornerNumDist * 2, cornerNumDir + image_angle) * yscale,
    pointvalue, _scale, _scale, image_angle, font_color, font_color, font_color, font_color, 100);

draw_set_halign(_old_halign);
draw_set_valign(_old_valign);
draw_set_font(_old_font);