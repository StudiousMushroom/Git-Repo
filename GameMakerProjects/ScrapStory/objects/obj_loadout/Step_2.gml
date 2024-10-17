/// @description Insert description here
// You can write your code in this editor

//for determining which weapon is selected
if(object_exists(obj_player_parent)){
	if (is_console_open() == false && is_menu_open() == false){
		if (keyboard_check(ord("A"))){
			if (!keyboard_check(ord("S")) && !keyboard_check(ord("D")) && !keyboard_check(ord("F"))){
				change_weapon = true;
				current_weapon = 0;
				x_pos = 22;
				y_pos = 13;
			}
		}
		if (keyboard_check(ord("S"))){
			if (!keyboard_check(ord("A")) && !keyboard_check(ord("D")) && !keyboard_check(ord("F"))){
				change_weapon = true;
				current_weapon = 1;
				x_pos = 41;
				y_pos = 13;
			}
		}
		if (keyboard_check(ord("D"))){
			if (!keyboard_check(ord("S")) && !keyboard_check(ord("A")) && !keyboard_check(ord("F"))){
				change_weapon = true;
				current_weapon = 2;
				x_pos = 60;
				y_pos = 13;
			}
		}
		if (keyboard_check(ord("F"))){
			if (!keyboard_check(ord("S")) && !keyboard_check(ord("D")) && !keyboard_check(ord("A"))){
				change_weapon = true;
				current_weapon = 3;
				x_pos = 79;
				y_pos = 13;
			}
		}
	}
	
	if(change_weapon == true){
		change_weapon = false;
		//change so that when switching weapons swap default to backup alarm
		obj_alarm_parent.alarm[RECHARGE_AMMO_ALARM] = -2;
		
		
		//
		obj_alarm_parent.alarm[BEFORE_DELAY_ALARM] = -2; //deactivate alarm
		obj_alarm_parent.alarm[AFTER_DELAY_ALARM] = -2; //deactivate alarm
	}
	
}


//for determining equipped weapon sprites
sprite_to_draw_0 = obj_menu_parent.weapon_lookup[loadout_ids[0]];
sprite_to_draw_1 = obj_menu_parent.weapon_lookup[loadout_ids[1]];
sprite_to_draw_2 = obj_menu_parent.weapon_lookup[loadout_ids[2]];
sprite_to_draw_3 = obj_menu_parent.weapon_lookup[loadout_ids[3]];

//for determining what level should be shown in exp bar
search_index = map_list_search(obj_menu_parent.weapon_inventory, loadout_ids[current_weapon]);
max_exp = ds_map_find_value((obj_menu_parent.weapon_inventory[| search_index]), "max_exp");
if (max_exp[0] == 0){
	current_weapon_level = "0";
} else if(loadout_exp[current_weapon] < max_exp[0]){
	current_weapon_level = "1"
} else if(loadout_exp[current_weapon] < max_exp[1]){
	current_weapon_level = "2"
 }else {
	current_weapon_level = "3"
}
loadout_level[current_weapon] = real(current_weapon_level);

//check for targeting
if(loadout_ids[current_weapon] != 2 || loadout_level[current_weapon] != 3){
	for (var i = 0; i < ds_list_size(obj_arms.target_list); i++){
		var temp_enemy = ds_list_find_value(obj_arms.target_list, i);
		temp_enemy.target_count = 0;
	}
	ds_list_clear(obj_arms.target_list);
}


//show_debug_message(loadout_proj);
