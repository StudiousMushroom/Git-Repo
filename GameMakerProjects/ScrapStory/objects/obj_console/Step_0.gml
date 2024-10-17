/// @description Insert description here
// You can write your code in this editor
if(self.visible && keyboard_check_pressed(vk_anykey) && !keyboard_check(192)){
	if(keyboard_check(vk_backspace)){
		console_string = string_copy(console_string,1,string_length(console_string)-1);
	}else{
		console_string += keyboard_lastchar;
	}
}
if(keyboard_check_pressed(vk_enter)){
	ammo_info = obtain_current_ammo_info();
	
	//check entered string
	string_check = string_split(console_string, " ");
	if(string_check[0] == "makecurrentid"){
		result = " (success)";
	}else if (string_check[0] == "makecurrentexp"){
		result = " (success)";
	}else if (string_check[0] == "makecurrentlevel"){
		if(string_check[1] > 1 && string_check[1] < 4){
			var current_weapon_id = obj_loadout.loadout_ids[obj_loadout.current_weapon];
			var search_index = map_list_search(obj_menu_parent.weapon_inventory, current_weapon_id);
			var found_exp = map_list_info(obj_menu_parent.weapon_inventory, search_index,"max_exp")
			if(found_exp != -1){
				set_loadout_exp(obj_loadout.current_weapon, found_exp[string_check[1]-2]);
			}
			
		} else{
			set_loadout_exp(obj_loadout.current_weapon, 0);
		}
		obj_loadout.current_weapon_level = string_check[1];
		ammo_info = obtain_current_ammo_info();
		set_loadout_ammo(obj_loadout.current_weapon, real(ammo_info[2]));
		result = " (success)";
	}else{
		result = " (fail)";
	}

	//move entered string
	for(var i = 0; i < array_length(prev_string)-1; i++){
		prev_string[i] = prev_string[i+1];
	}
	prev_string[array_length(prev_string)-1] = console_string;
	console_string = "";
}