// --- Paramètres de mise en forme ---
var x0 = 32;
var y0 = 32;
var text = "SCORE : " + string(global.score);

// --- Police par défaut + style épais simulé ---
draw_set_font(-1); // police système par défaut
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// --- Couleurs principales ---
var text_col = c_white;
var bg_col   = c_white;
var txt_shadow = c_black;

// --- Calcul des dimensions ---
var tw = string_width(text) + 40;
var th = string_height(text) + 20;

// --- Effet de texte épais (simule une police bold) ---
draw_set_color(txt_shadow);
for (var i = -2; i <= 2; i++) {
    for (var j = -2; j <= 2; j++) {
        draw_text(x0 + i, y0 + j, text);
    }
}

// --- Texte principal (blanc pur par-dessus) ---
draw_set_color(text_col);
draw_text(x0, y0, text);
