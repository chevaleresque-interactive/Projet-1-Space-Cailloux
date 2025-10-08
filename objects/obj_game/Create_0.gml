/// obj_niveau : Créer
// ========= 1) Réinit des variables globales =========
global.score        = 0;          // score remis à zéro à chaque (re)démarrage de niveau
global._score_pulse = 0;          // juice du score
global._score_color = c_white;

// ========= 2) Nettoyage de tout ce qui pourrait traîner =========
with (obj_player)  instance_destroy();
with (obj_bullet)  instance_destroy();
with (obj_rock)    instance_destroy();

// ========= 3) (Re)spawn du joueur =========
var px = room_width  * 0.5;
var py = room_height * 0.5;
var p  = instance_create_layer(px, py, "Instances", obj_player);

// (Si votre joueur n'est PAS piloté par la physique, on peut lui donner un angle neutre)
if (instance_exists(p)) {
    p.image_angle = 0;
    if (variable_instance_exists(p, "vx")) p.vx = 0;
    if (variable_instance_exists(p, "vy")) p.vy = 0;
}

// ========= 4) Spawn initial des rochers =========
var N = 8; // nombre de gros rochers au départ (adaptez)
for (var i = 0; i < N; i++) {
    // position initiale
    var rx = irandom_range(96, room_width  - 96);
    var ry = irandom_range(96, room_height - 96);

    // évite le spawn trop proche du joueur
    if (point_distance(rx, ry, px, py) < 220) {
        var ang = irandom(359);
        rx = px + lengthdir_x(220, ang);
        ry = py + lengthdir_y(220, ang);
    }

    var r = instance_create_layer(rx, ry, "Instances", obj_rock);
    r.image_angle = irandom(359);
    r.direction   = irandom(359);
    r.speed       = random_range(1.2, 2.4); // vitesse de départ aléatoire
}

// ========= 5) Qualité de vie =========
window_set_caption("Space Cailloux");   // titre de fenêtre (optionnel)
if (gamepad_is_connected(0)) gamepad_set_axis_deadzone(0, 0.25); // deadzone stick

// NOTE : laissez le Draw GUI du score là où vous l'avez déjà (ex. obj_game ou autre).
