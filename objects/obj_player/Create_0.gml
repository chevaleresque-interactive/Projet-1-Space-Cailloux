vx = 0; 
vy = 0;
image_angle = 0;

accel       = 0.6;   // poussée avant
accel_back  = 0.3;   // marche arrière (flèche bas, optionnel)
turn_rate   = 5.5;   // °/step
drag        = 0.02;  // traînée générique
turn_brake  = 0.02;  // freinage additionnel quand on tourne fort
max_speed   = 13;

// Tir / état
cooldown    = 0;
deathsound  = false;
dead        = false;

// Bonus de tir
extra_shots     = 0;   // nb projectiles bonus
max_extra_shots = 25;  // plafond
muzzle_offset = 5;   