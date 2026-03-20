owner = oPlayer;

empty = false;

spr = spPanel;
if(room == rGame)
{		
	x = display_get_gui_width() / 2
	y = display_get_gui_height() - (sprite_get_height(global.hand_sprite) / 2);
	spr_w = 1600;
	spr_h = 210;
}
else
{
	spr_w = 1050;
	spr_h = 210;
}


inc = 0;
interval = 10;
no_vowels = false;

target_letter = "";

if(array_equals(tile_holder_array, []))
{
	var _space_between_tiles = spr_w  / (size + 1);
	var _x_loc = x - (spr_w / 2);
	for(var i = 0; i < size; i++)
	{
		_x_loc += _space_between_tiles;	
		var _holder = instance_create_layer(_x_loc, y, "Hand_Tile_Holders", oTileHolder);
		var _array = tile_holder_array;
		array_push(_array, _holder);
		_holder.owner = self;
	}
}