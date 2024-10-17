/// @description Insert description here
// You can write your code in this editor
if(target_frame != 3 && alarm[0] == -1){
	target_frame = target_frame + 1;
	alarm[0] = 0.05 * game_get_speed(gamespeed_fps);
} else if (target_frame == 3 && alarm[0] == -1){
	alarm[0] = -2;
	target_frame = 0;
	hp = hp - 1;
	show_debug_message(hp);
	if(ds_list_size(obj_arms.target_list) != 0){
		fire_jr_lv3();//shoot again
	}
}

//if(!in_view(self, 0) || hp <= 0){
//	target_count = 0;
//	remove_target(self);
//}



//if(hp <= 0){
//	instance_destroy(self);
//}