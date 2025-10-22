// --- 0) Paramètres locaux
var FIRE_INTERVAL = max(1, round(room_speed * 0.20));
var DEAD          = 0.25;

// --- 1) Détection de périphérique / plateforme
var gp       = -1;
var using_pad = false;
for (var p = 0; p < 4; p++) if (gamepad_is_connected(p)) { gp = p; using_pad = true; break; }
var is_mobile = (os_type == os_android) || (os_type == os_ios);

// --- 2) Entrées (fusion clavier/manette/tactile) ---

// 2a) Zones/mesures GUI pour le tactile
var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Accumulateurs d’entrée tactile
var turn_touch    = 0;
var thrust_touch  = 0;
var back_touch    = 0;
var fire_touch    = false;

// Lecture tactile si mobile et pas de manette
if (is_mobile && !using_pad) {
    // On lit quelques doigts (0..4). Ajustez si vous ciblez plus.
    for (var i = 0; i < 5; i++) {
        if (device_mouse_check_button(i, mb_left)) {
            var tx = device_mouse_x_to_gui(i);
            var ty = device_mouse_y_to_gui(i);

            if (tx < gw * 0.5) {
                // Stick virtuel : centre simple (quart inférieur gauche)
                var cx = gw * 0.25;
                var cy = gh * 0.75;
                var dx = tx - cx;
                var dy = ty - cy;

                var maxlen = gw * 0.20;                // rayon du stick
                if (maxlen > 1) {
                    var nx = clamp(dx / maxlen, -1, 1); // -1..1
                    var ny = clamp(dy / maxlen, -1, 1);

                    // Tourner = axe X (votre convention : signe opposé)
                    turn_touch += clamp(-nx, -1, 1);

                    // Avancer / Reculer depuis axe Y (haut = pousser)
                    var up = clamp(-ny, 0, 1);
                    var dn = clamp( ny, 0, 1);
                    thrust_touch = max(thrust_touch, up);
                    back_touch   = max(back_touch,   dn);
                }
            } else {
                // Moitié droite : tir maintenu
                fire_touch = true;
            }
        }
    }
}

// 2b) Rotation (clavier + manette + tactile)
var turn = 0;
// clavier
if (keyboard_check(vk_right)) turn += -1;
if (keyboard_check(vk_left))  turn +=  1;
// manette (stick gauche horizontal)
if (using_pad) {
    var lx = gamepad_axis_value(gp, gp_axislh);
    if (abs(lx) > DEAD) turn += -lx; // signe opposé pour votre convention
}
// tactile (accumulation)
turn += turn_touch;

if (turn != 0) image_angle += turn_rate * clamp(turn, -1, 1);

// 2c) Poussée avant / arrière (clavier + manette + tactile)
var thrust = keyboard_check(vk_up)   ? 1 : 0;
var back   = keyboard_check(vk_down) ? 1 : 0;

if (using_pad) {
    // bouton A pour pousser
    if (gamepad_button_check(gp, gp_face1)) thrust = max(thrust, 1);
    // stick vertical (haut = -1)
    var ly = gamepad_axis_value(gp, gp_axislv);
    if (-ly > DEAD) thrust = max(thrust, clamp(-ly, 0, 1));
    if ( ly > DEAD) back   = max(back,   clamp( ly, 0, 1));
}

// tactile
thrust = max(thrust, thrust_touch);
back   = max(back,   back_touch);

// 2d) Tir (souris + manette + tactile)
var fire_held = mouse_check_button(mb_left); // sur mobile, un doigt = clic gauche
if (using_pad) {
    fire_held = fire_held
        || gamepad_button_check(gp, gp_shoulderr)
        || gamepad_button_check(gp, gp_shoulderrb);
}
fire_held = fire_held || fire_touch;

// --- 3) Accélération ---
var ax = 0, ay = 0;
if (thrust > 0) {
    ax += lengthdir_x(accel * thrust, image_angle);
    ay += lengthdir_y(accel * thrust, image_angle);
}
if (back > 0) {
    ax -= lengthdir_x(accel_back * back, image_angle);
    ay -= lengthdir_y(accel_back * back, image_angle);
}

// --- 4) Intégration + traînée ---
vx = (vx + ax) * (1 - drag);
vy = (vy + ay) * (1 - drag);

// --- 5) Frein de virage ---
var sp = point_distance(0, 0, vx, vy);
if (sp > 0.001) {
    var vdir  = point_direction(0, 0, vx, vy);
    var delta = angle_difference(vdir, image_angle);
    if (abs(delta) > 25) {
        var f = 1 - turn_brake;
        vx *= f; vy *= f;
    }
}

// --- 6) Limitation de la vitesse ---
sp = point_distance(0, 0, vx, vy);
if (sp > max_speed) {
    var k = max_speed / sp;
    vx *= k; vy *= k;
}

// --- 7) Application du mouvement ---
x += vx; y += vy;

// --- 8) Wrap écran ---
move_wrap(true, true, 60);

// --- 9) Cooldown de tir ---
if (cooldown > 0) cooldown--;

// --- 10) Tir (maintenu) + bonus ---
if (fire_held && cooldown <= 0) {
    audio_play_sound(Son_shoot, 10, false);

    var muzzle_offset = 25;

    // Tir principal (axe du perso)
    var bx = x + lengthdir_x(muzzle_offset, image_angle);
    var by = y + lengthdir_y(muzzle_offset, image_angle);

    var b = instance_create_layer(bx, by, "Instances", obj_bullet);
    b.direction = image_angle;
    b.speed     = 25;

    // Tirs bonus (aléatoires dans un cône)
    var n = clamp(extra_shots, 0, max_extra_shots);
    for (var i = 0; i < n; i++) {
        var spread = 25;
        var ang = image_angle + irandom_range(-spread, spread);
        var bx2 = x + lengthdir_x(muzzle_offset, ang);
        var by2 = y + lengthdir_y(muzzle_offset, ang);

        var b2 = instance_create_layer(bx2, by2, "Instances", obj_bullet);
        b2.direction = ang;
        b2.speed     = 25;
    }

    cooldown = FIRE_INTERVAL;
    effect_create_above(ef_spark, bx, by, 0, c_orange);
}
