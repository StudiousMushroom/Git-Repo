// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//go_left = vk_left;
//go_right = vk_right;
//go_up = vk_up;
//go_down = vk_down;
//open_console = 192; //the tilde key
//open_menu = ord("C");
//esc = vk_escape;
//jump_ok = ord("Z");
//fire_back = ord("X");
//equip_weapon_1 = ord("A");
//equip_weapon_2 = ord("S");
//equip_weapon_3 = ord("D");
//equip_weapon_4 = ord("F");

function check_one_key(include_loadout){ //please refine, terrible implementation
	var current_press = 0;
	if(include_loadout == true){
		if(keyboard_check(obj_key_map.equip_weapon_1)){
			current_press++;
		}
		if(keyboard_check(obj_key_map.equip_weapon_2)){
			current_press++;
		}
		if(keyboard_check(obj_key_map.equip_weapon_3)){
			current_press++;
		}
		if(keyboard_check(obj_key_map.equip_weapon_4)){
			current_press++;
		}	
	}
	if(keyboard_check(obj_key_map.go_left)){
		current_press++;
	}
	if(keyboard_check(obj_key_map.go_right)){
		current_press++;
	}
	if(keyboard_check(obj_key_map.go_up)){
		current_press++;
	}
	if(keyboard_check(obj_key_map.go_down)){
		current_press++;
	}	
	if(keyboard_check(obj_key_map.open_console)){
		current_press++;
	}
	if(keyboard_check(obj_key_map.open_menu)){
		current_press++;
	}
	if(keyboard_check(obj_key_map.esc)){
		current_press++;
	}
	if(keyboard_check(obj_key_map.jump_ok)){
		current_press++;
	}
	if(keyboard_check(obj_key_map.fire_back)){
		current_press++;
	}	
	
	
	if(current_press == 1){
		return true;
	} else{
		return false;
	}
}

function is_console_open(){
	if(instance_exists(obj_console)){
		if(obj_console.visible){
			return true;
		}
	}
		return false;
}

function is_menu_open(){
	if(instance_exists(obj_menu_parent) && instance_exists(obj_crafting_menu) && instance_exists(obj_inventory_menu) && instance_exists(obj_encyclopedia_menu) ){
		if(obj_crafting_menu.visible == true || obj_inventory_menu.visible == true || obj_encyclopedia_menu.visible == true){
			return true;
		}
	}
	return false;
}

function set_alarm_fire(up_x_offset, up_y_offset, bullet_up, down_x_offset, down_y_offset, bullet_down, base_x_offset, base_y_offset, bullet_base){
	obj_alarm_parent.up_x_offset = up_x_offset;
	obj_alarm_parent.up_y_offset = up_y_offset;
	obj_alarm_parent.bullet_up = bullet_up;
	obj_alarm_parent.down_x_offset = down_x_offset;
	obj_alarm_parent.down_y_offset = down_y_offset;
	obj_alarm_parent.bullet_down = bullet_down;
	obj_alarm_parent.base_x_offset = base_x_offset;
	obj_alarm_parent.base_y_offset = base_y_offset;
	obj_alarm_parent.bullet_base = bullet_base;
	
}

function set_lock_status(bool_val){
	obj_arms.locked = bool_val;
}

function set_alarm(alarm_index, amount){
	obj_alarm_parent.alarm[alarm_index] = amount;
}

function get_alarm(alarm_index){
	return obj_alarm_parent.alarm[alarm_index];
}

function set_loadout_ammo(weapon_pos, amount){
	obj_loadout.loadout_ammo[weapon_pos] = real(amount);
}

function get_loadout_ammo(weapon_pos){
	return obj_loadout.loadout_ammo[weapon_pos];
}

function set_loadout_exp(weapon_pos, amount){
	obj_loadout.loadout_exp[weapon_pos] = amount;
}

function set_loadout_proj(weapon_id, amount){
	if(amount >= 0){ //should also check that <= max ammo
		for(var i = 0; i < 4; i++){
			if(weapon_id == obj_loadout.loadout_ids[i]){
				obj_loadout.loadout_proj[i] = amount;
			}
		}
	}
}

function get_loadout_proj(weapon_id){
	for(var i = 0; i < 4; i++){
			if(weapon_id == obj_loadout.loadout_ids[i]){
				return obj_loadout.loadout_proj[i];
			}
		}
	return -1;
}

function map_list_search(search_list,weapon_id){
	for(var i = 0; i < ds_list_size(search_list); i++){
		var list_id = search_list[| i];
		var found_id = ds_map_find_value(list_id,"id");
		if(weapon_id == found_id){
			return i;
		}
	}
	return -1;
}

function map_list_info(search_list, search_index,key){
	var list_id = search_list[| search_index];
	if(ds_map_exists(list_id, key)){
		return ds_map_find_value(list_id, key);
	}
	else return -1;
}


function obtain_current_ammo_info(){
	var current_weapon_id = obj_loadout.loadout_ids[obj_loadout.current_weapon];
	var search_index = map_list_search(obj_menu_parent.weapon_inventory, current_weapon_id);
	var current_weapon_level = obj_loadout.current_weapon_level;
	var ammo_check = ds_map_find_value((obj_menu_parent.weapon_inventory[| search_index]), "ammo");
	var temp_string = "";
	if (real(current_weapon_level) < 1){
		temp_string = ammo_check[0];
	} else {
		temp_string = ammo_check[current_weapon_level-1];
	}
	return string_split(temp_string, "_");
	//return array with 7 elements
	//-weapon type
	//-max ammo
	//-starting ammo
	//-ammo recharge rate
	//-before fire delay
	//-after fire delay
	//-max projectiles on screen
}



