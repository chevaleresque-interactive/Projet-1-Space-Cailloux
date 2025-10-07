// Raccourcis clavier
if (keyboard_check_pressed(vk_enter)) {
    global.score = 0; room_goto(rm_niveau);
}
if (keyboard_check_pressed(vk_escape)) {
    global.score = 0; room_goto(rm_menu);
}

// Souris
var mx = device_mouse_x_to_gui(0), my = device_mouse_y_to_gui(0);
if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mx,my, bx_restart_x,bx_restart_y, bx_restart_x+btn_w, bx_restart_y+btn_h)) {
        global.score = 0; room_goto(rm_niveau);
    }
    if (point_in_rectangle(mx,my, bx_menu_x,bx_menu_y, bx_menu_x+btn_w, bx_menu_y+btn_h)) {
        global.score = 0; room_goto(rm_menu);
    }
}

// Manette (A pour Recommencer, B pour Menu)
if (gamepad_is_connected(0)) {
    if (gamepad_button_check_pressed(0, gp_face1)) { // A
        global.score = 0; room_goto(rm_niveau);
    }
    if (gamepad_button_check_pressed(0, gp_face2)) { // B
        global.score = 0; room_goto(rm_menu);
    }
    if (gamepad_button_check_pressed(0, gp_start)) { // Start = Menu
        global.score = 0; room_goto(rm_menu);
    }
}
