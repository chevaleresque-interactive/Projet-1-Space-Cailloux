/// obj_menu_controller : Create

// Initialise le tableau dans CET objet (important avant les with)
btns = [];

// Pour chaque type de bouton, si au moins une instance existe, on l’ajoute au tableau
if (instance_exists(obj_demarrer)) {
    with (obj_demarrer) array_push(other.btns, id);
}

if (instance_exists(obj_quitter)) {
    with (obj_quitter) array_push(other.btns, id);
}

if (instance_exists(obj_recommencer)) {
    with (obj_recommencer) array_push(other.btns, id);
}

if (instance_exists(obj_quitter2)) {
    with (obj_quitter2) array_push(other.btns, id);
}

// Index du bouton sélectionné pour navigation manette/clavier
sel = 0;

// Deadzone du stick
deadzone = 0.25;

// Variable globale pour validation
global.ui_confirm_pressed = false;
