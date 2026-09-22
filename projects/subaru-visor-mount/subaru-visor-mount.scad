// Subaru visor mount, reconstructed from SubaruVisorMount.STL.
// Millimeters. Native CSG throughout; no imported mesh or external library.
// Default is a measured reconstruction, NOT a physically validated replacement.

/* [Mounting plate] */
mount_spacing = 34.798;
mount_y = 28.45728;
front_corner_y = 11.43;
plate_corner_radius = 11.43;
plate_thickness = 7.62;
// Large lower edge round in the supplied STL; zero gives a full flat footprint.
plate_bottom_round = 5.08;
screw_hole_diameter = 5.969;
counterbore_diameter = 11.2776;
counterbore_depth = 4.953;
// Small entry rounds are approximated by printable chamfers.
entry_chamfer = 1.27;

/* [Socket - measured fit] */
socket_tilt = 19;
// Axis intersection with the bottom face, measured from the front of the plate.
socket_axis_y = 12.285504;
socket_height = 17.2248; // Along the tilted axis, from its bottom-face intersection.
socket_outer_diameter = 15.24;
bore_diameter = 11.2776;
// Four relieved sectors leave shallow lands between them inside the bore.
bore_land_diameter = 10.4648;
bore_relief_width = 4.572;
bore_land_start = 4.5248;
retaining_hole_diameter = 9.2456;
retaining_lip_height = 2.032;
slot_width = 2.286;
// Distance along the socket axis to the CENTER of each rounded slot end.
slot_end_height = 12.1448;

/* [Reinforcement adjustments] */
// Added radially OUTWARD; 0 reproduces the original socket wall.
// Try 0.5 only after checking available clearance and snap-in force.
socket_extra_wall = 0;
rib_height = 3.048;
rib_width = 1.651;

/* [Display] */
// Section view is for inspection only. Keep false for printable exports.
section_view = false;
$fn = 120;

/* [Hidden] */
eps = 0.02;
round_steps = 24;
boss_radius = counterbore_diameter / 2;
// Measured outer rib sides meet beneath the socket at this Y coordinate.
rib_tip_y = 10.122;
socket_radius = socket_outer_diameter / 2 + socket_extra_wall;
lip_start = socket_height - retaining_lip_height;

assert(plate_bottom_round >= 0 && plate_bottom_round < plate_corner_radius);
assert(plate_bottom_round < plate_thickness);
assert(socket_extra_wall >= 0);
assert(retaining_hole_diameter > 0 && retaining_hole_diameter <= bore_land_diameter);
assert(bore_land_diameter <= bore_diameter && bore_diameter < 2 * socket_radius);
assert(bore_relief_width > 0 && bore_relief_width < bore_land_diameter);
assert(slot_width > 0 && slot_width < retaining_hole_diameter);
assert(slot_end_height > bore_land_start + slot_width / 2);
assert(slot_end_height < lip_start && lip_start < socket_height);
assert(counterbore_depth > entry_chamfer && counterbore_depth < plate_thickness);
assert(screw_hole_diameter < counterbore_diameter);
assert(rib_height > 0 && rib_width > 0 && rib_width < boss_radius);

module plate_outline(inset = 0) {
    hull() {
        for (side = [-1, 1])
            translate([side * mount_spacing / 2, mount_y])
                circle(r = plate_corner_radius - inset);
        translate([0, front_corner_y]) circle(r = plate_corner_radius - inset);
    }
}

// Piecewise circular lower edge profile, without an expensive 3D Minkowski sum.
function bottom_inset(z) = plate_bottom_round == 0 ? 0 :
    plate_bottom_round - sqrt(max(0, pow(plate_bottom_round, 2)
                                      - pow(plate_bottom_round - z, 2)));

