//NO VOWELS
if(turn == 1 and room == rGame and no_vowels_flag)
{
	with(oTile)
	{	
		if(visible)
		{
			if(!array_contains(global.vowels, letter) and letter != "Y" and letter != "_")
			{
				oMatchManager.no_vowels = true;
			}
			else
			{
				oMatchManager.no_vowels = false;
				break;
			}
		}
	}
}
else
{
	no_vowels = false;	
}

if(input_check_pressed("confirm") and active)
{
	submit_play();
}

if(yui_points < total_points)
{
	yui_points++;	
}
else if(yui_points > total_points)
{
	yui_points--;
}

if(yui_last_play != last_play)
{
	yui_last_play++;	
}

if(!active){exit;}
if(array_length(oPlayer.placed_tiles) < 1)
{
	with(oTile)
	{
		is_word = false;
		if(highlighter != noone)
		{
			instance_destroy(highlighter);
			highlighter = noone;
		}
	}
	exit;
}
if(!valid_play())
{
	with(oTile)
	{
		is_word = false;
		if(highlighter != noone)
		{
			instance_destroy(highlighter);
			highlighter = noone;
		}
	}
	exit;
}
//DICTIONARY CHECK
var _player = oPlayer;
var _word = "";
var _player_words_tiles = []
var _player_tiles = _player.placed_tiles;
var _tile = _player.placed_tiles[0];
var _spr_size = _tile.spr_size;
var _next_tile;
var _array_tiles = [];
var i = 0;
var k = 0;
var _val = 0;
var _array_in_array = false;
	
