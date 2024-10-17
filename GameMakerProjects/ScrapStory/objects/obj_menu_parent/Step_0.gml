/// @description Insert description here
// You can write your code in this editor

//if 'c' (the menu button) is pushed
//if the menu is open, then close it
//close sub dialogue boxes
//save cursor position
//save which menu was open
//update weapons in loadout

//if menu not open then open it
//load cursor position
//load last menu



if(!is_console_open()){
	if(keyboard_check_pressed(obj_key_map.open_menu)){
		menu_is_open = !menu_is_open;
		if(!instance_exists(obj_crafting_menu)){
			instance_create_layer(0,0,"Forground_instances",obj_crafting_menu);
			obj_crafting_menu.visible = false;
		} if(!instance_exists(obj_encyclopedia_menu)){
			instance_create_layer(0,0,"Forground_instances",obj_encyclopedia_menu);
			obj_encyclopedia_menu.visible = false;
		} if(!instance_exists(obj_inventory_menu)){
			instance_create_layer(0,0,"Forground_instances",obj_inventory_menu);
			obj_inventory_menu.visible = false;
		}
		if(menu_is_open){
			asset_get_index(menu_pos_name).visible = true;
		} else{
			asset_get_index(menu_pos_name).visible = false;
		}
	}
	//cursor logic
	if(is_menu_open()){
		switch(menu_pos_name){ //state machine for menu
			case "obj_inventory_menu":
				switch(array_pos_name){ //state machine for inventory
						case "menu_switch":
							if(check_one_key(false)){
								//show_debug_message("(menu_pos_name: {0}, array_pos_name: {1}, array_pos: {2}",menu_pos_name, array_pos_name, array_pos);
								if(keyboard_check_pressed(obj_key_map.go_right)){ //press right
									if(array_pos < (array_length(menu_switch) - 1)){
										array_pos += 1;
									}
								}else if(keyboard_check_pressed(obj_key_map.go_left)){//press left
									if(array_pos != 0){
										array_pos += -1;
									}
								}else if(keyboard_check_pressed(obj_key_map.go_down)){//press down
									//to do
									//when switching arrays, pick a position closest to current position in gui
									//otherwise cursor jankily moves back to old save positions which doesn't look nice
									
									previous_menu_switch_pos = array_pos;
									array_pos = previous_menu_loadout_pos;
									array_pos_name = "menu_loadout";
								}else if(keyboard_check_pressed(obj_key_map.jump_ok)){//press z
									//switch to different menu
									menu_pos_name = menu_switch[array_pos];
								}else if(keyboard_check_pressed(obj_key_map.fire_back)){//press x
									//exit menu
									menu_is_open = false;
								}
							}
				
						break;
				
						case "menu_loadout":
							if(check_one_key(false)){
								//show_debug_message("(menu_pos_name: {0}, array_pos_name: {1}, array_pos: {2}",menu_pos_name, array_pos_name, array_pos);
								if(keyboard_check_pressed(obj_key_map.go_right)){ //press right
									if(array_pos < (array_length(menu_loadout) - 1)){
										array_pos += 1;
									}
								}else if(keyboard_check_pressed(obj_key_map.go_left)){//press left
									if(array_pos != 0){
										array_pos += -1;
									}
								}
								else if(keyboard_check_pressed(obj_key_map.go_up)){//press up
									previous_menu_loadout_pos = array_pos;
									array_pos = previous_menu_switch_pos
									array_pos_name = "menu_switch";
								}else if(keyboard_check_pressed(obj_key_map.go_down)){//press down
									previous_menu_loadout_pos = array_pos;
									if(last_in_scrap){
										array_pos = previous_inventory_scrap_pos;
										array_pos_name = "inventory_scrap";
									}else{
										array_pos = previous_inventory_weapons_pos;
										array_pos_name = "inventory_weapons";
									}
								}else if(keyboard_check_pressed(obj_key_map.jump_ok)){//press z
									//open submenu or select submenu option
									if(submenu_is_open){
										//select submenu option
									}else{
										submenu_is_open = true;
									}
								}else if(keyboard_check_pressed(obj_key_map.fire_back)){//press x
									//exit menu or submenu
									if(submenu_is_open){
										submenu_is_open = false;
									}else{
										menu_is_open = false;
									}
								}
							}
				
						break;
				
						case "inventory_scrap":
							if(check_one_key(false)){
								//show_debug_message("(menu_pos_name: {0}, array_pos_name: {1}, array_pos: {2}",menu_pos_name, array_pos_name, array_pos);
								if(keyboard_check_pressed(obj_key_map.go_right)){ //press right
									if(((array_pos+1) mod displayed_scrap_horizontal) == 0){//if at the right side
										array_pos = min(floor(array_pos/displayed_scrap_horizontal),(displayed_weapon_vertical-1));
										array_pos = array_pos * displayed_weapon_horizontal;
										array_pos_name = "inventory_weapons";
									}else{
										array_pos += 1;
									}
								} else if(keyboard_check_pressed(obj_key_map.go_left)){ //press left
									if(((array_pos+1) mod displayed_scrap_horizontal) != 1){//if at the left side
										array_pos += -1;
									}
								} else if(keyboard_check_pressed(obj_key_map.go_up)){ //press up
									if(array_pos < displayed_scrap_horizontal){//if at the top row
										previous_inventory_scrap_pos = array_pos;
										array_pos = previous_menu_loadout_pos;
										array_pos_name = "menu_loadout";
										last_in_scrap = true;
										last_in_weapons = false;
									}else{
										array_pos += -displayed_scrap_horizontal;
									}
								} else if(keyboard_check_pressed(obj_key_map.go_down)){ //press down
									if(array_pos < ((displayed_scrap_horizontal * displayed_scrap_vertical) - displayed_scrap_horizontal)){//if at the bottom row
										array_pos += displayed_scrap_horizontal;
									}
								} else if(keyboard_check_pressed(obj_key_map.jump_ok)){//press z
									//open submenu or select submenu option
									if(submenu_is_open){
										//select submenu option
									}else{
										submenu_is_open = true;
									}
								}else if(keyboard_check_pressed(obj_key_map.fire_back)){//press x
									//exit menu or submenu
									if(submenu_is_open){
										submenu_is_open = false;
									}else{
										menu_is_open = false;
									}
								}
								//etc for each movement and action
								
							}
				
						break;
						
						case "inventory_weapons":
							if(check_one_key(false)){
								//show_debug_message("(menu_pos_name: {0}, array_pos_name: {1}, array_pos: {2}",menu_pos_name, array_pos_name, array_pos);
								if(keyboard_check_pressed(obj_key_map.go_left)){ //press left
									if((((array_pos+1) mod displayed_weapon_horizontal) == 1) || displayed_weapon_horizontal == 1 ){//if at the left side
										array_pos = min(floor(array_pos/displayed_weapon_horizontal),(displayed_scrap_vertical-1));
										array_pos = (array_pos + 1) * displayed_scrap_horizontal - 1;
										array_pos_name = "inventory_scrap";
									}else{
										array_pos += -1;
									}
								} else if(keyboard_check_pressed(obj_key_map.go_right)){ //press right
									if(((array_pos+1) mod displayed_weapon_horizontal) != 0){//if at the right side
										array_pos += 1;
									}
								} else if(keyboard_check_pressed(obj_key_map.go_up)){ //press up
									if(array_pos < displayed_weapon_horizontal){//if at the top row
										previous_inventory_weapons_pos = array_pos;
										array_pos = previous_menu_loadout_pos;
										array_pos_name = "menu_loadout";
										last_in_scrap = false;
										last_in_weapons = true;
									}else{
										array_pos += -displayed_weapon_horizontal;
									}
								} else if(keyboard_check_pressed(obj_key_map.go_down)){ //press down
									if(array_pos < ((displayed_weapon_horizontal * displayed_weapon_vertical) - displayed_weapon_horizontal)){//if at the bottom row
										array_pos += displayed_weapon_horizontal;
									}
								} else if(keyboard_check_pressed(obj_key_map.jump_ok)){//press z
									//open submenu or select submenu option
									if(submenu_is_open){
										//select submenu option
									}else{
										submenu_is_open = true;
									}
								}else if(keyboard_check_pressed(obj_key_map.fire_back)){//press x
									//exit menu or submenu
									if(submenu_is_open){
										submenu_is_open = false;
									}else{
										menu_is_open = false;
									}
								}
								//etc for each movement and action
							}
				
						break;
				
						default:
					}
				
			break;
			
			case "obj_crafting_menu":
			//state machine for crafting
				switch(array_pos_name){ //state machine for inventory
						case "menu_switch":
							if(check_one_key(false)){
								if(keyboard_check_pressed(obj_key_map.go_right)){ //press right
									if(array_pos < (array_length(menu_switch) - 1)){
										array_pos += 1;
									}
								}else if(keyboard_check_pressed(obj_key_map.go_left)){//press left
									if(array_pos != 0){
										array_pos += -1;
									}
								}else if(keyboard_check_pressed(obj_key_map.go_down)){//press down
									//previous_menu_switch_pos = array_pos;
									//array_pos = previous_menu_loadout_pos;
									//array_pos_name = "menu_loadout";
								}else if(keyboard_check_pressed(obj_key_map.jump_ok)){//press z
									//switch to different menu
									menu_pos_name = menu_switch[array_pos];
								}else if(keyboard_check_pressed(obj_key_map.fire_back)){//press x
									//exit menu
									menu_is_open = false;
								}
							}
				
						break;
						
						default:
						
						break;
						
					}
			
			break;
			
			case "obj_encyclopedia_menu":
			//state machine for encyclopedia
				switch(array_pos_name){ //state machine for inventory
						case "menu_switch":
							if(check_one_key(false)){
								if(keyboard_check_pressed(obj_key_map.go_right)){ //press right
									if(array_pos < (array_length(menu_switch) - 1)){
										array_pos += 1;
									}
								}else if(keyboard_check_pressed(obj_key_map.go_left)){//press left
									if(array_pos != 0){
										array_pos += -1;
									}
								}else if(keyboard_check_pressed(obj_key_map.go_down)){//press down
									//previous_menu_switch_pos = array_pos;
									//array_pos = previous_menu_loadout_pos;
									//array_pos_name = "menu_loadout";
								}else if(keyboard_check_pressed(obj_key_map.jump_ok)){//press z
									//switch to different menu
									menu_pos_name = menu_switch[array_pos];
								}else if(keyboard_check_pressed(obj_key_map.fire_back)){//press x
									//exit menu
									menu_is_open = false;
								}
							}
				
						break;
						
						default:
						
						break;
						
					}
			
			break;
			
			default:
			
		}
		
		
		//state machine for determining final cursor position
		switch(array_pos_name){
			case "menu_switch":
				icon_select_x = obj_inventory_menu.menu_array_x + 1 + 26 * array_pos;
				icon_select_y = obj_inventory_menu.menu_array_y + 1;
				if(array_pos_name == "menu_switch" && array_pos == 2){
					icon_select_x += 1;
				}
			break;
			
			case "menu_loadout":
				icon_select_x = obj_inventory_menu.loadout_array_x + 6 + 20 * array_pos;
				icon_select_y = obj_inventory_menu.loadout_array_y + 6;
			break;
			
			case "inventory_scrap":
				icon_select_x = obj_inventory_menu.scrap_matrix_x + 4 + 16 * (array_pos mod displayed_scrap_horizontal);
				icon_select_y = obj_inventory_menu.scrap_matrix_y + 4 + 16 * floor(array_pos/displayed_scrap_horizontal);
			break;
			
			case "inventory_weapons":
				icon_select_x = obj_inventory_menu.weapon_matrix_x + 4 + 16 * (array_pos mod displayed_weapon_horizontal);
				icon_select_y = obj_inventory_menu.weapon_matrix_y + 4 + 16 * floor(array_pos/displayed_weapon_horizontal);
			break;
			
			//case "crafting_scrap":
			//break;
			
			//case "crafting_weapons":
			//break;
			
			//case "crafting_input":
			//break;
			
			//case "crafting_output":
			//break;
			
			//case "encyclopedia_entries":
			//break;
			
			default:
				show_debug_message("Error, array_pos_name is not correct, ({0})", array_pos_name);
			break;
		}
		
	}
	
}