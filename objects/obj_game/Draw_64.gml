/// obj_game (ou HUD) : Draw GUI  — version safe

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

// 2) Scale du "juice" (borne 0..1 par sécurité)
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
