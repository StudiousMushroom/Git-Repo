/// @description Insert description here
// You can write your code in this editor
current_ammo = 20;
turret_y = 0;
turret_x = 0;
weapon_id = TENNISBALLTOSSER;
target_locked = false;
ready_to_shoot = false;
final_angle = 0;
current_angle = 0;
nearest_enemy = obj_impact;
nearest_enemy_x = 0;
nearest_enemy_y = 0;
hyp_line = 0;
adj_line = 0;
ticks = ceil(game_get_speed(gamespeed_fps)/2);
adjust_angle = 0;
count = 0;
alarm[0] = -2;