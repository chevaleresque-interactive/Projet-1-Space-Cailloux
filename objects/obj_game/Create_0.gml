// ========= 1) Réinit des variables globales =========
global.score        = 0;          // score remis à zéro à chaque (re)démarrage de niveau
global._score_pulse = 0;          // juice du score
global._score_color = c_white;
global.danger = 0; //niveau affiché de danger
extra_shots =0;

// ========= 2) Nettoyage de tout ce qui pourrait traîner =========
with (obj_player)	instance_destroy();
with (obj_bullet)	instance_destroy();
with (obj_rock)		instance_destroy();
with (obj_seeker)	instance_destroy();

// ========= 3) (Re)spawn du joueur =========
var px = room_width  * 0.5;
var py = room_height * 0.5;
var p  = instance_create_layer(px, py, "Instances", obj_player);

// ========= 4) Spawn initial des rochers =========
var N = 8; // nombre de gros rochers au départ
for (var i = 0; i < N; i++) {
    // position initiale
    var rx = irandom_range(96, room_width  - 96);
    var ry = irandom_range(96, room_height - 96);

    // évite le spawn trop proche du joueur
    if (point_distance(rx, ry, px, py) < 250) {
        var ang = irandom(359);
        rx = px + lengthdir_x(250, ang);
        ry = py + lengthdir_y(250, ang);
    }

    var r = instance_create_layer(rx, ry, "Instances", obj_rock);
    r.image_angle = irandom(359);
    r.direction   = irandom(359);
    r.speed       = random_range(1.2, 2.4); // vitesse de départ aléatoire
}

// ========= 5) Qualité de vie =========
window_set_caption("Space Cailloux");
if (gamepad_is_connected(0)) gamepad_set_axis_deadzone(0, 0.25); // deadzone