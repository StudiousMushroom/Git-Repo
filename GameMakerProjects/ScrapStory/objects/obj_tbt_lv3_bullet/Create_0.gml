/// @description Insert description here
// You can write your code in this editor
movement_speed = 3;
collision_check = [];
x_reverse = 1;
y_reverse = -1;
angle_calc = (obj_tbt_lv3_barrel.final_angle - (90 * sign(obj_tbt_lv3_barrel.final_angle))) * pi/180;
x_movement = movement_speed * cos(angle_calc);
y_movement = movement_speed * sin(angle_calc);
