if (dead) exit;  //empêche les collisions suivantes d’empiler la mort
dead = true;

// Effet visuel de mort
effect_create_above(ef_firework, x, y, 1, c_red);

// On empêche le joueur de bouger, mais on ne le détruit pas tout de suite
speed = 0;
visible = false; //
alarm[0] = room_speed * 0.5; // délai = 0.5 seconde

if (!deathsound) {
    audio_play_sound(son_death, 10, false);
    deathsound = true;
}

instance_destroy(other);