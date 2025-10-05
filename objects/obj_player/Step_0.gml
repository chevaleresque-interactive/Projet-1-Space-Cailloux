if keyboard_check(vk_up)
{
	motion_add(image_angle, 0.15);
}

if keyboard_check(vk_down)
{
	speed*=0.95;
}


if keyboard_check(vk_right)
{
	image_angle -=6;
}

if keyboard_check(vk_left)
{
	image_angle +=6;
}

move_wrap(true, true, 60)

if (cooldown > 0) {
    cooldown -= 1;
}

if (mouse_check_button(mb_left) && cooldown <= 0) {
    instance_create_layer(x, y-25, "Instances", obj_bullet);
    cooldown = room_speed / 8;
	effect_create_above(ef_spark, x, y, 0, c_orange);
}