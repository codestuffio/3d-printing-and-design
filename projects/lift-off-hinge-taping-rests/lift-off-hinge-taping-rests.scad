// One loose fixed-profile rest; print TWO identical rests separately.
// Millimeters. These elevations and contact sizes are UNMEASURED EXAMPLES.
// x crosses the seam, y follows it, z=0 is the flat bench/print-bed plane.
part = "rest"; // "rest" or "contact_coupon"

base_width = 76;
base_length = 50;
base_thickness = 3;
minimum_floor_thickness = 2; // Geometric floor guard, not a strength rating.
base_edge_radius = 2;
left_land_width = 20;
right_land_width = 18;
left_land_length = 44;
right_land_length = 40;
left_land_elevation = 12;  // Absolute upper contact plane above the bench.
right_land_elevation = 10;
seam_relief_width = 22;   // Clear distance between the two land envelopes.
contact_edge_radius = 1;
placement_margin = 3;    // Minimum base margin outside each land envelope.
tape_access_width = 16;  // Declared centered access envelope, not hinge gap.
tape_access_clearance = 2; // Lateral clearance on each side of that envelope.
access_height = 5;       // Declared clear height above floor to lower land top.
coupon_length = 12;      // Short y slice through exactly the same rest source.

// Fixed modest tessellation preserves cardinal extrema and broad flat tops.
$fn = 24;

assert(part == "rest" || part == "contact_coupon",
       "Part must be rest or contact_coupon.");
assert(base_width > 0 && base_length > 0 && base_thickness > 0,
       "Base dimensions must be positive.");
assert(minimum_floor_thickness > 0 && base_thickness >= minimum_floor_thickness,
       "Base must retain the positive minimum floor thickness.");
assert(left_land_width > 0 && right_land_width > 0 &&
       left_land_length > 0 && right_land_length > 0,
       "Land dimensions must be positive.");
assert(contact_edge_radius > 0 && base_edge_radius > 0,
       "Edge radii must be positive.");
assert(2 * base_edge_radius < min(base_width, base_length),
       "Base rounding must leave straight base edges.");
assert(2 * contact_edge_radius < min(left_land_width, right_land_width,
                                   left_land_length, right_land_length),
       "Contact rounding must leave broad flat land tops.");
assert(base_thickness > contact_edge_radius,
       "Contact rounding must join each land above the base underside.");
assert(left_land_elevation >= base_thickness + 2 * contact_edge_radius &&
       right_land_elevation >= base_thickness + 2 * contact_edge_radius,
       "Land elevations must retain rounded support above the floor.");
assert(seam_relief_width > 0 && placement_margin > 0,
       "Seam relief and placement margin must be positive.");
assert(placement_margin >= base_edge_radius,
       "Placement margin must cover the rounded base corners.");
assert(seam_relief_width / 2 + left_land_width + placement_margin <= base_width / 2 &&
       seam_relief_width / 2 + right_land_width + placement_margin <= base_width / 2 &&
       max(left_land_length, right_land_length) + 2 * placement_margin <= base_length,
       "Each land must fit inside the base placement margins.");
assert(tape_access_width > 0 && tape_access_clearance > 0 && access_height > 0,
       "Tape access dimensions and clearance must be positive.");
assert(seam_relief_width >= tape_access_width + 2 * tape_access_clearance,
       "Seam relief must clear the centered tape access envelope.");
assert(min(left_land_elevation, right_land_elevation) - base_thickness >= access_height,
       "Land elevations must clear the declared access height above the floor.");
assert(coupon_length > 2 * contact_edge_radius &&
       coupon_length < min(left_land_length, right_land_length) - 2 * contact_edge_radius,
       "Coupon length must retain a short central contact cross-section.");

module rounded_base() {
    linear_extrude(height = base_thickness)
        rounded_rectangle(base_width, base_length, base_edge_radius);
}

module rounded_rectangle(width, height, radius) {
    offset(r = radius)
        square([width - 2 * radius, height - 2 * radius], center = true);
}

// Three rounded 2D extrusions soften all contact edges, including y ends.
// Their planar tops retain the exact elevation instead of a sphere's faceted
// polar approximation. The lower edge overlaps the base by one radius.
module bearing_land(x_min, width, length, elevation) {
    r = contact_edge_radius;
    bottom = base_thickness - r;
    height = elevation - bottom;
    translate([x_min + width / 2, 0, bottom + height / 2])
        intersection() {
            linear_extrude(height = height, center = true)
                rounded_rectangle(width, length, r);
            rotate([90, 0, 0])
                linear_extrude(height = length, center = true)
                    rounded_rectangle(width, height, r);
            rotate([90, 0, 90])
                linear_extrude(height = width, center = true)
                    rounded_rectangle(length, height, r);
        }
}

module rest() {
    union() {
        rounded_base();
        bearing_land(-seam_relief_width / 2 - left_land_width,
                     left_land_width, left_land_length, left_land_elevation);
        bearing_land(seam_relief_width / 2,
                     right_land_width, right_land_length, right_land_elevation);
    }
}

if (part == "rest") {
    rest();
} else {
    // Intersect the same complete solid; the sample's cut ends are flat.
    intersection() {
        rest();
        translate([-base_width / 2, -coupon_length / 2, 0])
            cube([base_width, coupon_length,
                  max(left_land_elevation, right_land_elevation)]);
    }
}
