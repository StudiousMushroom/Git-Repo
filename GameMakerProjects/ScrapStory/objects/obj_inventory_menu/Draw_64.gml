/// @description Insert description here
// You can write your code in this editor

//draw menu and loadout arrays
//draw scrap and weapon fake matrix
event_inherited();
if(array_length(inventory_scrap) < max(1,displayed_scrap_horizontal) * max(1,displayed_scrap_vertical)){
	array_resize(inventory_scrap,  max(1,displayed_scrap_horizontal) * max(1,displayed_scrap_vertical));
}
if(array_length(inventory_weapons) < max(1,displayed_weapon_horizontal) * max(1,displayed_weapon_vertical)){
	array_resize(inventory_weapons,  max(1,displayed_weapon_horizontal) * max(1,displayed_weapon_vertical));
}

display_set_gui_size(view_wview[0], view_hview[0]);
draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(menu_x,menu_y,menu_x+menu_width,menu_y+menu_height,false); //backgound thingy,not permanent solution
draw_set_alpha(1);
draw_sprite(spr_loadout,0,loadout_array_x,loadout_array_y);
for(var n = 0; n < 4; n++){
	var loadout_weapon_lookup = menu_loadout[n];
	if(loadout_weapon_lookup < 0 || loadout_weapon_lookup > array_length(weapon_lookup)){
		show_debug_message("loadout tried to access a weapon index that was out of bounds");
		loadout_weapon_lookup = 0;
	}
	draw_sprite(weapon_lookup[loadout_weapon_lookup],0,loadout_array_x + 6 + 20 * n, loadout_array_y + 6);
}

//swap menu draw
draw_sprite(spr_swap_menu,0,menu_array_x,menu_array_y);
draw_set_font(ft_menu_switch);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var scaling_text = fit_text_to_size("encyclopedia", 23);
draw_text_transformed(menu_array_x + ceil(menu_array_width/6), menu_array_y + ceil(menu_array_height/2),"inventory", scaling_text, scaling_text, 0);
draw_text_transformed(menu_array_x + ceil(menu_array_width*3/6), menu_array_y + ceil(menu_array_height/2),"crafting", scaling_text, scaling_text, 0);
draw_text_transformed(menu_array_x + ceil(menu_array_width*5/6), menu_array_y + ceil(menu_array_height/2),"encyclopedia", scaling_text, scaling_text, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

for(var i = 0; i < max(displayed_scrap_horizontal, displayed_weapon_horizontal); i++){
	for(var j = 0; j < max(displayed_scrap_vertical, displayed_weapon_vertical); j++){
		var pos_in_scrap_array = i + j * max(0,(displayed_scrap_horizontal));
		var pos_in_weapons_array = i + j * max(0,(displayed_weapon_horizontal));
		
		if(i < displayed_scrap_horizontal && j < displayed_scrap_vertical){
			draw_sprite(spr_slot, 0, 2 + scrap_matrix_x + 16 * i, 2 + scrap_matrix_y + 16 * j);
			var scrap_lookup_number = inventory_scrap[pos_in_scrap_array];
			if(scrap_lookup_number < 0 || scrap_lookup_number > array_length(scrap_lookup)){
				show_debug_message("scrap matrix tried to access a scrap index that was out of bounds");
				scrap_lookup_number = 0;
			}
			draw_sprite(scrap_lookup[scrap_lookup_number],0, 4 + scrap_matrix_x + 16 * i, 4 + scrap_matrix_y + 16 * j);
		}
		if(i < displayed_weapon_horizontal && j < displayed_weapon_vertical){
			draw_sprite(spr_slot, 0, 2 + weapon_matrix_x + 16 * i, 2 + weapon_matrix_y + 16 * j);
			var weapon_lookup_number = inventory_weapons[pos_in_weapons_array];
			if(weapon_lookup_number < 0 || weapon_lookup_number > array_length(weapon_lookup)){
				show_debug_message("weapon matrix tried to access a weapon index that was out of bounds");
				weapon_lookup_number = 0;
			}
			draw_sprite(weapon_lookup[weapon_lookup_number], 0, 4 + weapon_matrix_x + 16 * i, 4 + weapon_matrix_y + 16 * j);
		}
	}
}

draw_sprite_ext(spr_border_9slice,0,scrap_matrix_x,scrap_matrix_y,scrap_matrix_width_scale, scrap_matrix_height_scale,0,-1,1);
draw_sprite_ext(spr_border_9slice,0,weapon_matrix_x,weapon_matrix_y,weapon_matrix_width_scale, weapon_matrix_height_scale,0,-1,1);


draw_set_color(c_white);
