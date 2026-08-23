// Garden stake cap: slides over a stake and gives you tie-off points
// for plant support string. All dimensions in mm.

$fn = 96;

// ---- Stake fit ----
stake_diameter    = 11.43; // measured stake OD (~0.45 in) - re-measure yours before printing
fit_clearance     = 0.6;   // added to stake diameter for a slide-on friction fit; loosen/tighten as needed
socket_wall       = 2.5;   // wall thickness of the sleeve gripping the stake
socket_depth      = 22;    // how far the sleeve slides down over the stake
chamfer_height    = 1.5;   // lead-in chamfer at the sleeve's open end, eases insertion

// ---- Cap disc ----
disc_diameter     = 40;
disc_thickness    = 4;

// ---- Tie holes ----
tie_hole_diameter = 3.5;   // sized for typical garden twine/string
tie_hole_count    = 8;
tie_hole_inset    = 5;     // distance from disc edge to hole center

// ---- Air vent ----
// The stake socket is a blind hole; without a vent, trapped air can
// keep the cap from seating fully when pressed on.
vent_hole_diameter = 1.5;

module garden_stake_cap() {
    socket_id = stake_diameter + fit_clearance;
    socket_od = socket_id + 2 * socket_wall;

    difference() {
        union() {
            // sleeve that grips the stake
            cylinder(h = socket_depth, d = socket_od);
            // top disc / cap
            translate([0, 0, socket_depth])
                cylinder(h = disc_thickness, d = disc_diameter);
        }

        // blind bore for the stake (stops short of the top of the disc)
        translate([0, 0, -0.1])
            cylinder(h = socket_depth + 0.1, d = socket_id);

        // lead-in chamfer at the open end
        translate([0, 0, -0.1])
            cylinder(h = chamfer_height + 0.1, d1 = socket_id + 2 * chamfer_height, d2 = socket_id);

        // vent hole up through the disc so trapped air can escape
        translate([0, 0, -0.1])
            cylinder(h = socket_depth + disc_thickness + 0.2, d = vent_hole_diameter);

        // tie-off holes around the disc rim
        for (i = [0 : tie_hole_count - 1])
            rotate([0, 0, i * 360 / tie_hole_count])
                translate([disc_diameter / 2 - tie_hole_inset, 0, socket_depth - 0.1])
                    cylinder(h = disc_thickness + 0.2, d = tie_hole_diameter);
    }
}

garden_stake_cap();
