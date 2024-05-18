function valid_play()
{
	var _placed_tiles = oPlayer.placed_tiles;
	
	var _is_same_row = true;
	var _is_same_column = true;
	var _tile_adjacent = false;
	var _tile;
	var _prev_tile;
	
	if(array_length(_placed_tiles) > 1)
	{
		for(var _index = 1; _index < array_length(_placed_tiles); _index++)
		{
			_tile = _placed_tiles[_index];
			_prev_tile = _placed_tiles[_index - 1];
		
			//compare each placed tile's x coordinates
			if(_tile.x != _prev_tile.x)
			{
				_is_same_column = false;	
			}
			//compare each placed tile's y coordinates
			if(_tile.y != _prev_tile.y)
			{
				_is_same_row = false;	
			}
		}
	}
		
	for(var _index = 0; _index < array_length(_placed_tiles); _index++)
	{
		_tile = _placed_tiles[_index];
		var _tile_size = _tile.sprite_width;
		//check for at least 1 non-placed-this-turn tile adjacency		
		var _adjacent_tiles = 
			[instance_place(_tile.x + _tile_size, _tile.y, oTile),
			instance_place(_tile.x - _tile_size, _tile.y, oTile),
			instance_place(_tile.x, _tile.y + _tile_size, oTile),
			instance_place(_tile.x, _tile.y - _tile_size, oTile)]
		
		_index = 0;
		for(_index = 0; _index < array_length(_adjacent_tiles); _index++)
		{
			var _adj_tile = _adjacent_tiles[_index];
			if(_adj_tile != noone)
			{
				if(!array_contains(_placed_tiles, _adj_tile) and _adj_tile.layer == _tile.layer)	
				{
					_tile_adjacent = true;
				}
			}
		}
	}

	
	//------------------------------
	var _smallest_tile;
	var _largest_tile;
	var _hole_between;
	
	//same row
	#region
	if(_is_same_row)
	{
		var _find_smallest = function(_previous, _current, _index) 
		{
			if (_current.x < _previous.x)
			{
				return _current;
			}
			else
			{
				return _previous;
			}
		}
		_smallest_tile = array_reduce(_placed_tiles, _find_smallest);
		
		var _find_largest = function(_previous, _current, _index) 
		{
			if (_current.x > _previous.x)
			{
				return _current;
			}
			else
			{
				return _previous;
			}
		}
		_largest_tile = array_reduce(_placed_tiles, _find_largest);
		
		_hole_between = false;
		for(var _tile_pos = _smallest_tile.x; _tile_pos < _largest_tile.x; _tile_pos += _smallest_tile.sprite_width)
		{		
			if(!place_meeting(_tile_pos, _smallest_tile.y, oTile))
			{
				_hole_between = true;
			}		
		}
	}
	
	//if there is a hole between the two most extreme tiles, play is invalid
	
	#endregion
	
	//same column
	#region
	if(_is_same_column)
	{
		var _find_smallest = function(_previous, _current, _index) 
		{
			if (_current.y < _previous.y)
			{
				return _current;
			}
			else
			{
				return _previous;
			}
		}
		_smallest_tile = array_reduce(_placed_tiles, _find_smallest);
		
		var _find_largest = function(_previous, _current, _index) 
		{
			if (_current.y > _previous.y)
			{
				return _current;
			}
			else
			{
				return _previous;
			}
		}
		_largest_tile = array_reduce(_placed_tiles, _find_largest);
		
		_hole_between = false;
		for(var _tile_pos = _smallest_tile.y; _tile_pos < _largest_tile.y; _tile_pos += _smallest_tile.sprite_width)
		{		
			if(!place_meeting(_smallest_tile.x, _tile_pos, oTile))
			{
				_hole_between = true;
			}
		}
	}	
	#endregion	
	
	if((_is_same_column or _is_same_row) and 
		(_tile_adjacent == true or (global.turn == 1 and array_length(_placed_tiles) > 1)) and 
		_hole_between == false)
	{		
		debug = "play is valid";
		return true;	
	}
	else
	{
		debug = "play is invalid";	
	}


	
	
	/*
	1) compare each placed tile's x values
	if equal, return true
	else, compare y values
	if equal, return true
	else, return false
	
	2) if first turn, return true
	else
	for each tile, for each adjacent side, if non-played tile, return true
		if any placed tiles are adjacent to a non-played tile, return true
	
	3) take all placed tiles
	check = 0;
	if all row
		check = x
	else if all column	
		check = y
	find smallest check
	find largest check
	start at smallest's holder
	for(tile_count = smallest + tile.size; tile_count < tile_largest; tile_count += tile.size)
	(if tile_holder.tile == noone)
	{
		return false
	}
	return true
	
	if and only if all 3 return true, play is valid
	*/
}