function shoot_shot(up_x_offset, up_y_offset, bullet_up, down_x_offset, down_y_offset, bullet_down, base_x_offset, base_y_offset, bullet_base){
	var temp_array = obtain_current_ammo_info();
	//weapon-type_max-ammo_starting-ammo_ammo-recharge-rate_before-delay_after-delay_max-possible-projectiles
	var weapon_type = temp_array[0]; //spam, charge, auto
	var max_ammo = temp_array[1]; //0-n
	var current_ammo = get_loadout_ammo(obj_loadout.current_weapon); //we want the current ammo stored by loadout because it isn't constant
	var ammo_recharge = temp_array[3]; //how long before 1 ammo is restocked
	var before_delay = temp_array[4]; //how long it takes to spawn a bullet obj after the fire button is pushed
	var after_delay = temp_array[5]; //how long until the fire button can be pushed again once a bullet obj is spawned
	var max_proj = temp_array[6]; //how many bullet obj of the current weapon are allowed to be on screen
	var current_proj_count = get_loadout_proj(obj_loadout.loadout_ids[obj_loadout.current_weapon]);
	if (weapon_type == "spam" || weapon_type == "auto"){
		//"spam_n_n_0_0.1_0.4_n"
		if ((max_ammo == "-1") || (current_ammo > 0)){ //weaon has infinite max ammo or has ammo
			if (current_proj_count <= real(max_proj)){
				if(obj_alarm_parent.alarm[2] < 0){ //if alarm is inactive or has elapsed
					//if statement for if it has a before delay, if yes then set alarm
					if (real(before_delay) > 0){
						set_alarm_fire(up_x_offset, up_y_offset, bullet_up, down_x_offset, down_y_offset, bullet_down, base_x_offset, base_y_offset, bullet_base)
						obj_alarm_parent.alarm[1] = real(before_delay) * game_get_speed(gamespeed_fps); //set an alarm
					} else {
						if (max_ammo != "-1"){
							set_loadout_ammo(obj_loadout.current_weapon, current_ammo - 1);
						}
						obj_alarm_parent.alarm[0] = real(ammo_recharge) * game_get_speed(gamespeed_fps); //if a shot is fired reset recharge alarm
						fire(up_x_offset, up_y_offset, bullet_up, down_x_offset, down_y_offset, bullet_down, base_x_offset, base_y_offset, bullet_base);
						if (real(after_delay) > 0){
							obj_alarm_parent.alarm[2] = real(after_delay) * game_get_speed(gamespeed_fps); //set an alarm
						}
					}
				}
			} else {
				//show_debug_message("max proj on screen")
			}
		} else if(weapon_type == "auto"){
			set_lock_status(true);
		}
		
	} else if(weapon_type == "charge"){
		//"charge_1_0_0.7_0_0_n"
		
	}
}

function fire(up_x_offset, up_y_offset, bullet_up, down_x_offset, down_y_offset, bullet_down, base_x_offset, base_y_offset, bullet_base){
	var current_proj_count = get_loadout_proj(obj_loadout.loadout_ids[obj_loadout.current_weapon]);
	var current_id = obj_loadout.loadout_ids[obj_loadout.current_weapon];
	var current_level = obj_loadout.current_weapon_level;
	var bullet_angle = 0;
	if (current_id == 3 && current_level < 3){
		bullet_angle = 45;
	}
	
	if (obj_no6.sprite_index == spr_no6_jump_up || obj_no6.sprite_index == spr_no6_up){
			set_loadout_proj(obj_loadout.loadout_ids[obj_loadout.current_weapon],current_proj_count + 1);
			var temp_bullet = instance_create_layer(obj_arms.x + up_x_offset * obj_arms.image_xscale ,obj_arms.y + up_y_offset,"Instances", bullet_up);
			temp_bullet.image_angle = bullet_angle;
			temp_bullet.image_xscale = obj_arms.image_xscale;
		} else if (obj_no6.sprite_index == spr_no6_jump_down){
			set_loadout_proj(obj_loadout.loadout_ids[obj_loadout.current_weapon],current_proj_count + 1);
			var temp_bullet = instance_create_layer(obj_arms.x + down_x_offset * obj_arms.image_xscale , obj_arms.y + down_y_offset,"Instances", bullet_down);
			if(current_id == TENNISBALLTOSSER && current_level == "3"){ //bad coding, bad, bad, bad, bad, bad, bad, bad, bad, bad, bad, bad, bad
				temp_bullet.image_yscale = 1;
			} else {
				temp_bullet.image_yscale = -1;
			}
			temp_bullet.image_angle = bullet_angle;
			temp_bullet.image_xscale = obj_arms.image_xscale;
		} else if(obj_no6.sprite_index != spr_no6_found_item && obj_no6.sprite_index != spr_no6_no_item ){
			set_loadout_proj(obj_loadout.loadout_ids[obj_loadout.current_weapon],current_proj_count + 1);
			var temp_bullet = instance_create_layer(obj_arms.x + base_x_offset * obj_arms.image_xscale ,obj_arms.y + base_y_offset,"Instances", bullet_base);
			temp_bullet.image_xscale = obj_arms.image_xscale;
		}
}

