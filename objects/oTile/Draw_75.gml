if(wait_for_input)
{
	draw_text(view_get_wport(0) / 2, view_get_hport(0) / 4, "Please enter a character");	
}


if(on_board){exit;}



draw_self();

if(selected)
{
	draw_sprite(spSelected, 0, x, y);
}

var _y_offset = sprite_height * 0.1;
var _x_offset = sprite_width * 0.05;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(font);

//draw letter
draw_text_transformed_color(x - _x_offset, y - _y_offset, letter, font_scale, font_scale, 
							0, font_color, font_color, font_color, font_color, 100);

var _scale = font_scale / 3;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

_x_offset = sprite_width * 0.3;
_y_offset = sprite_height * 0.3;

//draw point value	
draw_text_transformed_color(x + _x_offset, y - _y_offset, pointvalue, _scale, _scale, 
							0, font_color, font_color, font_color, font_color, 100);
							
