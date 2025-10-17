spawn_interval_sec = 3.0;			// ← toutes les X secondes
spawn_layer       = "Instances";	// ← nom de votre layer d’instances
spawn_at_edges    = true;			// true = spawn sur les bords de l’écran
var new_danger = 0;					// difficulté croissante
min_spawn_dist      = 350; // distance minimale au joueur (en pixels)
max_spawn_attempts  = 20; 

// Référence du joueur (si vous avez plusieurs joueurs, vous pouvez affiner)
target_player = noone;
if (instance_exists(obj_player)) {
    target_player = instance_find(obj_player, 0);
}

// Timer interne
spawn_timer = round(room_speed * spawn_interval_sec * score);