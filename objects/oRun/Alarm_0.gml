//new run
instance_destroy(oTilebag);
instance_destroy(oPlayerHand);
instance_destroy(oTile);
instance_destroy(oTileHolder);
instance_create_layer(0, 0, "Meta", oDialogueManager);
instance_create_layer(250, 800, "Tilebag", oTilebag);
dist_standard(oTilebag);
	
//initialize handlers
instance_create_layer(0, 0, "Meta", oCharmManager);

//give random charm
var _num = irandom_range(1, array_length(global.charms) - 1)
var _charm = global.charms[_num];
add_charm(_charm);

//generate shop
instance_destroy(oShop);
instance_create_layer(0, 0, "Meta", oShop);

create_levels(level_count, oLevel1);
	
save_game();