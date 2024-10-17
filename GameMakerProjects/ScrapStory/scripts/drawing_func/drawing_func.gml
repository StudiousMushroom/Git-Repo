// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_rectangle_outline(x1,y1,x2,y2,thickness){
	thickness = ceil(min(10, max(1,thickness)));
	draw_rectangle(x1,y1,x1+thickness-1,y2, false);
	draw_rectangle(x2-thickness+1,y1,x2,y2, false);
	draw_rectangle(x1+thickness,y1,x2-thickness,y1 + thickness - 1, false);
	draw_rectangle(x1+thickness,y2-thickness+1,x2-thickness,y2, false);
}

function fit_text_to_size(text, size){
	var draw_width = string_width(text);
	return size / draw_width; //how much to scale text in draw_text_transformed
	
}

function move_cursor(movement, submenu_open, array_of_origins){
	//what arrow key direction was pressed
	//is a submenu open
	//an array containg array name, position of element in array, x and y
	
	if(submenu_open){ //if a submenu is open
		//
		//to do
		//
		
		
	}else{ //if a submenu is not open
		var array_of_origins_info = [];
		var current_x = 0;
		var current_y = 0;
		
		//get current_x and current_y based on array name and array position
		for(var i = 0; i < array_length(array_of_origins); i++){
			var check_array = array_of_origins[i];
			if(check_array[0] == obj_menu_parent.array_pos_name && check_array[1] == obj_menu_parent.array_pos){
				current_x = check_array[2];
				current_y = check_array[3];
				array_of_origins_info = check_array;
				break;
			}
		}
		if(current_x == 0 && current_y == 0){
			show_debug_message("the element was not found in function move_cursor")
		}else{
			var search_x = 0;
			var search_y = 0;
			if(movement == obj_key_map.go_right){
				//if possible, move cursor to a point that is the closest y and closest x > current_x
				search_x = 1;
				search_y = 0;
			}else if(movement == obj_key_map.go_left){
				//if possible, move cursor to a point that is the closest y and closest x < current_x
				search_x = -1;
				search_y = 0;
			}else if(movement == obj_key_map.go_up){
				//if possible, move cursor to a point that is the closest y > current_y and closest x
				search_x = 0;
				search_y = 1;
			}else if(movement == obj_key_map.go_down){
				//if possible, move cursor to a point that is the closest y < current_y and closest x
				search_x = 0;
				search_y = -1;
			}
			if(search_x == 0 and search_y == 0){
				//do nothing
				show_debug_message("an incorrect movement was givien in move_cursor")
			}else{
				//run through for loop with search terms
				for(var i = 0; i < array_length(array_of_origins); i++){
					var check_array = array_of_origins[i];
					
					//based on search_X and search_y
					//find array where x and y is closest less than, greater then, or closest in general
					/*if(check_array[0] == obj_menu_parent.array_pos_name && check_array[1] == obj_menu_parent.array_pos){
						
						current_x = check_array[2];
						current_y = check_array[3];
						array_of_origins_info = check_array;
						break;
					}
					*/
					return array_of_origins_info;
				}
			}	
		}
		
		
		
	}
}