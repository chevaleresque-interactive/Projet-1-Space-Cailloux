/// obj_quitter2 : Étape
var over = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
                              bbox_left, bbox_top, bbox_right, bbox_bottom);
var is_hover = over || my_focus;

var spr_idle  = spr_button4;
var spr_hover = spr_button4_hover;
sprite_index  = is_hover ? spr_hover : spr_idle;

if ((over && mouse_check_button_pressed(mb_left)) || (my_focus && global.ui_confirm_pressed)) {
    button_activate();
}
