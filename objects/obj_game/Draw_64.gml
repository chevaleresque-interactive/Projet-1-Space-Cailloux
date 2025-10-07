// Affichage du score avec "juice"
var x0 = 32, y0 = 32;
var txt = "SCORE : " + string(global.score);

// Scale (1.0 → 1.35 au pic)
var s = 1 + 0.35 * global._score_pulse;

// Fond blanc arrondi
//var tw = string_width(txt)  * s + 40;
//var th = string_height(txt) * s + 20;
//draw_set_color(c_white);
//draw_roundrect(x0 - 20, y0 - 10, x0 - 20 + tw, y0 - 10 + th, false);

// Halo sombre pour lisibilité
for (var i=-2; i<=2; i++) for (var j=-2; j<=2; j++) {
    draw_set_color(c_gray);
    draw_text_transformed(x0 + i, y0 + j, txt, s, s, 0);
}

// Texte principal coloré
draw_set_color(global._score_color);
draw_text_transformed(x0, y0, txt, s, s, 0);
