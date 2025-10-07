speed		= 1;
direction	= random(360);
image_angle	= random(360);

// --- SCORE ---
global.score		= 0; // mot-clef global = rend la var accessible depuis tous les objets du jeu
if (!variable_global_exists("score")) global.score = 0;

// --- Juice du score ---
if (!variable_global_exists("_score_pulse")) global._score_pulse = 0;  // 0..1
if (!variable_global_exists("_score_color")) global._score_color = c_white;