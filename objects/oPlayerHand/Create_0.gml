owner = oPlayer;

empty = true;

spr = spPlank;
spr_w = sprite_get_width(spPlank);
spr_h = sprite_get_height(spPlank);

//create tile array
tile_holder_array = [];

var _space_between_tiles = sprite_width  / (size + 1);
var _x_loc = x - (sprite_width / 2);
for(var i = 0; i < size; i++)
{
	_x_loc += _space_between_tiles;	
	var _holder = instance_create_depth(_x_loc, y, -8, oTileHolder);
	var _array = tile_holder_array;
	array_push(_array, _holder);
	_holder.owner = self;	
}