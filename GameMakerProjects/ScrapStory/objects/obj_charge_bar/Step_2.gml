/// @description Insert description here
// You can write your code in this editor


//move out of end step, will start to be very slow if this is always running
if (instance_exists(obj_player_parent))
{
	ammo_info = obtain_current_ammo_info()
	id_search = obj_loadout.loadout_ids[obj_loadout.current_weapon];
	search_index = map_list_search(obj_menu_parent.weapon_inventory, id_search);
	weapon_type = ammo_info[0];
	max_ammo = ammo_info[1];
	starting_ammo = ammo_info[2];
	ammo_recharge = ammo_info[3];
	current_ammo = get_loadout_ammo(obj_loadout.current_weapon);
	current_level = obj_loadout.loadout_level[obj_loadout.current_weapon];
	if(id_search == 1 && current_level == 2){
		sling_shot_lv2 = true;
	} else {
		sling_shot_lv2 = false;
	}
}