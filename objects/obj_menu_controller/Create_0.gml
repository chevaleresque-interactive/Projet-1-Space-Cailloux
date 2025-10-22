// Tableau des boutons recensés dans la room
btns = [];

// index du bouton sélectionné (manette)
sel = 0;

// Deadzone et antirepeat pour le stick
deadzone  = 0.25;
prev_ly   = 0;
move_cool = 0;     // cooldown

// Flag global : les boutons valident quand my_focus && global.ui_confirm_pressed
global.ui_confirm_pressed = false;

// Première détection
scr__scan_buttons();

function scr__scan_buttons() {
    // Vide et rescanne les boutons existants
    btns = [];

    var NAMES = [
        "obj_reessayer",
        "obj_retourmenu",
        "obj_demarrer",
        "obj_quitter"
    ];

    // Récupère toutes les instances correspondant aux noms ci-dessus
    for (var i = 0; i < array_length(NAMES); i++) {
        var idx = asset_get_index(NAMES[i]);
        if (idx != -1 && instance_exists(idx)) {
            // pousse TOUTES les instances de ce type
            with (idx) array_push(other.btns, id);
        }
    }

    // Tri Y
    if (array_length(btns) > 1) {
        array_sort(btns, function(a, b) { return (a.y > b.y) - (a.y < b.y); });
    }

    // Focus initial
    if (array_length(btns) > 0) {
        sel = clamp(sel, 0, array_length(btns) - 1);
        for (var k = 0; k < array_length(btns); k++) {
            var b = btns[k];
            if (instance_exists(b)) with (b) my_focus = (k == other.sel);
        }
    }
}
