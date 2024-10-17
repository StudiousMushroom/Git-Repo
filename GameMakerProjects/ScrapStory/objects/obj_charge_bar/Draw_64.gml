/// @description Insert description here
// You can write your code in this editor




display_set_gui_size(view_wview[0], view_hview[0]);
draw_self();

if(weapon_type == "charge"){
	if (current_ammo == max_ammo){
		bar_state = 100;
		if(sling_shot_lv2){
			displayed = "x" + string(power(2,current_ammo-1));
		}else {
			displayed = "MAX";
		}
	}else if (current_ammo != 0){
		if(sling_shot_lv2){
			bar_state = 100 - ceil(( obj_alarm_parent.alarm[0]/((real(ammo_recharge) + power(2, current_ammo) * 0.3) * game_get_speed(gamespeed_fps))) * 100);
			displayed = "x" + string(power(2,current_ammo-1));
		}else {
			bar_state = 100 - ceil(( obj_alarm_parent.alarm[0]/obj_arms.alarm_0_time) * 100);
			displayed = string(current_ammo);
		}
	}else if (obj_alarm_parent.alarm[0] == -2){
		bar_state = 0;
		displayed = "";
	}else{
		bar_state = 100 - ceil(( obj_alarm_parent.alarm[0]/obj_arms.alarm_0_time) * 100);
		displayed = "";
	}
} else if(weapon_type == "spam"){
	if(max_ammo == "0"){
		bar_state = 0;
		displayed = "";
	} else if(max_ammo == "-1"){
		bar_state = 100;
		displayed = "MAX";
	} else {
		bar_state = ceil(( current_ammo/real(max_ammo) * 100));
		displayed = string(current_ammo);
	}
	
} else if(weapon_type == "auto"){
	if(max_ammo == "0"){
		bar_state = 0;
		displayed = "";
	} else if(max_ammo == "-1"){
		bar_state = 100;
		displayed = "MAX";
	} else {
		bar_state = ceil(( current_ammo/real(max_ammo) * 100));
		displayed = string(current_ammo) + "/" + max_ammo;
	}
	
}


draw_healthbar(self.x + 6, self.y+6, self.x + 40, self.y + 10, bar_state, back_color, front_color, front_color, 0, false, false );
draw_set_font(ft_basic_hud);
//draw_text_transformed() //use for scaling text
//draw_text_ext() //use for wrap around text, ie dialouge boxes
draw_set_valign(fa_top);
draw_set_halign(fa_center)
draw_text_transformed(self.x+23,self.y+4,displayed, 0.20, 0.20, 0);