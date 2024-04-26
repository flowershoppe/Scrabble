if(place_meeting(x, y, owner.hand))
{ layer = layer_get_id("Hand_Tiles"); }
else
{ layer = layer_get_id("Tiles"); }


//follow the cursor
x = mouse_x;
y = mouse_y;

if(held_tile != noone)
{
	held_tile.x = x;
	held_tile.y = y;	
}

//Press left click
#region
if(mouse_check_button_pressed(mb_left))
{	
	held_tile = instance_place(x, y, obj_tile);
	
	if(held_tile == noone){ exit; }
	//grab a tile
	if(held_tile.layer == layer)
	{		
		//remove from placed tiles array if picking up from board
		if(held_tile.layer = layer_get_id("Tiles"))
		{array_delete(owner.placed_tiles, array_get_index(owner.placed_tiles, held_tile), 1);}
			
		//hold the tile
		held_tile.layer = layer_get_id("Grabbed");
		held_tile.image_xscale = 1;
		held_tile.image_yscale = 1;
		held_tile.font_scale = 1;
		
		//Blank tile subroutine
		if(held_tile.blank == true)
		{
			held_tile.letter = "_";		
		}
		
		audio_play_sound(global.place_sounds[irandom(array_length(global.place_sounds) - 1)],
						1, 0, 0.8, 0, 1.5);
		
		var _tile = held_tile;
		var _holder;
		//find tile holder holding the tile and remove it
		with(obj_tile_holder)
		{
			if(tile == _tile)
			{
				tile = noone;
			}
		}
	}	
}
#endregion

//Release left click
#region
if(mouse_check_button_released(mb_left))
{
	if(held_tile == noone){ exit; }
	
	//if holding a tile
	if(held_tile != noone)
	{	
		var _nearest_holder = noone;
		var _nearest_dist = infinity;
	
		//find nearest tile holder of the same layer that isn't holding a tile		
		#region
		if(layer == layer_get_id("Hand_Tiles"))
		{
			with(obj_tile_holder)
			{
				if(tile == noone and layer == layer_get_id("Hand_Tile_Holders"))
				{
					var _dist = point_distance(x, y, other.x, other.y)
					if(_dist < _nearest_dist)
					{
						//save the id
						_nearest_holder = id;
						_nearest_dist = _dist;
					}
				}
			}
		}
		
		else
		{			
			with(obj_tile_holder)
			{
				if(tile == noone and layer == layer_get_id("Board_Tile_Holders"))
				{
					var _dist = point_distance(x, y, other.x, other.y)
					if(_dist < _nearest_dist)
					{
						//save the id
						_nearest_holder = id;
						_nearest_dist = _dist;
					}
				}
			}	
		}
		#endregion
			
		//drop the tile
		held_tile.x = _nearest_holder.x;
		held_tile.y = _nearest_holder.y;
		
		held_tile.layer = layer;
		
		if(layer == layer_get_id("Tiles"))
		{
			//place in array for checking play validity later
			array_insert(owner.placed_tiles, 0, held_tile);

			//Blank tile subroutine
			if(held_tile.blank == true)
			{
				held_tile.wait_for_input = true;	
			}
			
			valid_play(owner);
		}
		
		_nearest_holder.tile = held_tile;
		audio_play_sound(global.place_sounds[irandom(array_length(global.place_sounds) - 1)],
						1, 0, 0.8, 0, 1);
		
		
		held_tile = noone;
	}
}
#endregion