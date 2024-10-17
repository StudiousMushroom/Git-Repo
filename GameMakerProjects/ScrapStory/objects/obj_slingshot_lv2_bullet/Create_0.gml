/// @description Insert description here
// You can write your code in this editor
ammo_count = get_loadout_ammo(obj_loadout.current_weapon);
weapon_id = SLINGSHOT;
collision_check = [];
movement_speed = 4 + 2 * ( ammo_count - 1);
current_proj_count = 0;
damage = 8 * power(2,ammo_count - 1);