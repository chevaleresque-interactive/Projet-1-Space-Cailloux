base_hp -= 1;

if (variable_instance_exists(other, "shake")) other.shake = 6;
instance_destroy(other);

// 4) Mort ou simple blessure ?
if (base_hp <= 0) {
    // Effets de mort
    effect_create_above(ef_explosion, x, y, 1, c_green);

    // Score à la mort uniquement
    global.score += 5;
    global._score_pulse = 1.7;
    global._score_color = make_color_rgb(45, 204, 78);

    instance_destroy(); // détruire l’ennemi
} else {
    // Touché mais vivant : petit feedback visuel
    effect_create_above(ef_flare, x, y, 0, c_green);

    // (Optionnel) légère réaction : variation de direction
    direction = random(360);
}