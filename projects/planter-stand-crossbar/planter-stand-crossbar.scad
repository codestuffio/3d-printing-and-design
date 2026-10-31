// Planter stand crossbar: the missing half of an older Veradek "H" pot
// stand. It half-laps under the existing half's center notch and is held
// by the original screw going up into the existing half's boss.
// All dimensions in mm.
//
// Frame: X runs along this crossbar, Y across its thickness, Z up.
// Z = 0 is the bottom edge of the existing half (its notched edge, which
// faces the floor in use). The pot sits on the top edges.

$fn = 96;

// Which part to render: "assembly", "fit_test", "arm_long", "arm_short",
// "foot", "upright"
part = "assembly";
with_uprights = true;   // assembly preview only: MVP = false, v2 = true

// ---- Existing half (measured with calipers) ----
existing_notch_len = 30;     // notch length along the existing beam; our hub drops into it
existing_hub_thick = 25.52;  // existing beam thickness at the notch, incl. grip ribs
existing_floor     = 10.51;  // material left above the existing notch
boss_d             = 9.91;
boss_h             = 13.5;   // ESTIMATE: boss length down from the existing notch floor - measure it
boss_hole_d        = 3.36;   // pilot for the original screw (M4 / #8 self-tapping)

// ---- Beam profile (copied from the existing half) ----
overall_width = 410;    // outside of pole to outside of pole
pole_d        = 23;
pole_len      = 270;
foot_h        = 48.26;  // floor to beam bottom edge
beam_thick    = 24.88;
beam_h_mid    = 24.61;  // beam height across the middle, where the pot sits
beam_h_end    = 31.90;  // beam height near the poles
slant_start   = 75;     // photo estimate: distance from center where the top starts rising
slant_end     = 95;     // ...and where it reaches beam_h_end

// ---- Half-lap joint ----
fit_clearance  = 0.3;   // per side, on the sliding faces of the lap
hub_thick      = existing_notch_len - 2 * fit_clearance;
hub_len        = 50;    // length of the thickened hub along this beam
under_extra    = 4;     // extra depth below Z = 0 so the screw has something to bite against
notch_w        = existing_hub_thick + 2 * fit_clearance;
notch_depth    = existing_floor + 0.2;
boss_pocket_d  = boss_d + 0.8;
boss_pocket_extra = 0.5;  // pocket goes this much deeper than the boss tip
screw_clear_d  = 4.5;

// ---- Leg sockets ----
// Feet and uprights are separate pegs that plug into a through-socket in
// each end collar, so the same arms serve the MVP (feet only) and v2.
socket_d   = 10.4;
pin_d      = 10.0;
pin_len    = 14;
pin_chamfer = 1;

// ---- Print split ----
// 410 mm won't fit a 245 bed, so the beam prints as two arms joined by a
// side-by-side lap splice with two screws. Long arm prints on the diagonal.
split_x          = 60;   // splice center, kept clear of the hub
splice_len       = 50;
splice_gap       = 0.2;  // end clearance where each half-lap butts the other arm
splice_screw_z   = 11;
splice_clear_d   = 4.5;
splice_pilot_d   = 3.4;
splice_pilot_len = 10.5;
splice_head_d    = 8.5;
splice_head_depth = 3;

fit_test_len = 90;

// ---- Derived ----
pole_x       = overall_width / 2 - pole_d / 2;
collar_h     = beam_h_end + under_extra;
existing_notch_top = beam_h_mid - existing_floor;  // Z of the existing notch floor
foot_len     = foot_h - under_extra;
upright_len  = pole_len - foot_h - beam_h_end;
splice_x0    = split_x - splice_len / 2;
splice_x1    = split_x + splice_len / 2;

echo(str("boss pocket floor under screw head: ",
         existing_notch_top - boss_h - boss_pocket_extra + under_extra, " mm"));
echo(str("long arm length: ", pole_x + pole_d / 2 + splice_x1, " mm"));
echo(str("short arm length: ", pole_x + pole_d / 2 - splice_x0, " mm"));
echo(str("foot length: ", foot_len, " mm, upright length: ", upright_len, " mm"));

module beam_profile() {
    polygon([
        [-pole_x, -under_extra], [pole_x, -under_extra],
        [pole_x, beam_h_end], [slant_end, beam_h_end],
        [slant_start, beam_h_mid], [-slant_start, beam_h_mid],
        [-slant_end, beam_h_end], [-pole_x, beam_h_end]
    ]);
}

