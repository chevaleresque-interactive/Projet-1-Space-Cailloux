// TAILLE GUI
var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Voile sombre
draw_set_alpha(0.00);
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);


// Titre
var title = "VOUS ETES MORT";
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

// Centre écran (compatible caméra fixe)
var vx = 0, vy = 0;
var vw = display_get_gui_width();
var vh = display_get_gui_height();
var cx = vw * 0.5;
var cy = vh * 0.5;

// Crée vos boutons (instances réelles)
btns = array_create(2);
btns[0] = instance_create_layer(cx, cy - 60, "Instances", obj_demarrer);
btns[1] = instance_create_layer(cx, cy + 60, "Instances", obj_quitter);

// Sélection pour manette/clavier
sel = 0;
global.ui_confirm_pressed = false; // flag lu par les boutons