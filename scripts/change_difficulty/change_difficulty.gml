/// @description change_difficulty - this script is more of a guide

/* 

Examples:
- changing variables: health, difficulty, detection radius
- including/not including particular AI abilities

*/

var type = menu_option[page];

if (type == 0) {
	
	// enemies
	switch (argument0) {
		
		case 0: // easy
			// global.enemy_health = 1;
			break;
			
		case 1: // medium
			// global.enemy_health = 2;
			break;
			
		case 2: // hard
			// global.enemy_health = 3;
			break;
	}
} else {
	// allies
}