/// @description Insert description here
// You can write your code in this editor

//will contain varaibles for storing current loadout information that changes
loadout_ids = [0,1,2,3]; //an array with the ids of weapons in loadout
loadout_ammo = [0,0,0,0]; //the ammo count for each weapon in loadout
loadout_proj = [0,0,0,0]; //# of each proj objects
loadout_exp = [0,0,0,0]; //current exp for each weapon in loadout
loadout_level = [0,0,0,0];
current_weapon_level = "0";
max_exp = [0,0,0];
current_weapon = 0; //an int from 0 to 3 decending on which weapon is selected
menu_displayed = false;
x_pos = 22;
y_pos = 13;
sprite_to_draw_0 = spr_no_weapon_icon;
sprite_to_draw_1 = spr_no_weapon_icon;
sprite_to_draw_2 = spr_no_weapon_icon;
sprite_to_draw_3 = spr_no_weapon_icon;
search_index = 0;
temp_array = [];
temp_string = "";
change_weapon = false;