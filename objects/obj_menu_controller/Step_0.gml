/// obj_menu_controller : Step
// Réinit du "confirm" (sera consommé dans les boutons)
global.ui_confirm_pressed = false;

// Navigation ↑/↓ (clavier + D-pad + stick)
var moved = 0;
if (keyboard_check_pressed(vk_up))   moved = -1;
if (keyboard_check_pressed(vk_down)) moved =  1;

if (gamepad_is_connected(0)) {
    if (gamepad_button_check_pressed(0, gp_padu)) moved = -1;
    if (gamepad_button_check_pressed(0, gp_padd)) moved =  1;

    var ly = gamepad_axis_value(0, gp_axislv);
    if (ly < -deadzone) moved = -1;
    if (ly >  deadzone) moved =  1;
}

if (moved != 0 && array_length(btns) > 0) {
    sel = (sel + moved + array_length(btns)) mod array_length(btns);
}

// Valider (Entrée / A)
if (keyboard_check_pressed(vk_enter) ||
    (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face1))) {
    global.ui_confirm_pressed = true;
}

// Bouton retour (Échap / B / Start) → active le bouton “retour menu” si présent, sinon “quitter jeu”
if (keyboard_check_pressed(vk_escape) ||
    (gamepad_is_connected(0) && (gamepad_button_check_pressed(0, gp_face2) || gamepad_button_check_pressed(0, gp_start)))) {
    var target = noone;
    if (instance_exists(obj_quitter2)) target = instance_find(obj_quitter2, 0);
    else if (instance_exists(obj_quitter)) target = instance_find(obj_quitter, 0);
    if (instance_exists(target)) with (target) button_activate();
}

// Applique l’état de focus aux boutons (pour le “hover” visuel)
for (var i = 0; i < array_length(btns); i++) {
    var b = btns[i];
    if (instance_exists(b)) with (b) my_focus = (i == other.sel);
}