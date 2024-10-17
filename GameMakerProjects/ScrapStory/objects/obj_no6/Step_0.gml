/// @description Insert description here
// You can write your code in this editor

//from parent
event_inherited();
if(is_console_open() || is_menu_open()){//needs refinement, doesn't account for movement animations
	exit;
}
hp_value = ceil((hp / max_hp) * 100);
move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
move_x *= move_speed;

if (place_meeting(x,y+2, obj_collision_env)) //if on the ground
{
	move_y = 0;
	if(place_empty(x+move_x,y+2,obj_collision_env) && place_meeting(x+move_x, y+10, obj_collision_env)){ //check for slope
		move_y = abs(move_x);
	}
	
	if (keyboard_check_pressed(ord("Z"))) move_y = -jump_speed //if jump pressed
	if (keyboard_check(vk_down)){ //if down pressed
		move_x = 0;
		move_y = 0;

		//down sprite code
		if (place_meeting(x,y, obj_interact)){
			sprite_index = spr_no6_down;
			//if iteractable object, do something
		} else {
			sprite_index = spr_no6_down;
			//if no interactable object do something else
		}
	} 
	
	else{ //if down is not pressed
		
		if (keyboard_check(vk_up)){
			sprite_index = spr_no6_up;
		} else {
			sprite_index = spr_no6;
		}
	}
	
	
	if (move_x != 0){ //if walking then show walking animation
		if (sprite_get_speed(sprite_index) == 0){
			image_index = 1;
			sprite_set_speed(sprite_index, 7, spritespeed_framespersecond);
		}
	} else {
		image_index = 0;
		sprite_set_speed(sprite_index, 0, spritespeed_framespersecond);
	}
	
	

}
else{
	if (move_y < 10){
		move_y += 0.1;
	}
	if (keyboard_check(vk_up)){
		sprite_index = spr_no6_jump_up;
	} else if (keyboard_check(vk_down)){
		sprite_index = 	spr_no6_jump_down;
	}
	else {
		sprite_index = spr_no6_jump;
		
	}
}

//if (place_meeting(x,y-2,obj_collision_env)){
//	move_y = 1;
//	instance_create_layer(x,y-7,"Forground_instances", obj_impact);
//}

move_and_collide(move_x, move_y, obj_collision_env, 4, 0, 0, move_speed, -1);
//move_and_collide(move_x, move_y, obj_collision_env);

if (move_x != 0) image_xscale = sign(move_x);
//from this object

