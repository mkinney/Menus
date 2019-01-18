if (! global.pause) {
	exit;
}

input_up_p = keyboard_check_pressed(global.key_up);
input_down_p = keyboard_check_pressed(global.key_down);
input_enter_p = keyboard_check_pressed(global.key_enter);

var ds_grid = menu_pages[page];
var ds_height = ds_grid_height(ds_grid);

var ochange = input_down_p - input_up_p;

if (ochange != 0) {
	
	menu_option[page] += ochange;
	
	// if we are at the bottom and 
	// we hit "down" again, go back to top
	if (menu_option[page] > ds_height - 1) {
		menu_option[page] = 0;
	}
	
	// if at top and we hit "up" 
	// then go to bottom
	if (menu_option[page] < 0) {
		menu_option[page] = ds_height - 1;
	}

}

if (input_enter_p) {
	switch (ds_grid[# 1, menu_option[page]]) {
		case menu_element_type.page_transfer:
			page = ds_grid[# 2, menu_option[page]]; 
			break;
	}
	// TODO: could add audio here
}