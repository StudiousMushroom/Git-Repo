/// @description Insert description here
// You can write your code in this editor

//have 4 arrays
//one array for inventory, crafting, encyclopedia menu switching
//one array for holding info on what weapons are in the loadout
//one array for holding info on position and info of scrap
//one array for holding info on position and info of weapons

//populate arrays on room start with info from saved data
//for now just use static array in create


//scarp and weapon arrays will be visually represented as a matrix, but
//will function as 1D array

//arrays will be traveresed based on arrow key inputs

//have a state machine for which array the cursor is currently in

//inside state machine have logic for traversal

//have a imaginary rectangle/bounds for what info is currently displayed
//in scrap and weapon matrix, ex 4x4 scrap matrix is actually a position 0 to 15
//sliding window

event_inherited();
if(menu_pos_name == "obj_inventory_menu"){
	
}