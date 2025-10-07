// --- Amortissement du juice ---
global._score_pulse = max(0, global._score_pulse - 0.12);
global._score_color = merge_color(global._score_color, c_white, 0.25);
