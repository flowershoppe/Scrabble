tiles_played = 0;
words_spelled = 0;
total_score = 0;
largest_word = "";
largest_play = 0;
old_money = 0;
money_earned = 0;
levels_completed = 0;
levels = [];
stage_count = 3;
level_count = 3;
vowel_count = 0;
consonant_count = 0;

//prevents camera draggong while clicking on yui element
YuiCursorManager.global_left_pressed = start_camera_drag;

if(room == rGame or room == rMap)	
{
	switch(oRun.stage)	
	{
		case 1:
			global.music_map = msMap;
		break;
				
		case 2:
			global.music_map = msMap2;
		break;
				
		case 3:
			global.music_map = msMap3;
		break;
	}
	audio_stop_sound(global.music);
	global.music = global.music_map;
	audio_play_sound_on(oGame.emitter_MS, global.music_map, true, 1);
}

//LEVELS
levels1 = [1, 2, 3];
levels2 = [1, 2, 3, 4];
levels3 = [1, 2, 3, 4];