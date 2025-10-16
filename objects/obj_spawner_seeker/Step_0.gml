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
if (global.score >=90) {
	spawn_interval_sec =1.5;
}
if (global.score >=150) {
	spawn_interval_sec =0.7;
}