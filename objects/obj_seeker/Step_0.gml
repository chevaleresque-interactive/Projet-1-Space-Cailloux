// Si la cible n’est pas encore définie, essayez de la trouver
if (target == noone) {
    if (instance_exists(obj_player)) {
        target = instance_find(obj_player, 0);
    }
}

// Poursuite du joueur
if (instance_exists(target)) {
    direction = point_direction(x, y, target.x, target.y);
    speed     = base_speed;
} else {
    speed = 0;
}

// Optionnel : détruire si sort de la room
if (x < -32 || x > room_width + 32 || y < -32 || y > room_height + 32) {
    instance_destroy();
}