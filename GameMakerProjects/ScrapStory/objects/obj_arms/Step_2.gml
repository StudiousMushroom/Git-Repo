/// @description Insert description here
// You can write your code in this editor
if(is_console_open() || is_menu_open()){
	exit;
}


temp_array = obtain_current_ammo_info(); //should return an array of size 7
image_xscale = obj_no6.image_xscale
no6_y = obj_no6.y;
no6_x = obj_no6.x;
if(obj_no6.sprite_index == spr_no6 || obj_no6.sprite_index == spr_no6_up){ //raise weapon sprite position a bit
	if(floor(obj_no6.image_index) == 1  || floor(obj_no6.image_index)==3){
		no6_y = no6_y - 1;
	}
} else if(obj_no6.sprite_index == spr_no6_jump || obj_no6.sprite_index == spr_no6_jump_up){
	no6_y = no6_y - 1;
}

if(obj_no6.sprite_index == spr_no6_down){
	visible = false;
} else {
	visible = true;
}
x = no6_x;
y = no6_y;

current_weapon_id = obj_loadout.loadout_ids[obj_loadout.current_weapon];
if(object_exists(obj_menu_parent)){
	search_index = map_list_search(obj_menu_parent.weapon_inventory, current_weapon_id);
	if (search_index == -1){
		current_weapon_level = "0";
	}
	else {
		current_weapon_level = obj_loadout.current_weapon_level;
	}
}

//if weapon sprite does not exist (failsafe)
if ((array_length(arms_lookup) - 1) < current_weapon_id){
	weapon_sprite = spr_arms;
} else { //if it does exist use the first sprite
	if(array_length(arms_lookup[current_weapon_id]) != 3){ //help to determine which sprite to use for 9 sprites
		lookup_pos_mod = 3 * (current_weapon_level - 1);
	} else{
		lookup_pos_mod = 0;
	}
	if (obj_no6.sprite_index == spr_no6_jump_up || obj_no6.sprite_index == spr_no6_up){
		weapon_sprite = arms_lookup[current_weapon_id][1 + lookup_pos_mod];
	} else if (obj_no6.sprite_index == spr_no6_jump_down){
		weapon_sprite = arms_lookup[current_weapon_id][2 + lookup_pos_mod];
	} else {
		weapon_sprite = arms_lookup[current_weapon_id][0 + lookup_pos_mod];
	}
}
sprite_index = weapon_sprite;



if (obj_no6.sprite_index != spr_no6_down){
	//for firing bullets
	if (keyboard_check_pressed(ord("X"))){
		switch (current_weapon_id)
		{
			case NOWEAPON: //no_weapon
	
			break;	
	
			case SLINGSHOT: //slingshot
			image_index = 0;
			//weapon-type_max-ammo_current-ammo_ammo-recharge-rate_before-delay_after-delay_max-possible-projectiles
			alarm_0_time = real(temp_array[3]) * game_get_speed(gamespeed_fps);
			obj_alarm_parent.alarm[0] = alarm_0_time;
		
	
			break;
	
			case JUNKREVOLVER: //Junk Revolver
			if (real(current_weapon_level) == 1 || real(current_weapon_level) == 2){
				shoot_shot(3,-6, obj_junk_revolver_bullet_up, 5, 6,obj_junk_revolver_bullet_up, -2, -6, obj_junk_revolver_bullet_right);
				obj_alarm_parent.alarm[0] = -2;
			} else {
				//do targeting mechanic
				if(get_loadout_ammo(obj_loadout.current_weapon) == 0){ //if not in the middle of firing function
					jrlv3_is_firing = false;
					alarm_0_time = real(temp_array[3]) * game_get_speed(gamespeed_fps);
					obj_alarm_parent.alarm[0] = alarm_0_time;
				}
			}
			break;
			
			case TENNISBALLTOSSER: //TBT
				if (real(current_weapon_level) == 2){
					shoot_shot(5,-4, obj_tbt_lv2_bullet_up, 5, 6,obj_tbt_lv2_bullet_up, 5, 2, obj_tbt_lv2_bullet);
				}else if (real(current_weapon_level) == 3){
					if (get_loadout_ammo(obj_loadout.current_weapon) != 0){
						fire(5,-4, obj_tbt_lv3_barrel, 5, 6,obj_tbt_lv3_barrel, 5, 2, obj_tbt_lv3_barrel);
						shoot_shot(5,-4, obj_tbt_lv3_turret, 5, 6,obj_tbt_lv3_turret, 5, 2, obj_tbt_lv3_turret);
						image_index = 1;
					}
				}
			break;
	
			default:
	
			break;
		}
	}
	if (keyboard_check(ord("X"))){
		switch (current_weapon_id)
		{
			case TENNISBALLTOSSER: //T-Ball Tosser
			if(!locked){
				if(real(current_weapon_level) == 1){
					obj_alarm_parent.alarm[0] = -2;
					shoot_shot(5,-4, obj_tbt_lv1_bullet_up, 5, 6,obj_tbt_lv1_bullet_up, 5, 2, obj_tbt_lv1_bullet);
				}
			}
			break;
			
			default:
			break;
		}
	}
	if (keyboard_check_released(ord("X"))){
		switch (current_weapon_id)
		{
			case SLINGSHOT:
			if (get_loadout_ammo(obj_loadout.current_weapon) > 0){
				image_index = 1;
				if((real(current_weapon_level) == 1 )){
					fire(0,0, obj_slingshot_1_up, 0, 0,obj_slingshot_1_up, 4, 0, obj_slingshot_1);
				}else if((real(current_weapon_level) == 2 )){
					fire(0,0, obj_slingshot_lv2_bullet_up, 0, 0,obj_slingshot_lv2_bullet_up, 4, 0, obj_slingshot_lv2_bullet);
				}else{
					//lv3 fire
					for(var i = 0; i < 20; i++){
					//	fire
						fire(0,0, obj_slingshot_lv3_bullet_up, 0, 0,obj_slingshot_lv3_bullet_up, 4, 0, obj_slingshot_lv3_bullet);
					}
				}
				obj_alarm_parent.alarm[0] = -2;
			}
			break;
			case JUNKREVOLVER:
			if ((real(current_weapon_level) == 3 )){
				if (get_loadout_ammo(obj_loadout.current_weapon) > 0){ //if more then 0 ammo
					//function for firing at targets, what if weapon switched?
					jrlv3_is_firing = true;
					fire_jr_lv3();
					obj_alarm_parent.alarm[0] = -2;
				}
			}
			
			case TENNISBALLTOSSER:
				if ((real(current_weapon_level) == 1)){
					locked = false;
				}
			break;
			
			default:
		
			break;
		}
	}

	if(!keyboard_check(ord("X"))){//if not holding down the fire button
		if(current_weapon_id == JUNKREVOLVER && current_weapon_level == 3 && jrlv3_is_firing == true){
			//do nothing
		}else if(temp_array[0] == "charge"){
				obj_alarm_parent.alarm[0] = -2;
				set_loadout_ammo(obj_loadout.current_weapon, 0);
		}
	}
} else {//if no6 is searching
	if(temp_array[0] == "charge"){
		//ds_list_clear(target_list); //stop targeting enemies
		obj_alarm_parent.alarm[0] = -2;
		set_loadout_ammo(obj_loadout.current_weapon, 0)
	}
}