/// obj_retourmenu : Step
var over = point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom);
var is_hover = over || my_focus;

var spr_idle  = spr_button2;
var spr_hover = spr_button2_hover;
sprite_index  = is_hover ? spr_hover : spr_idle;

if ((over && mouse_check_button_pressed(mb_left)) || (my_focus && global.ui_confirm_pressed)) {
    button_activate();
}
