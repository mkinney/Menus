global.pause = true;

global.view_width = camera_get_view_width(view_camera[0]);
global.view_height = camera_get_view_height(view_camera[0]);

global.key_revert = ord("X");
global.key_enter = vk_enter;
global.key_left = vk_left;
global.key_right = vk_right;
global.key_up = vk_up;
global.key_down = vk_down;

display_set_gui_size(global.view_width, global.view_height);

enum menu_page {
	main,
	settings,
	audio,
	difficulty,
	graphics,
	controls,
	height
}

enum menu_element_type {
	script_runner,
	page_transfer,
	slider,
	shift,
	toggle,
	input
}

// create menu pages
ds_menu_main = create_menu_page(
	["RESUME", menu_element_type.script_runner, resume_game],
	["SETTINGS", menu_element_type.page_transfer, menu_page.settings],
	["EXIT", menu_element_type.script_runner, exit_game],
);

ds_menu_settings = create_menu_page(
	["AUDIO", menu_element_type.page_transfer, menu_page.audio],
	["DIFFICULTY", menu_element_type.page_transfer, menu_page.difficulty],
	["GRAPHICS", menu_element_type.page_transfer, menu_page.graphics],
	["CONTROLS", menu_element_type.page_transfer, menu_page.controls],
	["BACK", menu_element_type.page_transfer, menu_page.main],
);

ds_menu_audio = create_menu_page(
	["MASTER", menu_element_type.slider, change_volume, 0.5, [0,1]],
	["SOUNDS", menu_element_type.slider, change_volume, 0.2, [0,1]],
	["MUSIC", menu_element_type.slider, change_volume, 1, [0,1]],
	["BACK", menu_element_type.page_transfer, menu_page.settings],
);

ds_menu_difficulty = create_menu_page(
	["ENEMIES", menu_element_type.shift, change_difficulty, 0, ["HARMLESS", "NORMAL", "TERRIBLE"]],
	["ALLIES", menu_element_type.shift, change_difficulty, 0, ["DIM-WITTED", "NORMAL", "HELPFUL"]],
	["BACK", menu_element_type.page_transfer, menu_page.settings],
);

ds_menu_graphics = create_menu_page(
	["RESOLUTION", menu_element_type.shift, change_resolution, 0, ["384 x 216", "768 x 432", "1152 x 648", "1536 x 874", "1920 x 1080"]],
	["WINDOW MODE", menu_element_type.toggle, change_window_mode, 1, ["FULLSCREEN", "WINDOWED"]],
	["BACK", menu_element_type.page_transfer, menu_page.settings],
);

ds_menu_controls = create_menu_page(
	["UP", menu_element_type.input, "key_up", vk_up],
	["LEFT", menu_element_type.input, "key_left", vk_left],
	["RIGHT", menu_element_type.input, "key_right", vk_right],
	["DOWN", menu_element_type.input, "key_down", vk_down],
	["BACK", menu_element_type.page_transfer, menu_page.settings],
);

page = 0;
menu_pages = [
	ds_menu_main,
	ds_menu_settings,
	ds_menu_audio,
	ds_menu_difficulty,
	ds_menu_graphics,
	ds_menu_controls,
];

var i = 0;
var array_len = array_length_1d(menu_pages);
repeat (array_len) {
	menu_option[i] = 0;
	i++;
}

inputting = false;

audio_group_load(audiogroup_music);
audio_group_load(audiogroup_sound_effects);