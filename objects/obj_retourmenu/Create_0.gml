/// obj_retourmenu : Create
my_focus = false;

button_activate = function () {
	if (audio_is_playing(son_ambient)) {
    audio_stop_sound(son_ambient); 
	}
    global.score = 0;
    room_goto(rm_menu);
};
