// Décrément du timer
if (spawn_timer > 0) {
    spawn_timer--;
} else {
    // Calcul du point de spawn
    var sx = x, sy = y;

    if (spawn_at_edges) {
        // Apparition aléatoire au bord de l’écran
        var edge = irandom(3);
        switch (edge) {
            case 0: sx = 0;             sy = irandom(room_height); break; // gauche
            case 1: sx = room_width;    sy = irandom(room_height); break; // droite
            case 2: sx = irandom(room_width); sy = 0;              break; // haut
            case 3: sx = irandom(room_width); sy = room_height;    break; // bas
        }
    }

    // Création de l’ennemi
    var e = instance_create_layer(sx, sy, spawn_layer, obj_seeker);

    e.target = target_player;

    // Réinitialisation du timer
    spawn_timer = round(room_speed * spawn_interval_sec);
}

if (global.score >=30) {
	spawn_interval_sec =2.5;
}
if (global.score >=50) {
	spawn_interval_sec =2;
}
if (global.score >=100) {
	spawn_interval_sec =1.5;
}
if (global.score >=200) {
	spawn_interval_sec =0.7;
}
if (global.score >=300) {
	spawn_interval_sec =0.4;
}
if (global.score >=600) {
	spawn_interval_sec =0.3;
}
if (global.score >=1000) {
	spawn_interval_sec =0.1;
}


global._spawn_interval = spawn_interval_sec;

// Niveaux (ex: 0=calme, 1=alerte, 2=danger, 3=mortel)
if      (spawn_interval_sec <= 0.70) global.danger_level = 3;
else if (spawn_interval_sec <= 1.50) global.danger_level = 2;
else if (spawn_interval_sec <= 2.50) global.danger_level = 1;
else                                 global.danger_level = 0;

// Petit pulse quand on franchit un palier (optionnel)
if (!variable_global_exists("_prev_danger_level")) global._prev_danger_level = -1;
if (global.danger_level != global._prev_danger_level) {
    global.hud_danger_pulse = 1.0; // sert à gonfler le texte brièvement
    global._prev_danger_level = global.danger_level;
}