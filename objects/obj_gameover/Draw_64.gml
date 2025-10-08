// obj_gameover : Draw GUI

// --- Dimensions GUI ---
var gw = display_get_gui_width();
var gh = display_get_gui_height();

// --- Voile sombre ---
draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);

// --- Ancrage : place le texte au-dessus du bouton du haut (selon ce qui existe) ---
var y_buttons_top = gh * 0.5 - 60;
var ref = noone;
if (instance_exists(obj_demarrer))       ref = instance_find(obj_demarrer, 0);
else if (instance_exists(obj_recommencer)) ref = instance_find(obj_recommencer, 0);
if (instance_exists(ref)) y_buttons_top = ref.y;

var y_title = y_buttons_top - 110;
var y_score = y_buttons_top - 70;

// --- Titre ---
draw_set_font(Font1);
var title = "VOUS ETES MORT";
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// (Option police : commentez si vous n’avez pas Font1)
draw_set_font(Font1);

// Ombre portée
for (var i = -2; i <= 2; i++) for (var j = -2; j <= 2; j++) {
    draw_set_color(c_black);
    draw_text(gw * 0.5 + i, y_title + j, title);
}
// Couleur principale
draw_set_color(c_white);
draw_text(gw * 0.5, y_title, title);

// --- Score ---
var txt = "SCORE : " + string(global.score);

// Ombre portée
for (var i = -2; i <= 2; i++) for (var j = -2; j <= 2; j++) {
    draw_set_color(c_black);
    draw_text(gw * 0.5 + i, y_score + j, txt);
}
// Couleur principale
draw_set_color(c_white);
draw_text(gw * 0.5, y_score, txt);

// (Si vous changez de police ailleurs, vous pouvez remettre la police par défaut avec : draw_set_font(-1);)
