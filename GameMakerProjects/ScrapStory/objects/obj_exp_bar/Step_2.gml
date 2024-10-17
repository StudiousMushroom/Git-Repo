/// @description Insert description here
// You can write your code in this editor

//move out of end step, will start to be very slow if this is always running
if (instance_exists(obj_loadout))
{
	level = obj_loadout.current_weapon_level;
	current_exp = obj_loadout.loadout_exp[obj_loadout.current_weapon];
	max_exp = obj_loadout.max_exp;
}