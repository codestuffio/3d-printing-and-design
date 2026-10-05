// Open J saddle for one measured rack post. Units: mm.
// Defaults are prototype examples, not a verified 10-inch rack interface.

/* [Output] */
part = "saddle"; // [saddle,mounting_coupon]
side = "right"; // [right,left]
print_orientation = true;

/* [Mounting: measure rail and hardware] */
mount_spacing = 31.75; // example only; no universal mini-rack pattern assumed
screw_diameter = 5.5; // clearance opening, not a thread specification
slot_travel = 6; // total extra vertical adjustment
tab_width = 24;
tab_thickness = 8;
mount_edge = 8; // solid material beyond each slot end

/* [Cable support: measure bundle and bend requirement] */
support_radius = 24; // inner contact radius; verify actual cable requirements
wall_thickness = 10;
saddle_width = 22; // contact depth, normal to the mounting face
projection = 68; // from tab's outer edge to the saddle's farthest point
edge_round = 1; // rounded cable-contact edges

/* [Loose hook-and-loop strap] */
strap_width = 12;
strap_clearance = 1;
strap_gap = 2.6;

/* [Hidden] */
$fn = 64;
epsilon = 0.05;
overlap = 3;
tab_corner_radius = 2;
root_top_margin = 3;
rounding_fragments = 16;
min_strap_wall = 1.5;
min_mount_material = 3;
min_support_radius = 8;
min_support_wall = 4;
max_projection_factor = 3;
outer_radius = support_radius + wall_thickness;
tab_height = mount_spacing + screw_diameter + slot_travel + 2 * mount_edge;
center_x = tab_width + projection - outer_radius;
center_z = outer_radius;
left_stem_x = center_x - support_radius - wall_thickness / 2;
root_top = min(tab_height - root_top_margin, center_z + support_radius);
slot_length = screw_diameter + slot_travel;
strap_opening = strap_width + strap_clearance;
// An inscribed circle bounds the faceted arc after erosion at its face.
face_outer_radius = outer_radius * cos(180 / $fn) - edge_round;
strap_bottom_rise = outer_radius - sqrt(face_outer_radius * face_outer_radius -
                                       strap_opening * strap_opening / 4);

assert(part == "saddle" || part == "mounting_coupon", "Unknown part selector");
assert(side == "right" || side == "left", "side must be right or left");
assert(mount_spacing > slot_length, "mount_spacing must separate the slots");
assert(screw_diameter > 0 && slot_travel >= 0 && mount_edge >= min_mount_material,
       "Mounting dimensions need positive holes and material around slots");
assert(tab_width >= screw_diameter + 2 * mount_edge && tab_thickness >= min_mount_material,
       "Mounting tab is too small for the slots");
assert(support_radius >= min_support_radius && wall_thickness >= min_support_wall,
       "Support radius or wall thickness is too small");
assert(edge_round > 0 && 2 * edge_round < wall_thickness &&
       saddle_width > 2 * edge_round && saddle_width >= tab_thickness,
       "edge_round and saddle_width must leave a solid support");
assert(projection >= 2 * outer_radius - overlap &&
       projection <= max_projection_factor * outer_radius,
       "projection must retain root overlap without a long unsupported neck");
assert(root_top > center_z + wall_thickness,
       "Mounting tab must extend above the saddle root");
assert(strap_width > 0 && strap_clearance >= 0 && strap_gap > 0 &&
       strap_gap <= wall_thickness - 2 * min_strap_wall && strap_gap < strap_width + strap_clearance,
       "Strap opening must leave at least 1.5 mm above and below");
assert(strap_width + strap_clearance <= support_radius,
       "Strap opening is too wide for the curved base");
// Account for both the curved underside and eroded profile at rounded faces.
assert(wall_thickness / 2 - strap_gap / 2 - strap_bottom_rise - epsilon >= min_strap_wall,
       "Strap opening leaves too little material at the rounded curved base");

// Profiles are drawn in X/Z, then extruded along Y.
module depth_extrude(depth) {
    translate([0, depth, 0]) rotate([90, 0, 0])
        linear_extrude(height = depth) children();
}

module rounded_rectangle(width, height, radius) {
    hull() for (x = [radius, width - radius], z = [radius, height - radius])
        translate([x, z]) circle(r = radius);
}

module vertical_slot(diameter, travel) {
    hull() for (z = [-travel / 2, travel / 2])
        translate([0, z]) circle(d = diameter);
}

module mounting_profile() {
    rounded_rectangle(tab_width, tab_height, tab_corner_radius);
}

module saddle_profile() {
    union() {
        // Lower half of an annulus: broad inner contact and an open top.
        intersection() {
            translate([center_x, center_z]) difference() {
                circle(r = outer_radius);
                circle(r = support_radius);
            }
            translate([center_x - outer_radius, 0])
                square([2 * outer_radius, center_z]);
        }
        // Rounded tip and a neck that overlaps the mounting tab.
        translate([center_x + support_radius + wall_thickness / 2, center_z])
            circle(d = wall_thickness);
        hull() {
            translate([left_stem_x, center_z]) circle(d = wall_thickness);
            translate([left_stem_x, root_top]) circle(d = wall_thickness);
            translate([tab_width - overlap, root_top]) circle(d = wall_thickness);
        }
    }
}

module saddle_body() {
    // Erode before rounding, so radius/projection/depth keep their meaning.
    // A small sphere rounds both profile edges and the two contact faces.
    minkowski() {
        translate([0, edge_round, 0]) depth_extrude(saddle_width - 2 * edge_round)
            offset(delta = -edge_round) saddle_profile();
        sphere(r = edge_round, $fn = rounding_fragments);
    }
}

module rack_saddle() {
    difference() {
        union() {
            depth_extrude(tab_thickness) mounting_profile();
            if (part == "saddle") saddle_body();
        }
        translate([0, -epsilon, 0]) depth_extrude(saddle_width + 2 * epsilon) {
            for (z = [tab_height / 2 - mount_spacing / 2,
                      tab_height / 2 + mount_spacing / 2])
                translate([tab_width / 2, z]) vertical_slot(screw_diameter, slot_travel);
            if (part == "saddle")
                translate([center_x - strap_opening / 2,
                           wall_thickness / 2 - strap_gap / 2])
                    rounded_rectangle(strap_opening, strap_gap, strap_gap / 2);
        }
    }
}

module sided_part() {
    if (side == "left") mirror([1, 0, 0]) rack_saddle();
    else rack_saddle();
}

// Print on the broad side: Y=0 becomes the bed plane, without supports
// under the arc. Installed orientation has the tab upright and opening up.
if (print_orientation) rotate([90, 0, 0]) sided_part();
else sided_part();
