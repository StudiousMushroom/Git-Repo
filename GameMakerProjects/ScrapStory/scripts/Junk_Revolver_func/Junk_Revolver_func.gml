// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function jr_targeting(target_count){ //which # target enemy this is
	var target_check = 6; //how many enemies will be checked
	var temp_array = [];
	for(var i = 0; i < target_check; i++){
		var temp_obj =  instance_nth_nearest( obj_no6.x, obj_no6.y, obj_enemy_parent, i+1);
		if(temp_obj != noone){
			if(in_view(temp_obj, 0)){
				array_push(temp_array, temp_obj);
			}
		}
	}
	//adjust
	var temp_len = array_length(temp_array);
	if (temp_len == 0){
		return noone;
	} else {
		var pos = 0;
		pos = (target_count % temp_len) - 1;
		if (pos == -1){
			pos += temp_len;
		}
		return temp_array[pos]; //return id of thing to target
	}
}


//from https://www.gmlscripts.com/script/instance_nth_nearest
function instance_nth_nearest(x_pos,y_pos,obj_search,number){
	var n = min(max(1,number),instance_number(obj_search));
	var temp_list = ds_priority_create();
	var nearest = noone;
	with (obj_search) ds_priority_add(temp_list, id, distance_to_point(x_pos, y_pos));
	repeat (n) nearest = ds_priority_delete_min(temp_list);
	ds_priority_destroy(temp_list);
	return nearest;
}

function in_view(obj_id, camera){ //if an object is in view return true, otherwise false
	var c_height = camera_get_view_height(view_camera[camera]);
	var c_width = camera_get_view_width(view_camera[camera]);
	var c_x = camera_get_view_x(view_camera[camera]);
	var c_y = camera_get_view_y(view_camera[camera]);
	if (obj_id.x >= c_x && obj_id.x <= c_x + c_width){
		if (obj_id.y >= c_y && obj_id.y <= c_y + c_height){
			return true;
		}
	}
	return false;
	
}

function add_target(obj_id){
	ds_list_add(obj_arms.target_list, obj_id);
}

function remove_target(obj_id){ //remove all entries in target_list that match this instance id
	var current_ammo = get_loadout_ammo(obj_loadout.current_weapon);
	if (!ds_list_empty(obj_arms.target_list)){
		for (var i; i < ds_list_size(obj_arms.target_list); i++){
			var pos = ds_list_find_index(obj_arms.target_list, obj_id);
			if(pos == -1){
				break;
			}else{
				ds_list_delete(obj_arms.target_list, pos);
				current_ammo = current_ammo - 1;
				set_loadout_ammo(obj_loadout.current_weapon, current_ammo);
			}
		}
	}
}

function fire_jr_lv3(){
	//go through each target
	if(ds_list_size(obj_arms.target_list) != 0){
		var current_ammo = get_loadout_ammo(obj_loadout.current_weapon);
		if(current_ammo != 0){
			set_loadout_ammo(obj_loadout.current_weapon, current_ammo - 1);
		}
		var temp_enemy = ds_list_find_value(obj_arms.target_list, 0);
		temp_enemy.target_count = temp_enemy.target_count - 1; //reduce number of targeting
		temp_enemy.target_frame = 1;
		temp_enemy.alarm[0] = 0.05 * game_get_speed(gamespeed_fps);
		ds_list_delete(obj_arms.target_list, 0); //delete first target
	} else {
		obj_arms.jrlv3_is_firing = false;
	}
}
