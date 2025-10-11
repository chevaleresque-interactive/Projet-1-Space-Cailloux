/// obj_gameover : Draw GUI
var gw = display_get_gui_width();
var gh = display_get_gui_height();


// voile sombre
//draw_set_alpha(0.55);
//draw_set_color(c_black);
//draw_rectangle(0, 0, gw, gh, false);
//draw_set_alpha(1);

// cherche un bouton de référence par nom (réessayer > démarrer)
function _find_first(_nm) {
    var idx = asset_get_index(_nm);
    return (idx != -1 && instance_exists(idx)) ? instance_find(idx, 0) : noone;
}
var ref = _find_first("obj_reessayer"); if (!instance_exists(ref)) ref = _find_first("obj_demarrer");

var y_buttons_top = gh*0.5 - 60;
if (instance_exists(ref)) y_buttons_top = ref.y;

var y_title = y_buttons_top - 110;
var y_score = y_buttons_top - 70;

draw_set_halign(fa_center); draw_set_valign(fa_middle);
if (!is_undefined(Font1)) draw_set_font(Font1);

// titre
var title = "VOUS ETES MORT";
for (var i=-2;i<=2;i++) for (var j=-2;j<=2;j++){ draw_set_color(c_black); draw_text(gw*0.5+i, y_title+j, title); }
draw_set_color(c_white); draw_text(gw*0.5, y_title, title);

// score
var txt = "SCORE : " + string(global.score);
for (var i=-2;i<=2;i++) for (var j=-2;j<=2;j++){ draw_set_color(c_black); draw_text(gw*0.5+i, y_score+j, txt); }
draw_set_color(c_white); draw_text(gw*0.5, y_score, txt);
