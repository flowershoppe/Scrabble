if(!on_board){is_word = false; exit;}
//draw self
if(hover)
{
	image_xscale = 1.15;
	image_yscale = 1.15;
}
else
{
	image_xscale = 1;
	image_yscale = 1;
}
draw_self();

var _x_offset = 0//(sprite_width * xscale) * 0.05;
var _y_offset = 0//(sprite_height * yscale) * 0.1;

var _old_halign = draw_get_halign();
var _old_valign = draw_get_valign();
var _old_font = draw_get_font();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(font);

//draw letter
draw_text_transformed_color(x - _x_offset, y - _y_offset, letter, xscale, yscale, 
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
    x + lengthdir_x(cornerNumDist, cornerNumDir + image_angle) * xscale,
    y + lengthdir_y(cornerNumDist, cornerNumDir + image_angle) * yscale,
    pointvalue, _scale, _scale, image_angle, font_color, font_color, font_color, font_color, 100);

//highlight
if(highlight)
{
	draw_sprite(spHighlight, 0, x, y);	
}

draw_set_halign(_old_halign);
draw_set_valign(_old_valign);
draw_set_font(_old_font);