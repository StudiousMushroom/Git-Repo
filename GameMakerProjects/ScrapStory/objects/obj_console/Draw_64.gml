/// @description Insert description here
// You can write your code in this editor
display_set_gui_size(view_wview[0], view_hview[0]);
draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(0,view_hview[0]* (3/4) - 5,view_wview[0],view_hview[0], false);
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_font(ft_console);
draw_text_transformed(0,view_hview[0] - 10,console_string, 0.25, 0.25, 0);
draw_text_transformed(0,view_hview[0] - 20,prev_string[array_length(prev_string)-1], 0.25, 0.25, 0);
draw_text_transformed(0,view_hview[0] - 30,prev_string[array_length(prev_string)-2], 0.25, 0.25, 0);
draw_text_transformed(0,view_hview[0] - 40,prev_string[array_length(prev_string)-3], 0.25, 0.25, 0);
draw_text_transformed(0,view_hview[0] - 50,prev_string[array_length(prev_string)-4], 0.25, 0.25, 0);

//set back to default values
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_center);