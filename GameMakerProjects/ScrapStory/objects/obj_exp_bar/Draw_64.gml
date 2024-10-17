/// @description Insert description here
// You can write your code in this editor
display_set_gui_size(view_wview[0], view_hview[0]);
draw_self();


if (current_exp == 0){
	bar_state = 0;
} else {
	if (current_exp < max_exp[0]){
		bar_state = ceil((current_exp / max_exp[0]) * 100);
	} else if (current_exp < max_exp[1]){
		bar_state = ceil(((current_exp - max_exp[0]) / (max_exp[1] - max_exp[0])) * 100);
	} else if (current_exp < max_exp[2]){
		bar_state = ceil(((current_exp - max_exp[1]) / (max_exp[2] - max_exp[1])) * 100);
	} else {
		bar_state = 100;
	}
}

draw_healthbar(self.x + 6, self.y+6, self.x + 40, self.y + 10, bar_state, back_color, front_color, front_color, 0, false, false );
draw_set_font(ft_basic_hud);
//draw_text_transformed() //use for scaling text
//draw_text_ext() //use for wrap around text, ie dialouge boxes
draw_set_valign(fa_top);
draw_set_halign(fa_center)

if((current_exp < max_exp[2]) || max_exp[2] == 0){
	draw_text_transformed(self.x+23,self.y+4,string_concat("LV ",level ), 0.20, 0.20, 0);
} else{
	draw_text_transformed(self.x+23,self.y+4, "MAX", 0.20, 0.20, 0);
}
