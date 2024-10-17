/// @description Insert description here
// You can write your code in this editor
weapon_id = SLINGSHOT;
alarm[0] = 3;
collision_check = [];
movement_speed = 5 - irandom(30)/30;
current_proj_count = 0;
fire_angle = irandom(60)-30; //produce number from -30 to 30
angle_calc = fire_angle * pi/180;
x_movement = movement_speed * cos(angle_calc);
y_movement = movement_speed * sin(angle_calc);