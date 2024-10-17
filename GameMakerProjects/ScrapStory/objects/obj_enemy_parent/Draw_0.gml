/// @description Insert description here
// You can write your code in this editor
draw_self();
if(target_count != 0){
	draw_set_color(c_red);
	draw_set_font(ft_basic_hud);
	draw_set_valign(fa_top);
	draw_set_halign(fa_right);
	draw_text_transformed(target_x - 4,target_y - 9, target_count, 0.20, 0.20, 0);
	draw_set_halign(fa_center); //set back
	draw_set_color(c_white); //set back
	draw_sprite(spr_junk_revolver_targeting, target_frame, target_x, target_y);
}