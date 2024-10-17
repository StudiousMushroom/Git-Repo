/// @description Insert description here
// You can write your code in this editor
//weapon_name = "empty"
//weapon_id = 0;

current_weapon_id = NOWEAPON;
current_weapon_level = 0;
search_index = 0;
weapon_sprite = spr_arms;

no6_x = 0;
no6_y = 0;

arms_lookup = [[spr_arms, spr_arms_up, spr_arms_down], //no weapon sprites
[spr_slingshot_base, spr_slingshot_up, spr_slingshot_down], //slingshot sprites
[spr_junk_revolver_base, spr_junk_revolver_up, spr_junk_revolver_down], //junk revolver sprites
[spr_tbt_lv1_base, spr_tbt_lv1_up, spr_tbt_lv1_down, spr_tbt_lv2_base, spr_tbt_lv2_up, spr_tbt_lv2_down, spr_tbt_lv3, spr_tbt_lv3, spr_tbt_lv3_down]//tbt sprites
];

lookup_pos_mod = 0;

move_speed = obj_player_parent.move_speed;
jump_speed = obj_player_parent.jump_speed;

move_x = obj_player_parent.move_x;
move_y = obj_player_parent.move_y;

temp_bullet = obj_junk_revolver_bullet_right;
temp_string = "";
temp_array = [];
alarm_0_time = 0;
locked = false;
jrlv3_is_firing = false;
target_list = ds_list_create(); //list containing enemy istance ids

