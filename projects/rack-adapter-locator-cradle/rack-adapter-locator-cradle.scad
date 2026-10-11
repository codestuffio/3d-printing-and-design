// Open locator for one measured USB/Ethernet adapter on a metal shelf.
// Millimeters. Defaults are EXAMPLES, not measurements or verified fit.

/* [Output] */
part = "cradle"; // [cradle,contact_coupon,mounting_coupon]
show_reference = false; // Preview-only example adapter; excluded from STL.

/* [Adapter: measure case, feet, vents and connectors] */
case_length = 75;
case_width = 28;
case_height = 18;
side_clearance = 0.6; // per side; no force fit
side_contacts = [-28, 28]; // X centers of two stops on each long side
end_contacts = [-10, 10]; // Y centers of two stops at each connector end
contact_span = 5;
stop_height = 7; // above the base frame

/* [Open frame] */
frame_width = 6;
base_thickness = 3;
edge_radius = 0.8; // XY rounding; bottom stays flat
stop_thickness = 3;

/* [Raised strap anchors: measure strap and a clear case crossing] */
strap_x = 0;
strap_width = 14;
strap_thickness = 2;
strap_clearance = 0.6;
strap_roof = 3; // material above the horizontal slot

/* [Shelf fastening: measure openings and underside access] */
mount_x = 0; // both holes have this X coordinate
mount_spacing = 54; // Y spacing; EXAMPLE, not a rack standard
screw_diameter = 3.6; // clearance hole, not a thread
washer_diameter = 9;
tab_width = 18;
tab_depth = 18;

/* [Hidden] */
$fn = 48;
epsilon = 0.05;
min_wall = 2;
min_overlap = 2;
hardware_clearance = 1;
lug_face_inset = 0.2; // avoid coincident lug/frame faces in CGAL triangulation
opening_length = case_length + 2 * side_clearance;
opening_width = case_width + 2 * side_clearance;
outer_length = opening_length + 2 * frame_width;
outer_width = opening_width + 2 * frame_width;
strap_opening = strap_width + 2 * strap_clearance;
strap_gap = strap_thickness + strap_clearance;
lug_length = strap_opening + 2 * (min_wall + edge_radius);
lug_height = base_thickness + strap_gap + strap_roof;
// Leave room for the strap return leg between the case and each upper bridge.
lug_inner_inset = max(lug_face_inset, strap_gap - side_clearance);
lug_depth = frame_width - lug_face_inset - lug_inner_inset;

assert(part == "cradle" || part == "contact_coupon" || part == "mounting_coupon",
       "Unknown part selector");
assert(case_length > 0 && case_width > 0 && case_height > 0,
       "Case dimensions must be positive");
assert(side_clearance >= 0, "Clearance cannot be negative");
assert(base_thickness >= min_wall && frame_width >= 2 * min_wall &&
       edge_radius > 0 && edge_radius < min_wall &&
       stop_thickness >= min_wall && stop_thickness > 2 * edge_radius &&
       stop_thickness <= frame_width,
       "Frame dimensions must preserve walls and corner material");
assert(contact_span > 2 * edge_radius && contact_span >= min_wall &&
       stop_height > 0 && base_thickness + stop_height < case_height,
       "Stop height/span must leave the case accessible");
assert(len(side_contacts) == 2 && side_contacts[0] < side_contacts[1] &&
       side_contacts[1] - side_contacts[0] >= contact_span + min_wall &&
       min(side_contacts) - contact_span / 2 >= -opening_length / 2 + min_wall &&
       max(side_contacts) + contact_span / 2 <= opening_length / 2 - min_wall,
       "Side contacts must be separated and remain on the frame");
assert(len(end_contacts) == 2 && end_contacts[0] < 0 && end_contacts[1] > 0 &&
       end_contacts[1] - end_contacts[0] >= 2 * contact_span &&
       end_contacts[0] + contact_span / 2 <= -min_wall &&
       end_contacts[1] - contact_span / 2 >= min_wall &&
       min(end_contacts) - contact_span / 2 >= -opening_width / 2 + min_wall &&
       max(end_contacts) + contact_span / 2 <= opening_width / 2 - min_wall,
       "End contacts must leave an open central connector corridor");
assert(strap_width > 0 && strap_thickness > 0 && strap_clearance >= 0 &&
       strap_roof - edge_radius >= min_wall && lug_height < case_height &&
       lug_depth >= min_wall,
       "Strap dimensions must preserve the bridge and case access");
