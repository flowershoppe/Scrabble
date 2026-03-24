function set_tile_font(_struct)
{
	var o = oGame;
	o.tile_font_name = _struct.name;
	o.tile_font = _struct.normal;
	o.tile_font_small = _struct.small;
	o.tile_font_tiny = _struct.tiny;
	o.font = _struct;
	
	save_settings();
}