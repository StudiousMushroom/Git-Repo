/// @description Insert description here
// You can write your code in this editor
if(angle_calc < 0){
	x_reverse = -1;
	y_reverse = 1;
}
collision_check = move_and_collide(x_reverse * x_movement, y_reverse * y_movement, obj_collision_env);
if (array_length(collision_check) > 0){
	instance_create_layer(x, y,"Forground_Instances", obj_impact);
	instance_destroy(self);
}
if (place_meeting(x,y,obj_collision_env)){
	instance_destroy(self);
}