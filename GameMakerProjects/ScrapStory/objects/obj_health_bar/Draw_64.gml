/// @description Insert description here
// You can write your code in this editor
display_set_gui_size(view_wview[0], view_hview[0]);
draw_self();
draw_healthbar(self.x + 6, self.y+6, self.x + 40, self.y + 10, obj_no6.hp_value, back_color, front_color, front_color, 0, false, false );
draw_set_font(ft_basic_hud);
//draw_text_transformed() //use for scaling text
//draw_text_ext() //use for wrap around text, ie dialouge boxes
draw_set_valign(fa_top);
draw_set_halign(fa_center)
draw_text_transformed(self.x+23,self.y+4,string_concat("HP ", value_to_draw), 0.20, 0.20, 0);