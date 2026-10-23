// Original shallow bench fixture; all dimensions in mm.
// Defaults are UNMEASURED example geometry, not a keystone compatibility claim.
part = "nest"; // [nest, contact_coupon]
base_length = 92;
base_width = 60;
base_thickness = 8;
base_radius = 4;
jack_length = 34;
jack_width = 20;
recess_depth = 3;
recess_clearance = 0.5; // Per side, loose location only.
support_land_width = 8; // X dimension of each raised bearing land.
support_land_length = 14; // Y dimension; both lands centered on Y=0.
support_land_spacing = 20; // X center-to-center separation.
support_land_height = 0.8;
cable_exit_width = 10;
latch_relief_width = 12;
latch_relief_length = 10; // Beyond the -X recess edge.
latch_relief_extra_depth = 0.5;
ear_width = 24; // X dimension.
ear_projection = 22; // Beyond each +/-Y edge of base.
ear_overlap = 8; // Join inside base; no holes or captive hardware.
ear_radius = 3;
clamp_pad_length = 14; // Actual pad X envelope, including pad articulation.
clamp_pad_width = 12; // Actual pad Y envelope.
clamp_pad_margin = 1;
coupon_length = 50;
coupon_width = 32;
// Measured lowest tool/hand working envelope above the bearing surface.
// The whole actual swept tool envelope must clear every fixture feature.
tool_bottom_above_support = 8;
tool_envelope_length = 40;
tool_envelope_width = 30;
minimum_floor = 3;
minimum_wall = 4;
minimum_land_width = 6;
minimum_land_length = 12;
minimum_ear_join = 4;
minimum_access_gap = 1;
$fn = 48;

cut_epsilon = 0.02;
recess_length = jack_length + 2 * recess_clearance;
recess_width = jack_width + 2 * recess_clearance;
floor_z = base_thickness - recess_depth;
support_z = floor_z + support_land_height;
ear_length = ear_projection + ear_overlap;

assert(part == "nest" || part == "contact_coupon", "part must be nest or contact_coupon");
assert(base_length > 0 && base_width > 0 && base_thickness > 0,
    "base dimensions must be positive");
assert(minimum_floor >= 3 && minimum_wall >= 4 && minimum_land_width >= 6 &&
    minimum_land_length >= 12 && minimum_ear_join >= 4 && minimum_access_gap >= 1,
    "minimum structural and access guards cannot be reduced");
assert(base_radius > 0 && base_radius < min(base_length, base_width) / 2,
    "base radius must preserve a straight-sided base");
assert(jack_length > 0 && jack_width > 0 && recess_depth > 0,
    "jack envelope and recess depth must be positive");
assert(recess_clearance > 0 && recess_clearance <= 2,
    "recess clearance must be positive and at most 2 mm per side");
assert(floor_z >= minimum_floor && floor_z - latch_relief_extra_depth >= minimum_floor,
    "recess and latch relief must preserve minimum floor");
assert(recess_length + 2 * (minimum_wall + base_radius) <= base_length &&
    recess_width + 2 * (minimum_wall + base_radius) <= base_width,
    "recess must preserve broad perimeter walls");
assert(support_land_width >= minimum_land_width && support_land_length >= minimum_land_length &&
    support_land_height > 0 && support_land_height <= recess_depth - minimum_access_gap,
    "support lands must retain broad bearing faces below locating walls");
assert(support_land_spacing > support_land_width &&
    support_land_spacing + support_land_width <= jack_length - 2 &&
    support_land_length <= jack_width - 2,
    "support lands must remain separated and inside housing footprint");
assert(cable_exit_width > 0 && cable_exit_width <= jack_width - 2,
    "cable exit must be open and narrower than housing");
assert(latch_relief_width > 0 && latch_relief_width <= jack_width - 2 &&
    latch_relief_length > 0 && latch_relief_extra_depth >= 0,
    "latch relief must be positive and inside housing width");
assert(latch_relief_length + recess_length / 2 <= base_length / 2 - minimum_wall,
    "latch relief must retain base end wall");
assert(ear_width > 0 && ear_projection > 0 && ear_overlap - ear_radius >= minimum_ear_join &&
    ear_overlap < base_width / 2 && ear_radius > 0 &&
    2 * ear_radius < min(ear_width, ear_length) &&
    ear_width + 2 * base_radius <= base_length,
    "ears must retain broad connected joins");
assert(clamp_pad_length > 0 && clamp_pad_width > 0 && clamp_pad_margin >= 1 &&
    ear_width - 2 * ear_radius >= clamp_pad_length + 2 * clamp_pad_margin &&
    ear_projection - 2 * ear_radius >= clamp_pad_width + 2 * clamp_pad_margin,
    "clamp pads must fit wholly on external ear flats");
assert(coupon_length >= recess_length + 2 * minimum_wall && coupon_length <= base_length &&
    coupon_width >= recess_width + 2 * minimum_wall && coupon_width <= base_width - 2 * base_radius,
    "contact coupon must retain recess walls and both lands");
assert(tool_envelope_length > 0 && tool_envelope_width > 0 &&
    tool_bottom_above_support > 0 &&
    support_z + tool_bottom_above_support >= base_thickness + minimum_access_gap,
    "tool envelope must clear fixture top by minimum access gap");

module rounded_outline(length, width, radius) {
    hull() for (x = [-length / 2 + radius, length / 2 - radius])
        for (y = [-width / 2 + radius, width / 2 - radius])
            translate([x, y]) circle(r = radius);
}

module stock() {
    linear_extrude(base_thickness) union() {
        rounded_outline(base_length, base_width, base_radius);
        for (side = [-1, 1])
            translate([0, side * (base_width / 2 + (ear_projection - ear_overlap) / 2)])
                rounded_outline(ear_width, ear_length, ear_radius);
    }
}

module nest() {
    union() {
        difference() {
            stock();
            // Flat continuous floor backs two raised housing bearing lands.
            translate([-recess_length / 2, -recess_width / 2, floor_z])
                cube([recess_length, recess_width, recess_depth + cut_epsilon]);
            // +X cable channel opens through the outer base edge.
            translate([recess_length / 2 - cut_epsilon, -cable_exit_width / 2, floor_z])
                cube([base_length / 2 + cut_epsilon, cable_exit_width, recess_depth + cut_epsilon]);
            // -X latch pocket is deeper than the contact floor and never a latch stop.
            translate([-recess_length / 2 - latch_relief_length, -latch_relief_width / 2,
                floor_z - latch_relief_extra_depth])
                cube([latch_relief_length + cut_epsilon, latch_relief_width,
                    recess_depth + latch_relief_extra_depth + cut_epsilon]);
        }
        for (side = [-1, 1])
            translate([side * support_land_spacing / 2 - support_land_width / 2,
                -support_land_length / 2, floor_z - cut_epsilon])
                cube([support_land_width, support_land_length, support_land_height + cut_epsilon]);
    }
}

if (part == "contact_coupon") {
    // Exact-source crop: both contact lands, full recess width, open channel stubs.
    intersection() {
        nest();
        translate([-coupon_length / 2, -coupon_width / 2, -cut_epsilon])
            cube([coupon_length, coupon_width, base_thickness + 2 * cut_epsilon]);
    }
} else nest();
