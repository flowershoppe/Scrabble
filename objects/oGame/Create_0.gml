randomize();
dialogue_setup();
cheat = false;
version = "v0.04";

global.paused = false;
//Instance
global.previous_room = -1;

//Dictionaries
global.dictionary = new CheckWordDictionary(working_directory + "dictionaries/full/full.txt");
global.dictionary_food = new CheckWordDictionary(working_directory + "dictionaries/food.txt");

//Letters and Default Values
global.letters = ds_map_create();
#region
ds_map_add(global.letters, "A", 1);
ds_map_add(global.letters, "B", 3);
ds_map_add(global.letters, "C", 3);
ds_map_add(global.letters, "D", 2);
ds_map_add(global.letters, "E", 1);
ds_map_add(global.letters, "F", 4);
ds_map_add(global.letters, "G", 2);
ds_map_add(global.letters, "H", 4);
ds_map_add(global.letters, "I", 1);
ds_map_add(global.letters, "J", 8);
ds_map_add(global.letters, "K", 5);
ds_map_add(global.letters, "L", 1);
ds_map_add(global.letters, "M", 3);
ds_map_add(global.letters, "N", 1);
ds_map_add(global.letters, "O", 1);
ds_map_add(global.letters, "P", 3);
ds_map_add(global.letters, "Q", 10);
ds_map_add(global.letters, "R", 1);
ds_map_add(global.letters, "S", 1);
ds_map_add(global.letters, "T", 1);
ds_map_add(global.letters, "U", 1);
ds_map_add(global.letters, "V", 4);
ds_map_add(global.letters, "W", 4);
ds_map_add(global.letters, "X", 8);
ds_map_add(global.letters, "Y", 4);
ds_map_add(global.letters, "Z", 10);
ds_map_add(global.letters, "_", 0);
#endregion

global.vowels = ["A", "E", "I", "O", "U"];
global.consonants = ["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"];

//Settings
global.camera_speed = 5.0;
global.zoom_factor = 0.1;
global.display_width = 1920;
global.display_height = 1080;
global.min_zoom = 540;
global.max_zoom = room_height;
global.maincam = view_camera[0];
global.board_sprite = spBoard;

//Sounds
global.place_sounds = [sdPlace1, sdPlace2, sdPlace3, sdPlace4, sdPlace5, sdPlace6];
global.emitterSE = audio_emitter_create();
global.emitterMS = audio_emitter_create();
global.emitterMain = audio_emitter_create();
global.music = 0;
global.volumeMain = 1;
global.volumeSE = 1;
global.volumeMS = 1;

audio_emitter_gain(global.emitterSE, global.volumeSE);
audio_emitter_gain(global.emitterMS, global.volumeMS);
audio_emitter_gain(global.emitterMain, global.volumeMain);

global.music_game = msGameMusic1;
global.music_map = msMap;
global.music_main_menu = msTitle;
global.music_victory = msVictory;

//Fonts
#region
fonts = [
	construct_font("Arial",	fnt_arial, fnt_arial_small, fnt_arial_tiny),
	
	construct_font("Book Antiqua", fnt_book_antiqua, fnt_book_antiqua_small, fnt_book_antiqua_tiny),
	
	construct_font("Comic Sans", fnt_comic_sans, fnt_comic_sans_small, fnt_comic_sans_tiny),
	
	construct_font("Impact", fnt_impact, fnt_impact_small, fnt_impact_tiny),
	
	construct_font("Oswald", fnt_oswald, fnt_oswald_small, fnt_oswald_tiny),
	
	construct_font("Pirata", fnt_pirata, fnt_pirata_small, fnt_pirata_tiny),
	
	construct_font("Segoe", fnt_segoe, fnt_segoe_small, fnt_segoe_tiny),
	
	construct_font("Wingdings", fnt_wingdings, fnt_wingdings_small, fnt_wingdings_tiny)
];
#endregion
tile_sprite = spLetterTile;
tile_font_color = c_black;

//default font
font = construct_font("Oswald", fnt_oswald, fnt_oswald_small, fnt_oswald_tiny);
tile_font_name = font.name;
tile_font = font.normal;
tile_font_small = font.small;
tile_font_tiny = font.tiny;

//Handlers
instance_create_layer(0, 0, "Meta", oSaverLoader);
instance_create_layer(0, 0, "Meta", oPauseMenu);
instance_create_layer(0, 0, "Meta", oSettings);
instance_create_layer(0, 0, "Meta", oResultsManager);
instance_create_layer(0, 0, "Meta", oStats);
instance_create_layer(0, 0, "Meta", oMatchManager);
load_stats();
instance_create_layer(room_width / 2, room_height / 2, "Meta", oCamera,
{active : false});

//GAMEPLAY
global.exchanging = false;
global.hand_sprite = spPlank;

//YUI Structs
#region
global.stMainMenu = 
{
	yui_file: "YUI screens/main_menu.yui",
	data_context: oMainMenu,
	is_full_screen: false,
	image_xscale: 8,
	image_yscale: 9,
	x: 704,
	y: 448
}
global.stPauseMenu =
{
	yui_file : "YUI screens/pause_menu.yui",
	data_context : oPauseMenu,
	layer : layer_get_id("Pause")
}
global.stMatchStats =
{
	data_context : oMatchManager,
	yui_file : "YUI screens/match_stats.yui",
	layer : layer_get_id("YUI")
}
global.stMatchButtons = 
{
	data_context : oMatchGUI,
	yui_file : "YUI screens/match_buttons.yui",
	layer : layer_get_id("YUI")
}
global.stCharms = 
{
	data_context : oCharmManager,
	yui_file : "YUI screens/charms.yui",
	is_full_screen : false,
	image_xscale : 5,
	image_yscale : 9,
	persistent : true,
	x : 0,
	y : 128,
	layer : layer_get_id("YUI")
}
global.stSettings =
{
	data_context : oSettings,
	yui_file : "YUI screens/settings.yui"
}
global.stResults = 
{
	data_context : oMatchManager,
	yui_file : "YUI screens/results.yui",
	is_full_screen : true	
}
global.stStats = 
{
	data_context : oStats,
	yui_file : "YUI screens/stats.yui",
	is_full_screen : true
}
#endregion

//Charms
global.charms = [
oBasket,
oBClef,
oBell,
oCassette,
oCheese,
oChip,
oClover,
oCount,
oD2,
oD20,
oD6,
oDiamond,
oDisguise,
oEraser,
oFridge,
oFractal,
oHammerSickle,
oHeadphones,
oIceCream,
oLoop,
oMoai,
oMetalDetector,
oNeedle,
oOcarina,
oPiggyBank,
oPuzzle,
oQuiver,
oRam,
oReceipt,
oRupee,
oScales,
oSeedling,
oSnake,
oSpade,
oStopwatch,
oTClef,
oTMap,
oWateringCan];

//Opponents
//multiple tiers
opponents_1 = [oCress1];
opponents_2 = [oCress2];
opponents_3 = [oCress3];

receiver = new Receiver();

emitter_SE = global.emitterSE;
emitter_MS = global.emitterMS;

load_settings();

with(oSettings)
{
	var _ind = 0;
	for(var i = 0; i < array_length(oGame.fonts); i++)
	{
		if(oGame.font.name == oGame.fonts[i].name)
		{
			_ind = i;
			break;
		}
	}
	font_selector = new YuiArraySelector(oGame.fonts, oGame.fonts[_ind]);
}