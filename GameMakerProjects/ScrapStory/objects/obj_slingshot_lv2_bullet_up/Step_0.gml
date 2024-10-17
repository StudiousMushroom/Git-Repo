/// @description Insert description here
// You can write your code in this editor
current_proj_count = get_loadout_proj(weapon_id);
collision_check = move_and_collide(0,movement_speed * -image_yscale,obj_collision_env);
if (array_length(collision_check) > 0){
	if (image_xscale == 1){
		instance_create_layer(x + (1 * image_xscale),y,"Forground_Instances", obj_impact);
		set_loadout_proj(weapon_id,current_proj_count - 1);
		instance_destroy(self);
	} else{
		instance_create_layer(x + (2 * image_xscale),y,"Forground_Instances", obj_impact);
		set_loadout_proj(weapon_id,current_proj_count - 1);
		instance_destroy(self);
	}
}
if (place_meeting(x,y,obj_collision_env)){
	set_loadout_proj(weapon_id,current_proj_count - 1);
	instance_destroy(self);
}