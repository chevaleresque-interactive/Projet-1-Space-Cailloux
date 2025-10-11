/// obj_menu_controller : Step

// Rescan si on n'a encore rien (ou si les boutons ont été créés après nous)
if (!is_array(btns) || array_length(btns) == 0) scr__scan_buttons();

// Si toujours rien, on ne fait rien
if (array_length(btns) == 0) exit;

// Reset du flag "confirm" (sera consommé par le bouton focusé)
global.ui_confirm_pressed = false;

// ---------- Navigation ↑/↓ (clavier) ----------
var moved = 0;
if (keyboard_check_pressed(vk_up))   moved = -1;
if (keyboard_check_pressed(vk_down)) moved =  1;

// ---------- Navigation D-pad / Stick ----------
if (gamepad_is_connected(0)) {
    if (gamepad_button_check_pressed(0, gp_padu)) moved = -1;
    if (gamepad_button_check_pressed(0, gp_padd)) moved =  1;

    // anti-repeat sur le stick vertical
    if (move_cool > 0) move_cool--;
    var ly = gamepad_axis_value(0, gp_axislv);

    if (move_cool <= 0) {
        if (ly < -deadzone) { moved = -1; move_cool = 8; }
        if (ly >  deadzone) { moved =  1; move_cool = 8; }
    }
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
    (gamepad_is_connected(0) && (gamepad_button_check_pressed(0, gp_face2) || gamepad_button_check_pressed(0, gp_start))))
{
    // Priorité au "retour menu" s'il existe, sinon "quitter"
    var target = noone;
    var idx_rm = asset_get_index("obj_retourmenu");
    var idx_q  = asset_get_index("obj_quitter");
    if (idx_rm != -1 && instance_exists(idx_rm)) target = instance_find(idx_rm, 0);
    else if (idx_q != -1 && instance_exists(idx_q)) target = instance_find(idx_q, 0);

    if (instance_exists(target)) with (target) button_activate();
}

// ---------- Applique le focus visuel aux boutons ----------
for (var i = 0; i < array_length(btns); i++) {
    var b = btns[i];
    if (instance_exists(b)) with (b) my_focus = (i == other.sel);
}