/// @description Insert description here
// You can write your code in this editor
for(var i = 0; i < 4; i++){
	search_index = map_list_search(obj_menu_parent.weapon_inventory, loadout_ids[i]);
	loadout_level[i] = ds_map_find_value((obj_menu_parent.weapon_inventory[| search_index]), "level");
	loadout_exp[i] = ds_map_find_value((obj_menu_parent.weapon_inventory[| search_index]), "current_exp");
	temp_array = ds_map_find_value((obj_menu_parent.weapon_inventory[| search_index]), "ammo");
	if (real(loadout_level[i]) < 1){
		temp_string = temp_array[0];
	} else {
		temp_string = temp_array[loadout_level[i]-1];
	}
	temp_array = string_split(temp_string, "_");
	loadout_ammo[i] = temp_array[2];
}
