// Example dimensions only; measure the ruler, screws and nuts before printing.
// Units: mm. The ruler's readable scale faces -Y; its length runs along +Z.
part = "foot"; // foot, cursor, socket_coupon
ruler_width = 25;
ruler_thickness = 1;
ruler_length = 150;
socket_clearance = 0.30; // per side, before clamping
cursor_clearance = 0.35; // per side, before clamping
socket_engagement = 24;
minimum_ruler_engagement = 16; // actual insertion; example allows at most 8 mm lift
minimum_exposed_scale = 80;
base_width = 80;
base_depth = 70;
base_thickness = 5;
base_corner_radius = 6;
socket_wall = 5;
socket_corner_radius = 2;
ear_extension = 10;
split_gap = 1.0;
socket_screw_height = 17; // above base top
cursor_height = 12;
cursor_wall = 4.2;
cursor_edge_width = 2;
cursor_reference_offset = 1.2; // lower window edge above cursor bottom
cursor_top_beam = 1.8;
screw_hole_diameter = 3.4;
nut_across_flats = 5.8;
nut_depth = 2.7;
minimum_wall = 1.2;
coupon_margin = 2;
coupon_base_thickness = 3;
show_reference = false; // background ruler excluded from STL
epsilon = 0.02;
$fn = 48;

socket_slot_width = ruler_width + 2 * socket_clearance;
socket_slot_thickness = ruler_thickness + 2 * socket_clearance;
socket_depth = socket_slot_thickness + 2 * socket_wall;
socket_left = -socket_slot_width/2 - socket_wall;
socket_right = socket_slot_width/2 + socket_wall + ear_extension;
socket_screw_x = socket_slot_width/2 + socket_wall + ear_extension/2;
cursor_slot_width = ruler_width + 2 * cursor_clearance;
cursor_slot_thickness = ruler_thickness + 2 * cursor_clearance;
cursor_depth = cursor_slot_thickness + 2 * cursor_wall;
cursor_left = -cursor_slot_width/2 - cursor_wall;
cursor_right = cursor_slot_width/2 + cursor_wall + ear_extension;
cursor_screw_x = cursor_slot_width/2 + cursor_wall + ear_extension/2;
nut_radius = nut_across_flats / sqrt(3);
cursor_window_width = cursor_slot_width - 2 * cursor_edge_width;

assert(part == "foot" || part == "cursor" || part == "socket_coupon", "Unknown part selector");
assert(ruler_width > 0 && ruler_thickness > 0 && ruler_length > 0,
       "Ruler dimensions must be positive");
assert(socket_clearance >= 0 && cursor_clearance >= 0,
       "Fit clearances must be nonnegative");
assert(minimum_wall >= 1 && socket_wall >= nut_depth + minimum_wall &&
       cursor_wall >= nut_depth + minimum_wall, "Walls must retain nut pocket material");
assert(screw_hole_diameter > 0 && nut_depth > 0 &&
       nut_across_flats >= screw_hole_diameter + 2 * minimum_wall,
       "Nut capture must surround screw hole");
assert(ear_extension/2 >= nut_radius + minimum_wall,
       "Clamp ears must surround nut pocket");
assert(split_gap > 2 * max(socket_clearance, cursor_clearance) &&
       split_gap <= min(socket_slot_thickness, cursor_slot_thickness),
       "Split gap must join slots with bounded closure travel");
assert(socket_engagement >= 2 * (nut_radius + minimum_wall) &&
       socket_screw_height >= nut_radius + minimum_wall &&
       socket_engagement - socket_screw_height >= nut_radius + minimum_wall,
       "Socket engagement must retain screw margins");
assert(minimum_ruler_engagement <= socket_engagement &&
       minimum_ruler_engagement >= socket_engagement - socket_screw_height + nut_radius + minimum_wall,
       "Minimum insertion must cover clamping screw station");
assert(minimum_exposed_scale > 0 && ruler_length - socket_engagement >= minimum_exposed_scale,
       "Ruler must leave required exposed scale");
assert(base_thickness >= minimum_wall && base_width/2 >= max(-socket_left, socket_right) + minimum_wall &&
       base_depth/2 >= socket_depth/2 + minimum_wall,
       "Base must support socket with positive margins");
assert(base_corner_radius > 0 && base_corner_radius < min(base_width, base_depth)/2 &&
       socket_corner_radius > 0 && socket_corner_radius <= minimum_wall + 1,
       "Corner radii must preserve socket and base");
