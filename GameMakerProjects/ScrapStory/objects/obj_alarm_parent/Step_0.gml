/// @description Insert description here
// You can write your code in this editor

temp_array = obtain_current_ammo_info();
weapon_type = temp_array[0];
max_ammo = temp_array[1];
current_ammo = get_loadout_ammo(obj_loadout.current_weapon);
ammo_recharge = temp_array[3];
after_delay = temp_array[5];
current_proj_count = get_loadout_proj(obj_loadout.loadout_ids[obj_loadout.current_weapon]);
current_id = obj_loadout.loadout_ids[obj_loadout.current_weapon];
current_level = obj_loadout.loadout_level[obj_loadout.current_weapon];



//transfer ammo recharge code to a seperate function that way it can be called for the 4 recharge alarms


//ammo recharge
if(weapon_type == "spam" || weapon_type == "auto"){
	if (max_ammo != "-1"){ //if max ammo is finite
		if(current_ammo < real(max_ammo)){//if less then max ammo
			if(alarm[RECHARGE_AMMO_ALARM] == -2){ //if the recharge alarm is inactive
				alarm[RECHARGE_AMMO_ALARM] = real(ammo_recharge) * game_get_speed(gamespeed_fps); //set an alarm
			} else if (alarm[RECHARGE_AMMO_ALARM] == -1){
				current_ammo += 1;
				set_loadout_ammo(obj_loadout.current_weapon, current_ammo);
				//reset alarm
				alarm[RECHARGE_AMMO_ALARM] = real(ammo_recharge) * game_get_speed(gamespeed_fps);
			}
		}else {
			alarm[RECHARGE_AMMO_ALARM] = -2;
		}
	}
} else if (weapon_type == "charge"){
	if(alarm[RECHARGE_AMMO_ALARM] == -1){
		if(typeof(current_ammo) == "string"){
			show_debug_message("current ammo should never be a string");
			show_debug_message("please double check code");
			current_ammo = real(current_ammo);
		}
		
		current_ammo += 1
		//for junk revolver lv3
		if(current_id == JUNKREVOLVER && current_level == 3){
			//find a target
			target_id = jr_targeting(current_ammo);
			if (target_id != noone){
				//mark the target
				add_target(target_id);
				target_id.target_count++;
			}else{ //no enemies in view
				current_ammo = 0;
			}
		}
		set_loadout_ammo(obj_loadout.current_weapon, current_ammo);
		if(current_ammo == real(max_ammo)){
			alarm[RECHARGE_AMMO_ALARM] = -2;
		} else{
			//for slingshot_lv2
			if(current_id == SLINGSHOT && current_level == 2){
				alarm[RECHARGE_AMMO_ALARM] = (real(ammo_recharge) + power(2, current_ammo) * 0.3) * game_get_speed(gamespeed_fps);
			}
			//for anything else
			else {
				alarm[RECHARGE_AMMO_ALARM] = real(ammo_recharge) * game_get_speed(gamespeed_fps);
			}
		}
	}
}

if(alarm[BEFORE_DELAY_ALARM] == -1){ //if before_delay alarm has elapsed
	alarm[BEFORE_DELAY_ALARM] = -2; //make alarm inactive
	if (max_ammo != "-1"){
		set_loadout_ammo(obj_loadout.current_weapon, current_ammo - 1);
	}
	alarm[RECHARGE_AMMO_ALARM] = real(ammo_recharge) * game_get_speed(gamespeed_fps);
	fire(up_x_offset, up_y_offset, bullet_up, down_x_offset, down_y_offset, bullet_down, base_x_offset, base_y_offset, bullet_base);
	if (real(after_delay) > 0){
		alarm[AFTER_DELAY_ALARM] = real(after_delay) * game_get_speed(gamespeed_fps); //set an alarm
	}
}
