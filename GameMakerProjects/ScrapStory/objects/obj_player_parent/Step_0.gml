/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(192)){ //if ~ pressed
	if(instance_exists(obj_console)){
		obj_console.visible = !obj_console.visible;
	}else{
		instance_create_layer(0,0,"Forground_instances",obj_console);
	}
	menu_visible = obj_console.visible;
}