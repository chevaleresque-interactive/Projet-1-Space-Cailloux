/// obj_player : Step  — clavier + manette (générique)

// --- Paramètre local de cadence (tir toutes les 0.20 s) ---
var FIRE_INTERVAL = max(1, round(room_speed * 0.20));

// Détection d'un pad (premier connecté)
var gp = -1;
for (var p = 0; p < 4; p++) if (gamepad_is_connected(p)) { gp = p; break; }
var DEAD = 0.25;

// 1) Entrées
// Rotation (clavier)
var turn = 0;
if (keyboard_check(vk_right)) turn += -1;
if (keyboard_check(vk_left))  turn +=  1;

// Manette (stick gauche horizontal)
if (gp != -1) {
    var lx = gamepad_axis_value(gp, gp_axislh);
    if (abs(lx) > DEAD) turn += -lx; // signe opposé pour respecter votre convention
}
if (turn != 0) image_angle += turn_rate * clamp(turn, -1, 1);

// Poussée avant / arrière
var thrust = keyboard_check(vk_up)   ? 1 : 0;
var back   = keyboard_check(vk_down) ? 1 : 0;

if (gp != -1) {
    // bouton A
    if (gamepad_button_check(gp, gp_face1)) thrust = max(thrust, 1);
    // stick vertical (haut = -1)
    var ly = gamepad_axis_value(gp, gp_axislv);
    if (-ly > DEAD) thrust = max(thrust, clamp(-ly, 0, 1));
    if ( ly > DEAD) back   = max(back,   clamp( ly, 0, 1));
}

// Tir (souris + manette RB) — MAINTIEN
var fire_held = mouse_check_button(mb_left);
if (gp != -1) {
    fire_held = fire_held || gamepad_button_check(gp, gp_shoulderr); // RB
}

// 2) Accélération
var ax = 0, ay = 0;
if (thrust > 0) {
    ax += lengthdir_x(accel * thrust, image_angle);
    ay += lengthdir_y(accel * thrust, image_angle);
}
if (back > 0) {
    ax -= lengthdir_x(accel_back * back, image_angle);
    ay -= lengthdir_y(accel_back * back, image_angle);
}

// 3) Intégration + traînée
vx = (vx + ax) * (1 - drag);
vy = (vy + ay) * (1 - drag);

// 4) Frein de virage
var sp = point_distance(0, 0, vx, vy);
if (sp > 0.001) {
    var vdir  = point_direction(0, 0, vx, vy);
    var delta = angle_difference(vdir, image_angle);
    if (abs(delta) > 25) {
        var f = 1 - turn_brake;
        vx *= f; vy *= f;
    }
}

// 5) Limitation de la vitesse
sp = point_distance(0, 0, vx, vy);
if (sp > max_speed) {
    var k = max_speed / sp;
    vx *= k; vy *= k;
}

// 6) Application du mouvement
x += vx; y += vy;

// 7) wrap écran
move_wrap(true, true, 60);

// 8) Cooldown de tir
if (cooldown > 0) cooldown--;

// 9) Tir (maintenu, cadencé)
if (fire_held && cooldown <= 0) {
    audio_play_sound(Son_shoot, 10, false);

    var muzzle_offset = 25;
    var bx = x + lengthdir_x(muzzle_offset, image_angle);
    var by = y + lengthdir_y(muzzle_offset, image_angle);

    var b = instance_create_layer(bx, by, "Instances", obj_bullet);
    b.direction = image_angle;
    b.speed     = 16;

    cooldown = FIRE_INTERVAL; // cadence contrôlée par FIRE_INTERVAL
    effect_create_above(ef_spark, bx, by, 0, c_orange);
}
