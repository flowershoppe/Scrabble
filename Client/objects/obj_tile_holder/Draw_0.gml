draw_self();

//if tile is on board, draw its multiplier
if(owner == obj_board)
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

	draw_sprite(mult_spr, _subimg, x, y);
}