//Move camera
/*#region
//move camera based on directional keys pressed
var _horiz_camera_move_direction = input_check("right") - input_check("left");

x += _horiz_camera_move_direction * global.camera_speed;

var _vert_camera_move_direction = input_check("down") - input_check("up");

y += _vert_camera_move_direction * global.camera_speed;

#endregion*/
if(global.paused){exit;}
global.maincam = view_camera[0];
if(!active){dragging = false; exit;}

#region

var _viewX = camera_get_view_x(global.maincam);
var _viewY = camera_get_view_y(global.maincam);
var _viewW = camera_get_view_width(global.maincam);
var _viewH = camera_get_view_height(global.maincam);

var _view_horiz_left_limit = _viewW / 2;
var _view_horiz_right_limit = room_width - _viewW / 2;
var _view_vert_down_limit = room_height - _viewH / 2;
var _view_vert_up_limit = _viewH / 2;

//camera room limits
x = max(x, _view_horiz_left_limit);
x = min(x, _view_horiz_right_limit);
y = min(y, _view_vert_down_limit);
y = max(y, _view_vert_up_limit);

var _hor = input_check("right") - input_check("left");
var _ver = input_check("down") - input_check("up");

//smooth camera zooming
var _gotoX = x + (_hor * 200) - (_viewW * 0.5);
var _gotoY = y + (_ver * 150) - (_viewH * 0.5);
var _newX = lerp(_viewX, _gotoX, 0.1);
var _newY = lerp(_viewY, _gotoY, 0.1);
camera_set_view_pos(global.maincam, _newX, _newY);

var _factor = 0.1;
var _mouseW = input_check("zoom_out") - input_check("zoom_in")
if(_mouseW != 0)
{
	var z = 2;	
}
zoomF = clamp(zoomF + (_mouseW * _factor), _factor, 2);

var _lerpH = lerp(_viewH, zoomF * 1080, _factor);
var _newH = clamp(_lerpH, 0, room_height);var _newW = _newH * (960 / 540);
camera_set_view_size(global.maincam, _newW, _newH);

var _offsetX = _newX - (_newW - _viewW) * 0.5;
var _offsetY = _newY - (_newH - _viewH) * 0.5;
_newX = clamp(_offsetX, 0, room_width - _newW);
_newY = clamp(_offsetY, 0, room_height - _newH);
camera_set_view_pos(global.maincam, _newX, _newY);

#endregion

//drag camera
if(yui and input_mouse_check_pressed(mb_left) and !instance_exists(oDialogue) 
	and oCursor.layer != (layer_get_id("Hand")))
{
	dragging = true;
}
if(input_mouse_check_released(mb_left))
{
	yui = false;
	dragging = false;
}
with(oTile)
{
	if(hover)
	{
		oCamera.dragging = false;
		oCamera.yui = false;
	}
}

if(dragging and oCursor.held_tile == noone
	and (mouse_xguiprev != device_mouse_x_to_gui(0)
	or mouse_yguiprev != device_mouse_y_to_gui(0)))
{
	cam = {
	    x: camera_get_view_x(view_camera[0]),
	    y: camera_get_view_y(view_camera[0]),
	    w: camera_get_view_width(view_camera[0]),
	    h: camera_get_view_height(view_camera[0])
	};

	// Move camera object around

	if mouse_check_button(mb_left)
	{
	    x += mouse_xprevious - mouse_x;
	    y += mouse_yprevious - mouse_y;
	}

	// Center view on x and y position

	cam.x = x - cam.w / 2;
	cam.y = y - cam.h / 2;

	// Set the camera view

	camera_set_view_pos(view_camera[0], cam.x, cam.y);
}

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;

mouse_xguiprev = device_mouse_x_to_gui(0);
mouse_yguiprev = device_mouse_y_to_gui(0);