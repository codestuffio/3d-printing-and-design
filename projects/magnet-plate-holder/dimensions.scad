// Shared dimensions for the magnetic holder and TPU protective sleeve.
// All dimensions are in millimeters unless the name ends in _in.

inch = 25.4;

// ---- Steel plate inputs (inches) ----
steel_plate_width_in = 4;
steel_plate_thickness_in = 3 / 16;
plate_width = steel_plate_width_in * inch;
plate_thickness = steel_plate_thickness_in * inch;
plate_clearance_xy = 0.25;
plate_clearance_z = 0.20;

// ---- Magnets (nominal 1/2 in diameter x 1/4 in thick) ----
magnet_diameter = 1 / 2 * inch;
magnet_thickness = 1 / 4 * inch;
magnet_hole_fit = -0.10;  // negative = press fit; increase if holes print tight
magnet_count = 6;
magnet_pattern_radius = 37;

// ---- Holder structure ----
rim_width = 2.20;
corner_radius = 5;
backing_plate_thickness = 1 / 4 * inch;
epsilon = 0.05;

plate_pocket_width = plate_width + plate_clearance_xy;
plate_pocket_depth = plate_thickness + plate_clearance_z;
magnet_pocket_diameter = magnet_diameter + magnet_hole_fit;
holder_width = plate_pocket_width + 2 * rim_width;
holder_height = plate_pocket_depth + backing_plate_thickness;
