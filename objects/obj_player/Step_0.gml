/// obj_player : Step

// 1) Rotation
if (keyboard_check(vk_right)) { image_angle -= turn_rate; }
if (keyboard_check(vk_left))  { image_angle += turn_rate; }

// 2) Accélération
var ax = 0;
var ay = 0;
if (keyboard_check(vk_up)) {
    ax += lengthdir_x(accel, image_angle);
    ay += lengthdir_y(accel, image_angle);
}
if (keyboard_check(vk_down)) { // optionnel : marche arrière
    ax -= lengthdir_x(accel_back, image_angle);
    ay -= lengthdir_y(accel_back, image_angle);
}

// 3) Intégration + traînée
vx = (vx + ax) * (1 - drag);
vy = (vy + ay) * (1 - drag);

// 4) Frein de virage (réduit la glisse en virage serré)
var sp = point_distance(0, 0, vx, vy);
if (sp > 0.001) {
    var vdir  = point_direction(0, 0, vx, vy);
    var delta = angle_difference(vdir, image_angle);
    if (abs(delta) > 25) {
        var f = 1 - turn_brake; // ex. 0.85 si turn_brake = 0.15
        vx *= f;
        vy *= f;
    }
}

// 5) Limitation de la vitesse max
sp = point_distance(0, 0, vx, vy);
if (sp > max_speed) {
    var k = max_speed / sp;
    vx *= k; 
    vy *= k;
}

// 6) Application du mouvement
x += vx;
y += vy;

// 7) wrap écran
move_wrap(true, true, 60);

// 8) Cooldown de tir
if (cooldown > 0) { cooldown--; }

// 9) Tir à la souris
if (mouse_check_button_pressed(mb_left) && cooldown <= 0) {
    var muzzle_offset = 25;
    var bx = x + lengthdir_x(muzzle_offset, image_angle);
    var by = y + lengthdir_y(muzzle_offset, image_angle);

    var b = instance_create_layer(bx, by, "Instances", obj_bullet);
    b.direction = image_angle;
    b.speed     = 16;

    cooldown = 1;
    effect_create_above(ef_spark, bx, by, 0, c_orange);
}
