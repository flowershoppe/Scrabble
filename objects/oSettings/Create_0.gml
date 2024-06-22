//handler for settings menu
visible = true;
view_height = camera_get_view_height(0);
view_width = camera_get_view_width(0);

resolution_items = ["Fullscreen", 
					"720 x 480", 
					"960 x 540",
					"1280 x 720",
					"1600 x 900", 
					"1920 x 1080"];

emitter_SE = global.emitterSE;
emitter_MS = global.emitterMS;

selected_item = "960 x 540";

menu = noone;

resolution_selector = new YuiArraySelector(resolution_items, resolution_items[2]);

keybinds = [input_binding_get("left"),
			input_binding_get("right"),
			(input_binding_get("up")),
			(input_binding_get("down")),
			(input_binding_get("confirm")),
			(input_binding_get("cancel")),
			(input_binding_get("special")),
			(input_binding_get("pause"))]

verbs = ["left", "right", "up", "down", "confirm", "cancel", "special", "pause"]

verb_to_set = "";