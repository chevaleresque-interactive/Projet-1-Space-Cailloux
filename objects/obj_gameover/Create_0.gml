// Centre en coordonnées GUI
var vw = display_get_gui_width(), vh = display_get_gui_height();
var cx = vw * 0.5, cy = vh * 0.5;

// Crée VOS boutons animés (instances réelles)
btns = [
    instance_create_layer(cx, cy - 60, "Instances", obj_demarrer),
    instance_create_layer(cx, cy + 60, "Instances", obj_quitter)
];

sel = 0;                          // index du bouton sélectionné
global.ui_confirm_pressed = false; // flag lu par les boutons pour valider
