/// @description Insert description here
// You can write your code in this editor
if(object_exists(obj_tbt_lv3_turret)){
	turret_y = obj_tbt_lv3_turret.y;
	turret_x = obj_tbt_lv3_turret.x;
	x = turret_x;
	y = turret_y;
}
if (image_index == 4){
	if(target_locked == false){
		target_locked = true;
		if (object_exists(obj_enemy_parent)){
			nearest_enemy = instance_nearest(x,y, obj_enemy_parent);
			nearest_enemy_x = instance_nearest(x,y, obj_enemy_parent).target_x;
			nearest_enemy_y = instance_nearest(x,y, obj_enemy_parent).target_y;
			//calculate angle to shoot enemy
			hyp_line = point_distance(x,y, nearest_enemy_x, nearest_enemy_y);
			adj_line = point_distance(x,y, nearest_enemy_x, y);
			final_angle = 90 + arccos(adj_line/hyp_line) * 180/pi;
			if(nearest_enemy_x < x){
				final_angle = -final_angle;
			}
		}else{
			final_angle = 90;
		}
	} else{
		adjust_angle = final_angle / ticks;
		if(count != ticks){
			count++;
			if(count == ticks){
				image_angle = final_angle;
				ready_to_shoot = true;
			}else{
				image_angle += adjust_angle;
			}
		}
	}
}

if (ready_to_shoot){
	if(current_ammo != 0){ //need to add delay between shots;
		if(alarm[0] < 0){
			alarm[0] = real(0.1) * game_get_speed(gamespeed_fps); //custom alarm
			instance_create_layer(x,y, "Instances", obj_tbt_lv3_bullet);
			current_ammo = current_ammo - 1;
		}
	} else{
		instance_destroy(self);
	}
}