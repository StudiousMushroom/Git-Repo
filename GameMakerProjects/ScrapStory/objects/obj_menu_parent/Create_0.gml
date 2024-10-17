/// @description Insert description here
// You can write your code in this editor

//weapon ids to replace hardcoded values//
#macro NOWEAPON 0 
#macro SLINGSHOT 1
#macro JUNKREVOLVER 2
#macro TENNISBALLTOSSER 3

//////////////////////////////////////////

//item ids to replace hardcoded values//




////////////////////////////////////////


//information for how/what is displayed in the three menus//
array_pos_name = "menu_switch"; //name of the array that 
menu_pos_name = "obj_inventory_menu";
array_pos = 0;

//array for menu switching
menu_switch = ["obj_inventory_menu","obj_crafting_menu","obj_encyclopedia_menu"];
//previous_menu_switch_pos = 0;

//array for loadout
menu_loadout = [0,1,2,3]; //current weapons in loadout
//previous_menu_loadout_pos = 0;

//array for scrap
inventory_scrap = [0,0,0,0];
//previous_inventory_scrap_pos = 0;
last_in_scrap = true;

//array for weapons
inventory_weapons = [0,1,0,0];
//previous_inventory_weapons_pos = 0;
last_in_weapons = false;


displayed_scrap_horizontal = 4; //how many columns to desplay of scrap fake matrix
displayed_scrap_vertical = 4; //how many rows to desplay of scrap fake matrix
displayed_weapon_horizontal = 1;//how many columns to desplay of scrap fake matrix
displayed_weapon_vertical = 4;//how many rows to desplay of scrap fake matrix

//info for icon_select
icon_select_x = 0;
icon_select_y = 0;
////////////////////////////////////////////////////////////////////////////////


menu_is_open = false;
submenu_is_open = false;

item_inventory = ds_list_create(); //contains info on items in your characters possession
weapon_inventory = ds_list_create(); //contains info on weapons in your characters possession
encyclopedia_inventory = ds_list_create(); //contains info on discovered weapons, and whether they have been crafted

//weapon fire type: spam, charge, auto, tbd
//max ammo: -1 for infinite
//starting ammo:
//ammo recharge rate:
//delay before firing:
//delay after firing:
//number of projectiles allowed on the screen

temp_map = ds_map_create();
ds_map_add(temp_map, "id",NOWEAPON);
ds_map_add(temp_map, "name", "");
ds_map_add(temp_map, "description", "");
ds_map_add(temp_map, "current_exp", 0);
ds_map_add(temp_map, "level", 0);
ds_map_add(temp_map, "max_exp", [0,0,0]);
//ammo should have 7 modifiers
ds_map_add(temp_map, "ammo", ["spam_0_0_0_0_0_0)", "spam_0_0_0_0_0_0", "spam_0_0_0_0_0_0"]);
ds_list_add(weapon_inventory, temp_map);

//example map, for slingshot
temp_map = ds_map_create();
ds_map_add(temp_map, "id",SLINGSHOT);
ds_map_add(temp_map, "name", "Slingshot");
ds_map_add(temp_map, "description", "Garden pottery's number one enemy");
ds_map_add(temp_map, "current_exp", 0);
ds_map_add(temp_map, "level", 1);
ds_map_add(temp_map, "max_exp", [25,50,75]);
ds_map_add(temp_map, "ammo", ["charge_1_0_0.7_0_0_20", "charge_4_0_0.7_0_0_20", "charge_1_0_0.7_0_0_100"]);
ds_list_add(weapon_inventory, temp_map);


//example map, for junk_revolver
temp_map = ds_map_create();
ds_map_add(temp_map, "id",JUNKREVOLVER);
ds_map_add(temp_map, "name", "Junk Revolver");
ds_map_add(temp_map, "description", "you can practically see a tumbleweed off in the distance");
ds_map_add(temp_map, "current_exp", 100);
ds_map_add(temp_map, "level", 3);
ds_map_add(temp_map, "max_exp", [50,100,150]);
ds_map_add(temp_map, "ammo", ["spam_-1_-1_0_0.1_0.4_20", "spam_6_6_0.15_0_0_20", "charge_6_0_0.25_0_0_6"]);
ds_list_add(weapon_inventory, temp_map);


//example map, for T-Ball_Tosser
temp_map = ds_map_create();
ds_map_add(temp_map, "id",TENNISBALLTOSSER);
ds_map_add(temp_map, "name", "T-Ball Tosser");
ds_map_add(temp_map, "description", "A sport's practice tool turned into a deadly weapon");
ds_map_add(temp_map, "current_exp", 0);
ds_map_add(temp_map, "level", 1);
ds_map_add(temp_map, "max_exp", [100,200,250]);
ds_map_add(temp_map, "ammo", ["auto_20_20_0.05_0_0.1_20", "spam_3_3_-2_0_0.5_3", "spam_1_1_-2_0_0_1"]);
ds_list_add(weapon_inventory, temp_map);


//look up table for weapons
weapon_lookup = [spr_no_weapon_icon, spr_slingshot_icon, spr_junk_revolver_icon, spr_tbt_icon];
//look up table for scrap
scrap_lookup = [spr_no_scrap_icon];