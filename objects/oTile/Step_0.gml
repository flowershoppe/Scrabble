if(global.paused){exit;}
layer_name = layer_get_name(layer);
if(!on_board)
{
	is_word = false;
	if(instance_exists(highlighter))
	{		
		instance_destroy(highlighter);	
		highlighter = noone;
	}
}
if(is_word)
{
	if(highlighter == noone)
	{
		highlighter = instance_create_depth(x, y, layer_get_depth(layer) + 1, oShine,
		{
			color : c_green,
			image_xscale : 1.2,
			image_yscale : 1.2,
			fade : false
		});
	}
}
else
{
	if(instance_exists(highlighter))
	{		
		instance_destroy(highlighter);	
		highlighter = noone;
	}
}

var _tile = id;
if(instance_exists(oPlayerHand) and oMatchManager.active)
{
	with(oTileHolder)
	{
		if(tile == _tile)
		{		
			tile.holder = id;
			if(array_contains(oPlayerHand.tile_holder_array, id))
			{
				tile.in_hand = true;
			}
		}	
	}
}
if(oCursor.held_tile == noone and oCamera.dragging == false)
{
	var _intersect = false;
	
	if(on_board and place_meeting(x, y, oCursor))
	{
		_intersect = true;
	}
	else if(!on_board and position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id))
	{
		_intersect = true;
	}
	
	if(grabbable and _intersect)
	{
		xscale = 1.15;
		yscale = 1.15;
		hover = true;
	}

	else
	{
		//GUI layering
		if(instance_exists(oPlayerHand) and in_hand)
		{
			//depth = layer_get_depth("Hand_Tiles") + (x / 10);
		}
		else
		{
			//layer = true_layer;	
		}
		xscale = 1;
		yscale = 1;
		hover = false;
	}
}
else
{
	xscale = 1;
	yscale = 1;
	hover = false;	
}

//exchanging
if(position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)
	and input_mouse_check_pressed(mb_left) and global.exchanging
		and in_hand)
{
	selected = !selected;
}

//blank
if(!on_board and blank == true)
{
	letter = "_";
	wait_for_input = false;
}

if(room != rGame)
{
	letter = old_letter;	
}

if(wiggleAmplitude > 0) 
{
    wiggleTime++;
    image_angle = sin(wiggleTime * 2 * pi / wigglePeriod) * wiggleAmplitude;
    wiggleAmplitude = max(wiggleAmplitude - wiggleFalloff, 0);
}
else 
{
    image_angle = 0;
}
	