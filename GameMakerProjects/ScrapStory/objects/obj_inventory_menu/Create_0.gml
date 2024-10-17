/// @description Insert description here
// You can write your code in this editor
event_inherited();

min_menu_width = 85;
menu_width = min(max((displayed_scrap_horizontal * 16) + 14 + (displayed_weapon_horizontal * 16), min_menu_width), view_wview[0]) //calculate based on total width from menu elements and fake matrix
min_menu_height = 63;
menu_height = min(max(max(displayed_scrap_vertical, displayed_weapon_vertical)*16 + 6 + 41,min_menu_height), view_hview[0]) //calculate based on total width from menu elements and fake matrix
menu_scaling = 2;
menu_x = ceil(view_wview[0]/2) - ceil(menu_width/2); //x point to start drawing menu border, calculated from window and menu width
menu_y = ceil(view_hview[0]/2) - ceil(menu_height/2); //y point to start drawing meny border, calculated from window and menu height

menu_array_width = 79;
menu_array_height = 13;
loadout_array_width = 85;
loadout_array_height = 25;
menu_array_x = ceil(view_wview[0]/2) - ceil(menu_array_width/2); //calculated based on overall menu dimension and position
menu_array_y = menu_y + 1;
loadout_array_x = ceil(view_wview[0]/2) - ceil(loadout_array_width/2);
loadout_array_y = 4 + menu_y + menu_array_height;

scrap_matrix_width = (displayed_scrap_horizontal * 16) + 6;
scrap_matrix_width_scale = scrap_matrix_width / sprite_get_width(spr_border_9slice);
scrap_matrix_height = (displayed_scrap_vertical * 16) + 6;
scrap_matrix_height_scale = scrap_matrix_height / sprite_get_height(spr_border_9slice);
scrap_matrix_x = menu_x;
scrap_matrix_y = loadout_array_y + loadout_array_height;
weapon_matrix_width = (displayed_weapon_horizontal * 16) + 6;
weapon_matrix_width_scale = weapon_matrix_width / sprite_get_width(spr_border_9slice);
weapon_matrix_height = (displayed_weapon_vertical * 16) + 6;
weapon_matrix_height_scale = weapon_matrix_height / sprite_get_height(spr_border_9slice);
weapon_matrix_x = scrap_matrix_x + scrap_matrix_width + 2;
weapon_matrix_y = scrap_matrix_y;
