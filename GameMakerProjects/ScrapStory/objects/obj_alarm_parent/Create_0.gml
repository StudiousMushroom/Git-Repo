/// @description Insert description here
// You can write your code in this editor

//alarm macros
#macro RECHARGE_AMMO_ALARM 0
#macro BEFORE_DELAY_ALARM 1
#macro AFTER_DELAY_ALARM 2
#macro BACKUP_RECHARGE_1 3
#macro BACKUP_RECHARGE_2 4
#macro BACKUP_RECHARGE_3 5

//alarms will be initialized at -2 not -1 to prevent confusion
alarm[RECHARGE_AMMO_ALARM] = -2; //alarm for recharging ammo
alarm[BEFORE_DELAY_ALARM] = -2; //alarm for before delay
alarm[AFTER_DELAY_ALARM] = -2; //alarm for after delay
alarm[BACKUP_RECHARGE_1] = -2; //switch alarm when switching weapons
alarm[BACKUP_RECHARGE_2] = -2;
alarm[BACKUP_RECHARGE_3] = -2;
temp_array = [];
current_ammo = 0;
max_ammo = "";
ammo_recharge = "";
weapon_type = "";
after_delay = "";
current_proj_count = 0;

current_id = NOWEAPON;
current_level = 0;

target_id = noone;


//fire info
up_x_offset = 0;
up_y_offset = 0;
bullet_up = obj_junk_revolver_bullet_up;
down_x_offset = 0;
down_y_offset = 0;
bullet_down = obj_junk_revolver_bullet_up;
base_x_offset = 0;
base_y_offset = 0;
bullet_base = obj_junk_revolver_bullet_right;