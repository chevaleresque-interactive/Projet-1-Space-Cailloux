// Décrément du timer
if (spawn_timer > 0) {
    spawn_timer--;
} else {
    // ======= Sélection d'une position de spawn suffisamment loin du joueur =======
    var sx, sy;
    var ok = false;
    var tries = 0;

    repeat (max_spawn_attempts) {
        // Proposition de position
        if (spawn_at_edges) {
            var edge = irandom(3);
            switch (edge) {
                case 0: sx = 0;             sy = irandom(room_height); break; // gauche
                case 1: sx = room_width;    sy = irandom(room_height); break; // droite
                case 2: sx = irandom(room_width); sy = 0;              break; // haut
                case 3: sx = irandom(room_width); sy = room_height;    break; // bas
            }
        } else {
            sx = irandom(room_width);
            sy = irandom(room_height);
        }

        // Test de distance avec le joueur (si connu)
        ok = true;
        if (instance_exists(target_player)) {
            var d = point_distance(sx, sy, target_player.x, target_player.y);
            if (d < min_spawn_dist) ok = false;
        }

        if (ok) break;
        tries++;
    }

    // Création de l’ennemi si une position valide a été trouvée
    if (ok) {
        var e = instance_create_layer(sx, sy, spawn_layer, obj_seeker);
        e.target = target_player;
    }
    // Sinon, on “skippe” ce cycle de spawn pour éviter un pop trop proche

    // Réinitialisation du timer
    spawn_timer = max(1, round(room_speed * spawn_interval_sec));
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
	spawn_interval_sec =0.25;
}
if (global.score >=900) {
	spawn_interval_sec =0.1;
}
if (global.score >=1000) {
	spawn_interval_sec =0.05;
}
if (global.score >=1500) {
	spawn_interval_sec =0.01;
}
if (global.score >=4000) {
	spawn_interval_sec =0.002;
}


global._spawn_interval = spawn_interval_sec;

// Niveaux de danger
if      (spawn_interval_sec <= 0.002)global.danger_level = 9;
else if	(spawn_interval_sec <= 0.01) global.danger_level = 8;
else if	(spawn_interval_sec <= 0.05) global.danger_level = 7;
else if	(spawn_interval_sec <= 0.10) global.danger_level = 6;
else if	(spawn_interval_sec <= 0.25) global.danger_level = 5;
else if	(spawn_interval_sec <= 0.40) global.danger_level = 4;
else if	(spawn_interval_sec <= 0.70) global.danger_level = 3;
else if	(spawn_interval_sec <= 1.5)	 global.danger_level = 2;
else if (spawn_interval_sec <= 2)	 global.danger_level = 1;
else                                 global.danger_level = 0;

// Petit pulse quand on franchit un palier (optionnel)
if (!variable_global_exists("_prev_danger_level")) global._prev_danger_level = -1;
if (global.danger_level != global._prev_danger_level) {
    global.hud_danger_pulse = 1.5; // sert à gonfler le texte brièvement
    global._prev_danger_level = global.danger_level;
}