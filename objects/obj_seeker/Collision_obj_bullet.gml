base_hp -= 1;

if (variable_instance_exists(other, "shake")) other.shake = 6;
instance_destroy(other);

// Mort ou simple blessure ?
if (base_hp <= 0) {
    // Effets de mort
    effect_create_above(ef_explosion, x, y, 1, c_green);

    // Tirage unique : 10 % de chance de drop
    if (irandom(99) < 10) {
        instance_create_layer(x, y, "Instances", obj_bonus);
    }

    // Score à la mort uniquement
    global.score += 5;
    global._score_pulse = 1.7;
    global._score_color = make_color_rgb(45, 204, 78);

    instance_destroy(); // détruire l’ennemi quoi qu’il arrive
} else {
    // Touché mais vivant : feedback visuel
    effect_create_above(ef_flare, x, y, 1000, c_green);
}