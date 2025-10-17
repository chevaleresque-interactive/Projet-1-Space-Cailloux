// 0) Contexte propre (évite le décalage après rm_gameover)
draw_set_alpha(1);
gpu_set_blendmode(bm_normal);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Police du score
if (!is_undefined(Font1)) draw_set_font(Font1);
else draw_set_font(-1);

// 1) Texte & position
var x0 = 32, y0 = 32;
var txt = "SCORE : " + string(global.score);

// 2) Scale du juice
var s = 1 + 0.35 * clamp(global._score_pulse, 0, 1);

// 3) Ombre / halo
for (var i = -2; i <= 2; i++)
for (var j = -2; j <= 2; j++) {
    draw_set_color(c_gray);
    draw_text_transformed(x0 + i, y0 + j, txt, s, s, 0);
}

// 4) Texte principal coloré
draw_set_color(global._score_color);
draw_text_transformed(x0, y0, txt, s, s, 0);

// ====== AJOUT DU DANGER ======

// 1) Données & mapping
var lvl = clamp(global.danger_level, 0, 3);
var labels = array_create(4);
labels[0] = "CALME";
labels[1] = "ALERTE";
labels[2] = "DANGER";
labels[3] = "PANIQUE";

var cols = array_create(4);
cols[0] = make_color_rgb( 80,200,120); // vert
cols[1] = c_yellow;                    // jaune
cols[2] = make_color_rgb(255,128,  0); // orange
cols[3] = c_red;                       // rouge

var txt_r = "NIVEAU : " + labels[lvl];

// 2) Position haut-droite
var margin = 32;
var gx = display_get_gui_width()  - margin;
var gy = margin;

// 3) Style propre au danger (alignement à droite)
draw_set_halign(fa_right);
draw_set_valign(fa_top);

// 4) Effet de “pulse” bref à chaque changement de palier
if (!variable_global_exists("hud_danger_pulse")) global.hud_danger_pulse = 0;
global.hud_danger_pulse = max(0, global.hud_danger_pulse - 0.05);
var s2 = 1 + 0.25 * global.hud_danger_pulse;

// 5) Ombre/halo (gris)
for (var i = -2; i <= 2; i++)
for (var j = -2; j <= 2; j++) {
    draw_set_color(c_gray);
    draw_text_transformed(gx + i, gy + j, txt_r, s2, s2, 0);
}

// 6) Texte principal coloré selon le niveau
draw_set_color(cols[lvl]);
draw_text_transformed(gx, gy, txt_r, s2, s2, 0);