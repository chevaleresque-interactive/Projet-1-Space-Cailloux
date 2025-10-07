/// obj_menu_controller : Créer

// 1) Tableau des boutons présents dans la room (dans CET objet)
btns = [];

// 2) Collecte des instances existantes (menu ou game over)
//    Utiliser other.btns pour pousser dans le tableau du contrôleur.
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

// 3) Sélection & entrée manette
sel = 0;
deadzone = 0.25;

// mémoire pour “edge” du stick vertical (évite l’auto-repeat trop rapide)
prev_ly = 0;

// Flag de validation lu/consommé par les boutons (réinitialisé à chaque Step)
global.ui_confirm_pressed = false;
