/// @description Insert description here
// You can write your code in this editor
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

if (current_pos != -1){
	current_ammo = get_loadout_ammo(current_pos);
}
if(image_yscale < 0){
	angle = -45;
} else {
	angle = 45;
}
x_speed = movement_speed / cos(angle);
y_speed = abs(movement_speed / sin(angle));
image_angle = angle;
//x_speed and y_speed currently wrong????
//sprite_index.angle = angle;
current_proj_count = get_loadout_proj(weapon_id);
collision_check = move_and_collide(movement_speed * image_xscale, movement_speed * -image_yscale ,obj_collision_env);
if (array_length(collision_check) > 0){
	if(current_collisions != max_collisions){
		if(place_meeting(x+ (1 * image_xscale),y, obj_collision_env) || place_meeting(x+ (1 * image_xscale),y, obj_enemy_parent)){ //if collided from side
			image_xscale = -image_xscale;
		} else{ //if collided from above or below
			image_yscale = -image_yscale;
		}
		current_collisions++;
		collision_check = [];
		
	}else{
		if (current_pos != -1){
			set_loadout_ammo(current_pos, current_ammo + 1);
		}
		if (image_xscale == 1){
			instance_create_layer(x + (0),y,"Forground_Instances", obj_impact);
			set_loadout_proj(weapon_id,current_proj_count - 1);
			instance_destroy(self);
		} else{
			instance_create_layer(x + (0),y,"Forground_Instances", obj_impact);
			set_loadout_proj(weapon_id,current_proj_count - 1);
			instance_destroy(self);
		}
	}
}
if (place_meeting(x,y,obj_collision_env)){
	set_loadout_proj(weapon_id,current_proj_count - 1);
	instance_destroy(self);
}