// Sécurités si des instances sont détruites
if (!is_array(btns) || array_length(btns) < 2) {
    btns = [ instance_find(obj_demarrer, 0), instance_find(obj_quitter, 0) ];
}
if (!variable_instance_exists(id, "sel")) sel = 0;

// ----- Navigation haut/bas : clavier + D-pad -----
var moved = 0;
if (keyboard_check_pressed(vk_up))   moved = -1;
if (keyboard_check_pressed(vk_down)) moved =  1;

if (gamepad_is_connected(0)) {
    if (gamepad_button_check_pressed(0, gp_padu)) moved = -1;
    if (gamepad_button_check_pressed(0, gp_padd)) moved =  1;
}

if (moved != 0 && array_length(btns) > 0) {
    sel = (sel + moved + array_length(btns)) mod array_length(btns);
}

// ----- Confirmer (Entrée / A) -----
global.ui_confirm_pressed =
    keyboard_check_pressed(vk_enter) ||
    (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face1));

// ----- Échap / B / Start → Menu (active le 2e bouton) -----
if (keyboard_check_pressed(vk_escape) ||
    (gamepad_is_connected(0) && (gamepad_button_check_pressed(0, gp_face2) || gamepad_button_check_pressed(0, gp_start))))
{
    if (array_length(btns) > 1 && instance_exists(btns[1])) {
        with (btns[1]) button_activate();
    }
}

// ----- Forcer l’état "focus" pour l’animation hover de VOS boutons -----
for (var i = 0; i < array_length(btns); i++) {
    var b = btns[i];
    if (instance_exists(b)) with (b) {
        my_focus = (i == other.sel); // variable lue dans les boutons
    }
}
