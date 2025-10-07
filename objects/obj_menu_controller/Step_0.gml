/// obj_menu_controller : Étape

// Si aucun bouton, on ne fait rien
if (!is_array(btns) || array_length(btns) == 0) exit;

// Réinit du "confirm" (consommé dans les boutons)
global.ui_confirm_pressed = false;

// ---------- Navigation ↑/↓ ----------
var moved = 0;

// Clavier
if (keyboard_check_pressed(vk_up))   moved = -1;
if (keyboard_check_pressed(vk_down)) moved =  1;

// D-pad manette
if (gamepad_is_connected(0)) {
    if (gamepad_button_check_pressed(0, gp_padu)) moved = -1;
    if (gamepad_button_check_pressed(0, gp_padd)) moved =  1;

    // Stick gauche vertical — déclenche sur “edge” (franchissement de la deadzone)
    var ly = gamepad_axis_value(0, gp_axislv);

    if (prev_ly >= -deadzone && ly < -deadzone) moved = -1; // vient de pousser vers le haut
    if (prev_ly <=  deadzone && ly >  deadzone) moved =  1; // vient de pousser vers le bas

    prev_ly = ly;
}

if (moved != 0) {
    sel = (sel + moved + array_length(btns)) mod array_length(btns);
}

// ---------- Valider (Entrée / A) ----------
if (keyboard_check_pressed(vk_enter) ||
    (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face1))) {
    global.ui_confirm_pressed = true;
}

// ---------- Retour (Échap / B / Start) ----------
if (keyboard_check_pressed(vk_escape) ||
    (gamepad_is_connected(0) && (gamepad_button_check_pressed(0, gp_face2) || gamepad_button_check_pressed(0, gp_start)))) {

    // Priorité : obj_quitter2 (retour menu) > obj_quitter (quitter jeu)
    var target = noone;
    if (instance_exists(obj_quitter2))      target = instance_find(obj_quitter2, 0);
    else if (instance_exists(obj_quitter))  target = instance_find(obj_quitter, 0);

    if (instance_exists(target)) with (target) button_activate();
}

// ---------- Focus visuel pour les boutons ----------
for (var i = 0; i < array_length(btns); i++) {
    var b = btns[i];
    if (instance_exists(b)) with (b) {
        my_focus = (i == other.sel); // lu dans le Step des boutons
    }
}
