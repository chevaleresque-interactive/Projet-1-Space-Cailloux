//son d'ambiance

// Tableau des boutons recensés dans la room (instances)
btns = [];

// index du bouton sélectionné (pour la manette)
sel = 0;

// Deadzone et antirepeat pour le stick
deadzone  = 0.25;
prev_ly   = 0;
move_cool = 0;     // frames avant d'autoriser un nouveau déplacement

// Flag global : les boutons valident quand my_focus && global.ui_confirm_pressed
global.ui_confirm_pressed = false;

// Première détection (au cas où les boutons sont déjà posés)
scr__scan_buttons();

function scr__scan_buttons() {
    // Vide et rescannne les boutons existants, avec compatibilité de noms
    btns = [];

    var NAMES = [
        "obj_reessayer",   // votre "réessayer"
        "obj_retourmenu",  // votre "retour menu"
        "obj_demarrer",
        "obj_quitter"
    ];

    // Récupère toutes les instances correspondant aux noms ci-dessus
    for (var i = 0; i < array_length(NAMES); i++) {
        var idx = asset_get_index(NAMES[i]);
        if (idx != -1 && instance_exists(idx)) {
            // pousse TOUTES les instances de ce type (au cas où)
            with (idx) array_push(other.btns, id);
        }
    }

    // Tri par Y (du haut vers le bas) pour que ↑/↓ soit logique
    if (array_length(btns) > 1) {
        array_sort(btns, function(a, b) { return (a.y > b.y) - (a.y < b.y); });
    }

    // Focus initial (si rien n'était sélectionné)
    if (array_length(btns) > 0) {
        sel = clamp(sel, 0, array_length(btns) - 1);
        for (var k = 0; k < array_length(btns); k++) {
            var b = btns[k];
            if (instance_exists(b)) with (b) my_focus = (k == other.sel);
        }
    }
}