module plate() {
    if (plate_bottom_round > 0)
        for (i = [0 : round_steps - 1]) {
            z0 = plate_bottom_round * i / round_steps;
            z1 = plate_bottom_round * (i + 1) / round_steps;
            hull() {
                translate([0, 0, z0])
                    linear_extrude(eps) plate_outline(bottom_inset(z0));
                translate([0, 0, z1])
                    linear_extrude(eps) plate_outline(bottom_inset(z1));
            }
        }
    translate([0, 0, plate_bottom_round])
        linear_extrude(plate_thickness - plate_bottom_round) plate_outline();
}

module rib_outline() {
    hull() {
        for (side = [-1, 1])
            translate([side * mount_spacing / 2, mount_y]) circle(r = boss_radius);
        translate([0, rib_tip_y + eps]) circle(r = eps);
    }
}

module ribs_and_bosses() {
    translate([0, 0, plate_thickness - eps])
        linear_extrude(rib_height + eps)
            union() {
                difference() {
                    rib_outline();
                    offset(delta = -rib_width) rib_outline();
                }
                for (side = [-1, 1])
                    translate([side * mount_spacing / 2, mount_y])
                        circle(r = boss_radius);
            }
}

module socket_frame() {
    translate([0, socket_axis_y, 0]) rotate([-socket_tilt, 0, 0]) children();
}

module socket_outer() {
    // Clip the tilted cylinder to the plate top; the plate supplies its lower body.
    intersection() {
        socket_frame() translate([0, 0, -plate_thickness])
            cylinder(h = socket_height + plate_thickness, r = socket_radius);
        translate([-100, -100, plate_thickness - eps]) cube([200, 200, 100]);
    }
}

module relieved_bore_profile() {
    union() {
        circle(d = bore_land_diameter);
        intersection() {
            circle(d = bore_diameter);
            union() {
                square([bore_relief_width, bore_diameter + 2], center = true);
                square([bore_diameter + 2, bore_relief_width], center = true);
            }
        }
    }
}

module socket_cuts() {
    socket_frame() {
        translate([0, 0, -20])
            cylinder(h = bore_land_start + 20 + eps, d = bore_diameter);
        translate([0, 0, bore_land_start])
            linear_extrude(lip_start - bore_land_start + eps) relieved_bore_profile();
        translate([0, 0, lip_start - eps])
            cylinder(h = retaining_lip_height + 2 * eps, d = retaining_hole_diameter);
        // Two crossing U-shaped cuts make four flexible fingers.
        for (angle = [0, 90]) rotate([0, 0, angle]) {
            translate([-slot_width / 2, -socket_radius - 1, slot_end_height])
                cube([slot_width, 2 * socket_radius + 2, socket_height]);
            translate([0, 0, slot_end_height]) rotate([90, 0, 0])
                cylinder(h = 2 * socket_radius + 2, d = slot_width, center = true);
        }
    }
    // Approximation of the original rounded bore exit at the flat underside.
    translate([0, socket_axis_y, -eps])
        scale([1, 1 / cos(socket_tilt), 1])
            cylinder(h = entry_chamfer + eps,
                     d1 = bore_diameter + 2 * entry_chamfer, d2 = bore_diameter);
}

module screw_cuts() {
    for (side = [-1, 1]) translate([side * mount_spacing / 2, mount_y, 0]) {
        translate([0, 0, -eps])
            cylinder(h = plate_thickness + rib_height + 2 * eps, d = screw_hole_diameter);
        translate([0, 0, -eps])
            cylinder(h = counterbore_depth + eps, d = counterbore_diameter);
        translate([0, 0, -eps])
            cylinder(h = entry_chamfer + eps,
                     d1 = counterbore_diameter + 2 * entry_chamfer, d2 = counterbore_diameter);
    }
}

module visor_mount() {
    difference() {
        union() {
            plate();
            ribs_and_bosses();
            socket_outer();
        }
        screw_cuts();
        socket_cuts();
    }
}

difference() {
    visor_mount();
    if (section_view) translate([-100, -100, -1]) cube([100, 200, 100]);
}
