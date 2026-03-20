if(layer == layer_get_id("Hand_Tile_Holders")){exit;}
image_xscale = 1;
image_yscale = 1;
draw_self();

//if tile is on board, draw its multiplier
if(owner == oBoard)
{
	var _subimg = 0;

	if(lmult == 2)
	{ _subimg = 1; }

	else if(lmult == 3)
	{ _subimg = 2; }

	else if(wmult == 2)
	{ _subimg = 3 }

	else if(wmult == 3)
	{ _subimg = 4; }
	
	else if(wmult == 4)
	{ _subimg = 5; }

	if(start_point)
	{ draw_sprite_ext(spStar, 0, x, y, 1, 1, rot, color, 1); }
	
	if(winspot)
	{ 
		draw_sprite_ext(spShine, 0, x, y, 1, 1, 0, 65384, alpha);
	}
	
	draw_sprite(mult_spr, _subimg, x, y);
	
}