assert(abs(strap_x) + lug_length / 2 <= opening_length / 2 - min_wall &&
       min([for (x = side_contacts) abs(strap_x - x)]) >=
           (lug_length + contact_span) / 2 + min_wall,
       "Strap lug must remain on the frame and clear the side stops");
assert(screw_diameter > 0 && washer_diameter >= screw_diameter &&
       tab_width / 2 - edge_radius - screw_diameter / 2 >= min_wall &&
       tab_depth / 2 - edge_radius - screw_diameter / 2 >= min_wall &&
       tab_width >= washer_diameter + 2 * hardware_clearance &&
       tab_depth >= washer_diameter + 2 * hardware_clearance,
       "Mounting tab must retain hole walls and washer clearance");
assert(mount_spacing / 2 - tab_depth / 2 >= opening_width / 2 &&
       mount_spacing / 2 - tab_depth / 2 <= outer_width / 2 - min_overlap &&
       abs(mount_x) + tab_width / 2 <= opening_length / 2,
       "Mount spacing and position must retain tab overlap");
assert(mount_spacing / 2 - washer_diameter / 2 >=
           outer_width / 2 + hardware_clearance,
       "Washer clearance must keep hardware outside the frame and strap exit");

module rounded_profile(length, width, radius = edge_radius) {
    hull() for (x = [-length / 2 + radius, length / 2 - radius],
                y = [-width / 2 + radius, width / 2 - radius])
        translate([x, y]) circle(r = radius);
}

module rounded_block(length, width, height) {
    linear_extrude(height = height) rounded_profile(length, width);
}

module mounting_tabs() {
    difference() {
        for (y = [-mount_spacing / 2, mount_spacing / 2])
            translate([mount_x, y, 0]) rounded_block(tab_width, tab_depth, base_thickness);
        for (y = [-mount_spacing / 2, mount_spacing / 2])
            translate([mount_x, y, -epsilon])
                cylinder(d = screw_diameter, h = base_thickness + 2 * epsilon);
    }
}

module side_stop(x, direction) {
    translate([x, direction * (opening_width / 2 + stop_thickness / 2), 0])
        rounded_block(contact_span, stop_thickness, base_thickness + stop_height);
}

module strap_lug(x, direction) {
    // Slot runs horizontally through Y, above the shelf. Roof rounds in X/Z.
    translate([x, 0, 0]) scale([1, direction, 1])
        translate([0, opening_width / 2 + frame_width / 2, 0]) difference() {
            translate([0, frame_width / 2 - lug_face_inset, lug_height / 2]) rotate([90, 0, 0])
                linear_extrude(height = lug_depth)
                    rounded_profile(lug_length, lug_height);
            translate([-strap_opening / 2, -frame_width / 2 - epsilon, base_thickness])
                cube([strap_opening, frame_width + 2 * epsilon, strap_gap]);
        }
}

module cradle() {
    union() {
        difference() {
            rounded_block(outer_length, outer_width, base_thickness);
            translate([-opening_length / 2, -opening_width / 2, -epsilon])
                cube([opening_length, opening_width, base_thickness + 2 * epsilon]);
        }
        mounting_tabs();
        for (direction = [-1, 1]) {
            for (x = side_contacts) side_stop(x, direction);
            for (y = end_contacts)
                translate([direction * (opening_length / 2 + stop_thickness / 2), y, 0])
                    rounded_block(stop_thickness, contact_span, base_thickness + stop_height);
            strap_lug(strap_x, direction);
        }
    }
}

module contact_coupon() {
    // Same side contact face and raised strap slot, on one short frame segment.
    coupon_length = lug_length + contact_span + 3 * min_wall;
    coupon_center = -(contact_span + min_wall) / 2;
    union() {
        translate([coupon_center, opening_width / 2 + frame_width / 2, 0])
            rounded_block(coupon_length, frame_width, base_thickness);
        side_stop(-lug_length / 2 - min_wall - contact_span / 2, 1);
        strap_lug(0, 1);
    }
}

module mounting_coupon() {
    // Both exact holes, tab profiles and spacing; narrow bridge joins the tabs.
    union() {
        mounting_tabs();
        translate([mount_x, 0, 0])
            rounded_block(2 * min_wall, mount_spacing - tab_depth + 2 * min_overlap, base_thickness);
    }
}

if (part == "cradle") cradle();
else if (part == "contact_coupon") contact_coupon();
else mounting_coupon();

// The reference is visualization only. Actual exports contain only the print.
if ($preview && show_reference && part == "cradle")
    %translate([-case_length / 2, -case_width / 2, 0])
        cube([case_length, case_width, case_height]);