module crossbar() {
    difference() {
        union() {
            rotate([90, 0, 0])
                linear_extrude(height = beam_thick, center = true)
                    beam_profile();
            translate([-hub_len / 2, -hub_thick / 2, -under_extra])
                cube([hub_len, hub_thick, beam_h_mid + under_extra]);
            for (sx = [-1, 1])
                translate([sx * pole_x, 0, -under_extra])
                    cylinder(h = collar_h, d = pole_d);
        }

        // half-lap notch: the existing half's floor drops into this
        translate([-notch_w / 2, -hub_thick, beam_h_mid - notch_depth])
            cube([notch_w, 2 * hub_thick, beam_h_end]);

        // pocket for the existing boss, then the screw clearance hole
        translate([0, 0, existing_notch_top - boss_h - boss_pocket_extra])
            cylinder(h = beam_h_end, d = boss_pocket_d);
        translate([0, 0, -under_extra - 1])
            cylinder(h = beam_h_end, d = screw_clear_d);

        // leg sockets with lead-in chamfers both ends
        for (sx = [-1, 1])
            translate([sx * pole_x, 0, -under_extra]) {
                translate([0, 0, -1])
                    cylinder(h = collar_h + 2, d = socket_d);
                translate([0, 0, -0.01])
                    cylinder(h = 0.8, d1 = socket_d + 1.6, d2 = socket_d);
                translate([0, 0, collar_h - 0.79])
                    cylinder(h = 0.8, d1 = socket_d, d2 = socket_d + 1.6);
            }
    }
}

// Everything left of the splice, plus the -Y half of the overlap.
module long_arm_region() {
    big = overall_width;
    translate([-big, -big / 2, -big / 2]) cube([big + splice_x0, big, big]);
    translate([splice_x0 - 0.01, -big / 2, -big / 2])
        cube([splice_len + 0.01 - splice_gap, big / 2, big]);
}

module short_arm_region() {
    big = overall_width;
    translate([splice_x1, -big / 2, -big / 2]) cube([big, big, big]);
    translate([splice_x0 + splice_gap, 0, -big / 2])
        cube([splice_len, big / 2, big]);
}

module splice_screws_long() {
    for (x = [split_x - splice_len / 4, split_x + splice_len / 4])
        translate([x, 0, splice_screw_z])
            rotate([90, 0, 0]) {
                cylinder(h = beam_thick, d = splice_clear_d);
                translate([0, 0, beam_thick / 2 - splice_head_depth])
                    cylinder(h = beam_thick, d = splice_head_d);
            }
}

module splice_screws_short() {
    for (x = [split_x - splice_len / 4, split_x + splice_len / 4])
        translate([x, -0.01, splice_screw_z])
            rotate([-90, 0, 0])
                cylinder(h = splice_pilot_len, d = splice_pilot_d);
}

module arm_long() {
    difference() {
        intersection() { crossbar(); long_arm_region(); }
        splice_screws_long();
    }
}

module arm_short() {
    difference() {
        intersection() { crossbar(); short_arm_region(); }
        splice_screws_short();
    }
}

module fit_test() {
    intersection() {
        crossbar();
        translate([-fit_test_len / 2, -hub_thick, -under_extra - 1])
            cube([fit_test_len, 2 * hub_thick, beam_h_end + under_extra + 2]);
    }
}

module pin() {
    cylinder(h = pin_len - pin_chamfer, d = pin_d);
    translate([0, 0, pin_len - pin_chamfer])
        cylinder(h = pin_chamfer, d1 = pin_d, d2 = pin_d - 2 * pin_chamfer);
}

// Printed pin-up; in use the pin goes up into the collar.
module foot() {
    cylinder(h = foot_len, d = pole_d);
    translate([0, 0, foot_len]) pin();
}

// Printed pin-up (top of the upright on the bed); in use the pin goes down.
module upright() {
    cylinder(h = upright_len, d = pole_d);
    translate([0, 0, upright_len]) pin();
}

module assembly() {
    color("dimgray") crossbar();
    for (sx = [-1, 1]) {
        translate([sx * pole_x, 0, -under_extra - foot_len])
            color("gray") foot();
        if (with_uprights)
            translate([sx * pole_x, 0, beam_h_end])
                translate([0, 0, upright_len]) rotate([180, 0, 0])
                    color("gray") upright();
    }
}

if (part == "assembly") assembly();
else if (part == "fit_test") fit_test();
else if (part == "arm_long") arm_long();
else if (part == "arm_short") arm_short();
else if (part == "foot") foot();
else if (part == "upright") upright();
