/// obj_reessayer : Create
my_focus = false;

button_activate = function () {
    global.score = 0;
    room_goto(rm_niveau); // on laisse rm_niveau se réinitialiser dans son contrôleur/Room Start
};
