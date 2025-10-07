// Dimensions GUI
gw = display_get_gui_width();
gh = display_get_gui_height();

// Boutons (zones cliquables)
btn_w = 380; btn_h = 72; sp = 16;
bx_restart_x = gw*0.5 - btn_w*0.5;
bx_restart_y = gh*0.5;
bx_menu_x    = gw*0.5 - btn_w*0.5;
bx_menu_y    = bx_restart_y + btn_h + sp;
