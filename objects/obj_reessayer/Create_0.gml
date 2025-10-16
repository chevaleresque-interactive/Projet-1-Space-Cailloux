/// obj_reessayer : Create
my_focus = false;

button_activate = function () {
    global.score = 0;
	spawn_interval_sec = 3.0; 
	deathsound = false;
    room_goto(rm_niveau);
};