//run code on each tile in placed_tiles
for(i = 0; i < array_length(_player_tiles); i++)
{		
	//reset tile and array
	_tile = _player_tiles[i];
	_array_tiles = [];
		
	//HORIZONTAL
	#region
	//LEFT
	while(_tile != noone)
	{
		//do not check for spelled words if previous tile is on the same horizontal axis
		if(i > 0)
		{	
			if(_tile.y == _player_tiles[i - 1].y)
			{
				break;
			}
		}
		//insert tile id into temp array
		array_insert(_array_tiles, 0, _tile);
			
		//set tile to next tile to left
		with(_tile)
		{
			var _list = ds_list_create();
			var _num = instance_position_list(_tile.x - _spr_size, _tile.y, oTile, _list, true);
			for(var _i = 0; _i < _num; _i++)
			{
				if(_list[| _i].on_board)
				{
					_next_tile = _list[| _i];
					break;
				}
				else
				{
					_next_tile = noone;
				}
			}
			if(_num < 1){_next_tile = noone;}
			if(_next_tile != noone)
			{
				if(!_next_tile.on_board){ _next_tile = noone; }
			}
			ds_list_destroy(_list);
		}
		if(_tile == _next_tile){_tile = noone; break;}
		_tile = _next_tile;
	}
		
	//reset tile
	_tile = _player_tiles[i];
		
	//RIGHT
	while(_tile != noone)
	{
		//do not check for spelled words if previous tile is on the same horizontal axis
		if(i > 0)
		{	
			if(_tile.y == _player_tiles[i - 1].y)
			{
				break;
			}
		}
		//set tile to next tile to right
		with(_tile)
		{
			var _list = ds_list_create();
			var _num = instance_position_list(_tile.x + _spr_size, _tile.y, oTile, _list, true);
			for(var _i = 0; _i < _num; _i++)
			{
				if(_list[| _i].on_board)
				{
					_next_tile = _list[| _i];
					break;
				}
				else
				{
					_next_tile = noone;
				}
			}
			if(_num < 1){_next_tile = noone;}
			if(_next_tile != noone)
			{
				if(!_next_tile.on_board){ _next_tile = noone; }
			}
		}
		if(_tile == _next_tile){_tile = noone; break;}
		_tile = _next_tile;
			
		if(_tile != noone)
		{
			//insert tile id into temp array
			array_push(_array_tiles, _tile);
		}
	}
		
	_array_in_array = false;
	for(var a = 0; a < array_length(_player_words_tiles); a++)
	{
		if(_array_in_array == false)
		{
			_array_in_array = array_equals(_player_words_tiles[a], _array_tiles);
		}
	}
	//add tile id array to array if it hasn't appeared there yet
	if(_array_in_array == false and array_length(_array_tiles) > 1)
	{
		_player_words_tiles[k] = _array_tiles;
		k++;
			
	}
	#endregion
		
	//reset tile and array
	_tile = _player_tiles[i];
	_array_tiles = [];
		
	//VERTICAL
	#region
	//UP
	while(_tile != noone)
	{
		//do not check for spelled words if previous tile is on the same veritcal axis
		if(i > 0)
		{	
			if(_tile.x == _player_tiles[i - 1].x)
			{
				break;
			}
		}
		//insert tile id into temp array
		array_insert(_array_tiles, 0, _tile);
			
		//set tile to next tile up
		with(_tile)
		{
			var _list = ds_list_create();
			var _num = instance_position_list(_tile.x, _tile.y - _spr_size, oTile, _list, true);
			for(var _i = 0; _i < _num; _i++)
			{
				if(_list[| _i].on_board)
				{
					_next_tile = _list[| _i];
					break;
				}
				else
				{
					_next_tile = noone;
				}
			}
			
			if(_num < 1){_next_tile = noone;}
			if(_next_tile != noone)
			{
				if(!_next_tile.on_board){ _next_tile = noone; }
			}
		}
		if(_tile == _next_tile){_tile = noone; break;}
		_tile = _next_tile;
		
	}
		
	//reset tile
	_tile = _player_tiles[i];
		
	//DOWN
	while(_tile != noone)
	{
		//do not check for spelled words if previous tile is on the same veritcal axis
		if(i > 0)
		{	
			if(_tile.x == _player_tiles[i - 1].x)
			{
				break;
			}
		}
		//set tile to next tile down
		with(_tile)
		{				
			var _list = ds_list_create();
			var _num = instance_position_list(_tile.x, _tile.y + _spr_size, oTile, _list, true);
			for(var _i = 0; _i < _num; _i++)
			{
				if(_list[| _i].on_board)
				{
					_next_tile = _list[| _i];
					break;
				}
				else
				{
					_next_tile = noone;
				}
			}
			if(_num < 1){_next_tile = noone;}
			if(_next_tile != noone)
			{
				if(!_next_tile.on_board){ _next_tile = noone; }
			}
		}
		if(_tile == _next_tile){_tile = noone; break;}
		_tile = _next_tile;
			
		if(_tile != noone)
		{
			//insert tile id into temp array
			array_push(_array_tiles, _tile);
		}
	}
		
	_array_in_array = false;
	a = 0;
	for(a = 0; a < array_length(_player_words_tiles); a++)
	{
		if(!_array_in_array)
		{
			_array_in_array = array_equals(_player_words_tiles[a], _array_tiles);
		}
	}
	//add tile id array to array if it hasn't appeared there yet
	if(!_array_in_array and array_length(_array_tiles) > 1)
	{
		_player_words_tiles[k] = _array_tiles;
		k++;
			
	}
	#endregion
	
}

//-----CHECK DICTIONARY-----
var _word_tiles = [];
for(var _index = 0; _index < array_length(_player_words_tiles); _index++)
{
	_word = "";
	//clear tiles outside of words
	with(oTile)
	{
		if(!array_contains(_player_words_tiles[_index], id))
		{
			is_word = false;	
		}
	}
	for(var _array_index = 0; _array_index < array_length(_player_words_tiles[_index]); _array_index++)
	{
		var _tile = _player_words_tiles[_index][_array_index];
		var _letter = _player_words_tiles[_index][_array_index].letter;
		_word = string_concat(_word, _letter);
		array_push(_word_tiles, _tile); 
	}
	//if any attemtps aren't words, play is invalid
	if((!global.dictionary.check(_word) and !oGame.cheat) or string_length(_word) < 2)
	{
		with(oTile){is_word = false;}
		exit;
	}
	else
	{
		for(var i = 0; i < array_length(_word_tiles); i++)
		{
			_word_tiles[i].is_word = true;	
		}
	}
}
	