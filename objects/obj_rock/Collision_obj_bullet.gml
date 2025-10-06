instance_destroy(other);
effect_create_above(ef_explosion, x,y, 1, c_gray);
direction = random(360);
with (obj_bullet) shake = 6;
if sprite_index == 
spr_rock_big
{
	global.score += 1;
	sprite_index = 
	spr_rock_small
		instance_copy(true);
}
else if instance_number(obj_rock)<9
{
	sprite_index =
	spr_rock_big
	x = -100;
}
else
{
	instance_destroy();
}
