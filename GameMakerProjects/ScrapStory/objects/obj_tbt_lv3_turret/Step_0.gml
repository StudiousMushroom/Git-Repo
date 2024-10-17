/// @description Insert description here
// You can write your code in this editor
obj_arms.image_index = 2;
y_move = clamp(y_move, 0, 5);
//position of weaopon in loadout
if (weapon_id == obj_loadout.loadout_ids[0]){
	current_pos = 0;
} else if (weapon_id == obj_loadout.loadout_ids[1]){
	current_pos = 1;
} else if (weapon_id == obj_loadout.loadout_ids[2]){
	current_pos = 2;
} else if (weapon_id == obj_loadout.loadout_ids[3]){
	current_pos = 3;
} else {
	current_pos = -1;
}
if(instance_exists(obj_tbt_lv3_barrel)){
	if(image_index == 4){
		sprite_set_speed(sprite_index, 0, spritespeed_framespersecond);
		sprite_set_speed(obj_tbt_lv3_barrel.sprite_index, 0, spritespeed_framespersecond);
	}
}


//turret movement
collision_check = move_and_collide(x_move * image_xscale , y_move, obj_collision_env);
y_move += inst_gravity;
if(place_meeting(x,y+2, obj_collision_env)){ //collide with floor
	if (grounded == false){
		grounded = true;
		x_move = 0;
		y_move = 0;
		inst_gravity = 0;
		//unfold turret
		sprite_set_speed(sprite_index, 10, spritespeed_framespersecond);
		sprite_set_speed(obj_tbt_lv3_barrel.sprite_index, 10, spritespeed_framespersecond);
	}
}
if(place_meeting(x + image_xscale, y, obj_collision_env)){ //collide with wall
	x_move = 0;
}
if(!place_meeting(x,y,obj_collision_env) && y_move = 0){ //on a block that was just destroyed
	inst_gravity = 0.25;
}


if(!instance_exists(obj_tbt_lv3_barrel)){
	if (current_pos != -1){
		set_loadout_ammo(current_pos, 1);
		set_loadout_proj(weapon_id, 0);
	}
	obj_arms.image_index = 0;
	instance_destroy(self);
}


if (place_meeting(x,y,obj_collision_env)){ //spawned in a wall
	set_loadout_proj(weapon_id,0);
	if(instance_exists(obj_tbt_lv3_barrel)){
		instance_destroy(instance_find(obj_tbt_lv3_barrel, 1));
	}else{ 
		instance_destroy(self);
		set_loadout_ammo(current_pos, 1);
	}
}