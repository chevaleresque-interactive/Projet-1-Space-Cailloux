// Voile sombre
draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0,0,gw,gh,false);
draw_set_alpha(1);

// Titre
var title = "VOUS ÊTES MORT";
draw_set_halign(fa_center); 
draw_set_valign(fa_middle);
for (var i=-2;i<=2;i++) for (var j=-2;j<=2;j++) { 
    draw_set_color(c_black); 
    draw_text(gw*0.5 + i, gh*0.28 + j, title); 
}
draw_set_color(c_white); 
draw_text(gw*0.5, gh*0.28, title);

// Score
var txt = "SCORE : " + string(global.score);
for (var i=-2;i<=2;i++) for (var j=-2;j<=2;j++) { 
    draw_set_color(c_black); 
    draw_text(gw*0.5 + i, gh*0.38 + j, txt); 
}
draw_set_color(c_white); 
draw_text(gw*0.5, gh*0.38, txt);

// Boutons
function draw_btn(x,y,w,h,label,hover){
    draw_set_color(c_white); draw_roundrect(x,y,x+w,y+h,false);
    if (hover){ draw_set_color(make_color_rgb(255,170,0)); draw_roundrect(x-2,y-2,x+w+2,y+h+2,true); }
    draw_set_color(c_black); draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_text(x+w*0.5, y+h*0.5, label);
}

var mx = device_mouse_x_to_gui(0), my = device_mouse_y_to_gui(0);
var h1 = point_in_rectangle(mx,my, bx_restart_x,bx_restart_y, bx_restart_x+btn_w, bx_restart_y+btn_h);
var h2 = point_in_rectangle(mx,my, bx_menu_x,bx_menu_y, bx_menu_x+btn_w, bx_menu_y+btn_h);

draw_btn(bx_restart_x, bx_restart_y, btn_w, btn_h, "RECOMMENCER (ENTRÉE/A)", h1);
draw_btn(bx_menu_x,    bx_menu_y,    btn_w, btn_h, "MENU (ÉCHAP/B)",        h2);
