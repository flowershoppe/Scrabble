var _x = display_get_gui_width() / 2;
var _y = display_get_gui_height() / 3;
if(typist != 0)
{	
	if(oRun.stage >= oRun.stage_count and oRun.current_level == oRun.levels[array_length(oRun.levels) - 1])
	{
		var t = scribble("[rainbow][fnt_reality_hyper_big][fa_center]Sequence Complete");
		t.draw(_x, _y, typist);
		t.sdf_outline(c_black, 2);		
	}
	else if(oMatchManager.loss)
	{
		var t = scribble("[cycle, 250, 250, 250, 230][fnt_reality_hyper_big][fa_center]Sequence Failed");
		scribble_anim_cycle(0.5, 255, 255);
		t.draw(_x, _y, typist);
		t.sdf_outline(c_black, 2);
	}
	else
	{
		var t = scribble("[cycle, 140, 140, 140, 130][fnt_reality_hyper_big][fa_center]Memory Processed");
		scribble_anim_cycle(0.5, 255, 255);
		t.draw(_x, _y, typist);
		t.sdf_outline(c_black, 2);
		//val = sin_oscillate(160, 255, 2);
	}
}