assert(cursor_height/2 >= nut_radius + minimum_wall &&
       cursor_reference_offset >= minimum_wall && cursor_top_beam >= minimum_wall &&
       cursor_height - cursor_reference_offset - cursor_top_beam >= 2 * minimum_wall &&
       cursor_edge_width >= minimum_wall && cursor_window_width >= 2 * minimum_wall,
       "Cursor window must preserve reference edge and screw margins");
assert(coupon_margin >= minimum_wall && coupon_base_thickness >= minimum_wall,
       "Coupon base must retain positive margins");

module rounded_block(width, depth, height, radius) {
    assert(width > 2*radius && depth > 2*radius,
           "Rounded block must retain positive inner profile");
    linear_extrude(height)
        offset(r=radius)
            square([width - 2*radius, depth - 2*radius], center=true);
}

// Both screws pull opposing jaws together outside the ruler envelope.
// Rear-face hex pocket is open for nut insertion/removal; front head stays exposed.
module clamp_hardware_voids(x, depth, z) {
    translate([x, 0, z]) rotate([90, 0, 0])
        cylinder(h=depth + 2*epsilon, d=screw_hole_diameter, center=true);
    translate([x, depth/2 - nut_depth/2 + epsilon/2, z]) rotate([90, 0, 0])
        cylinder(h=nut_depth + epsilon, r=nut_radius, $fn=6, center=true);
}

// A small transition bevel avoids collinear floor facets at the slot/split
// junction. It only relieves the off-ruler edge of the aperture.
module ruler_aperture(width, thickness, right, height) {
    translate([0, 0, -epsilon])
        linear_extrude(height + 2*epsilon)
            if (split_gap == thickness) {
                translate([-width/2, -thickness/2])
                    square([right + epsilon + width/2, thickness]);
            } else {
                polygon([
                    [-width/2, -thickness/2], [width/2, -thickness/2],
                    [width/2 + epsilon, -split_gap/2], [right + epsilon, -split_gap/2],
                    [right + epsilon, split_gap/2], [width/2 + epsilon, split_gap/2],
                    [width/2, thickness/2], [-width/2, thickness/2]
                ]);
            }
}

module socket() {
    difference() {
        translate([(socket_left + socket_right)/2, 0, 0])
            rounded_block(socket_right - socket_left, socket_depth,
                          socket_engagement, socket_corner_radius);
        ruler_aperture(socket_slot_width, socket_slot_thickness,
                       socket_right, socket_engagement);
        clamp_hardware_voids(socket_screw_x, socket_depth, socket_screw_height);
    }
}

module foot() {
    union() {
        rounded_block(base_width, base_depth, base_thickness, base_corner_radius);
        // Small overlap removes coplanar ambiguity while preserving slot floor.
        translate([0, 0, base_thickness - epsilon]) socket();
    }
}

module socket_coupon() {
    union() {
        translate([socket_left - coupon_margin, -socket_depth/2 - coupon_margin, 0])
            cube([socket_right - socket_left + 2*coupon_margin,
                  socket_depth + 2*coupon_margin, coupon_base_thickness]);
        translate([0, 0, coupon_base_thickness - epsilon]) socket();
    }
}

module cursor() {
    difference() {
        translate([cursor_left, -cursor_depth/2, 0])
            cube([cursor_right - cursor_left, cursor_depth, cursor_height]);
        // Through-slot: cursor is placed over a free ruler end, then slid to neutral.
        ruler_aperture(cursor_slot_width, cursor_slot_thickness,
                       cursor_right, cursor_height);
        // Open front window. Its lower edge is the sole reference edge.
        translate([-cursor_window_width/2, -cursor_depth/2 - epsilon, cursor_reference_offset])
            cube([cursor_window_width, cursor_wall + 2*epsilon,
                  cursor_height - cursor_reference_offset - cursor_top_beam]);
        clamp_hardware_voids(cursor_screw_x, cursor_depth, cursor_height/2);
    }
}

if (part == "foot") foot();
if (part == "cursor") cursor();
if (part == "socket_coupon") socket_coupon();

if (show_reference) {
    ruler_z = part == "cursor" ? -20 :
              part == "socket_coupon" ? coupon_base_thickness : base_thickness;
    %translate([-ruler_width/2, -ruler_thickness/2, ruler_z])
        cube([ruler_width, ruler_thickness, ruler_length]);
}
