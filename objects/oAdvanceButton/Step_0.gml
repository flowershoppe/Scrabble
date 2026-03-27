if(global.paused){image_speed = 0; exit;}
else{image_speed = 1;}
if(mouse_check_button_pressed(mb_left) or input_check_pressed("confirm"))
{
	//advance dialogue
	with(oDialogue)
	{
		event_user(0);
	}
}

if(!instance_exists(oDialogue)){instance_destroy(self);}

x = 1750;
y = 1000;