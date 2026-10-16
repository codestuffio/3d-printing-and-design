// Wing-root lead keeper. Millimeters. Stationary bench prototype only.
// ALL interface defaults are UNMEASURED EXAMPLES, not aircraft fit data.
/* [Output] */
part = "keeper"; // [keeper,contact_coupon]
/* [Plate: UNMEASURED EXAMPLES] */
plate_width = 48;
plate_height = 34;
plate_thickness = 3;
edge_radius = 2;
minimum_section = 1.2;
/* [Lead and housing: UNMEASURED EXAMPLES] */
wire_bundle_width = 3.4; // Maximum across all wire orientations to be inserted.
wire_clearance = 0.5; // Total clearance, not per side.
slot_width = 4.4;
slot_x = 0;
slot_seat_y = -1; // Center of the rounded root, relative to plate center.
mouth_flare = 1;
mouth_length = 3;
housing_minimum_width = 6; // Smallest shoulder caliper across reachable rotations.
shoulder_overlap = 0.6; // Minimum on EACH side of slot; geometric input only.
/* [Root opening/contact: UNMEASURED EXAMPLES] */
opening_width = 16; // Bounding rectangle centered at plate XY origin.
opening_height = 12;
land_width = 50; // Entire coplanar plate-body footprint must have firm contact.
land_height = 36;
contact_margin = 2;
maximum_tilt = 10; // Degrees from root normal, modeled bound; NOT mechanically enforced.
/* [Integral removal tab] */
handle_length = 28;
handle_height = 26;
handle_overlap = 4;
label_size = 3;
label_row_spacing = 2.3 * label_size; // Named row-center distance in millimeters.
label_depth = 0.6;
/* [Coupon] */
coupon_side_wall = 5;
coupon_lower_bridge = 5;
/* [Hidden] */
$fn = 64;
epsilon = 0.02;
slot_radius = slot_width / 2;
plate_top = plate_height / 2;
plate_bottom = -plate_height / 2;
slot_bottom = slot_seat_y - slot_radius;
flared_half_width = slot_radius + mouth_flare;
handle_x = plate_width / 2 + handle_length / 2 - handle_overlap;
coupon_width = slot_width + 2 * coupon_side_wall;
coupon_bottom = slot_bottom - coupon_lower_bridge;
coupon_height = plate_top - coupon_bottom;
// A disk inside the rounded rectangular body projects to an ellipse at tilt.
// Its minor diameter exceeds the opening's bounding-rectangle diagonal.
// This bounded geometric check does not constrain actual handling/slot escape.
projected_body_diameter = min(plate_width, plate_height) * cos(maximum_tilt);
opening_diagonal = sqrt(opening_width * opening_width + opening_height * opening_height);

assert(part == "keeper" || part == "contact_coupon", "Unknown part selector");
assert(min(plate_width, plate_height, plate_thickness, edge_radius, minimum_section,
           wire_bundle_width, wire_clearance, slot_width, mouth_flare, mouth_length,
           housing_minimum_width, shoulder_overlap, opening_width, opening_height,
           land_width, land_height, contact_margin, handle_length, handle_height,
           handle_overlap, label_size, label_row_spacing, label_depth, coupon_side_wall,
           coupon_lower_bridge) > 0, "Dimensions must be positive");
assert(plate_thickness >= minimum_section &&
       edge_radius < min(plate_width, plate_height, handle_length, handle_height) / 2,
       "Rounding must retain positive straight profiles and minimum thickness");
assert(slot_width >= wire_bundle_width + wire_clearance,
       "Slot must clear the measured wire bundle");
assert(slot_width + 2 * shoulder_overlap <= housing_minimum_width + 1e-9,
       "Slot must block the smallest measured housing shoulder");
assert(slot_bottom - plate_bottom >= minimum_section,
       "Slot must retain the lower bridge");
assert(plate_top - mouth_length > slot_seat_y &&
       abs(slot_x) + flared_half_width + edge_radius + minimum_section <= plate_width / 2,
       "Slot and mouth must retain side walls and a straight corridor");
assert(abs(slot_x) + slot_radius + wire_clearance / 2 <= opening_width / 2 &&
       abs(slot_seat_y) + slot_radius + wire_clearance / 2 <= opening_height / 2,
       "Rounded slot root must clear the centered opening");
assert(land_width >= plate_width && land_height >= plate_height &&
       plate_width >= opening_width + 2 * contact_margin &&
       plate_height >= opening_height + 2 * contact_margin,
       "Plate body must span the opening on firm measured contact land");
assert(maximum_tilt >= 0 && maximum_tilt < 90 &&
       projected_body_diameter > opening_diagonal + 2 * contact_margin,
       "Bounded tilt projection must exceed the opening diagonal and contact margins");
assert(handle_overlap >= edge_radius + minimum_section &&
       handle_overlap < handle_length / 2 && handle_height <= plate_height - 2 * edge_radius,
       "Tab must overlap solid plate core without crossing the top slot mouth");
assert(label_depth <= plate_thickness - minimum_section &&
       label_size * 8 <= handle_length - 2 * edge_radius &&
       label_row_spacing >= 1.5 * label_size &&
       2 * label_row_spacing + 1.2 * label_size <= handle_height - 2 * edge_radius,
       "Label must fit the tab and retain its floor");
assert(coupon_side_wall >= mouth_flare + minimum_section &&
       coupon_lower_bridge >= minimum_section &&
       coupon_bottom >= plate_bottom &&
       abs(slot_x) + coupon_width / 2 <= plate_width / 2 - edge_radius,
       "Coupon must fit within the full plate with solid walls and lower bridge");

module rounded_rectangle(width, height) {
    hull() for (x = [-width / 2 + edge_radius, width / 2 - edge_radius])
        for (y = [-height / 2 + edge_radius, height / 2 - edge_radius])
            translate([x, y]) circle(r = edge_radius);
}
module slot() {
    translate([slot_x, slot_seat_y]) circle(r = slot_radius);
    translate([slot_x - slot_radius, slot_seat_y])
        square([slot_width, plate_top - slot_seat_y + epsilon]);
    polygon([[slot_x - slot_radius, plate_top - mouth_length],
             [slot_x + slot_radius, plate_top - mouth_length],
             [slot_x + flared_half_width, plate_top + epsilon],
             [slot_x - flared_half_width, plate_top + epsilon]]);
}
module plate_profile() {
    difference() {
        union() {
            rounded_rectangle(plate_width, plate_height);
            translate([handle_x, 0]) rounded_rectangle(handle_length, handle_height);
        }
        slot();
    }
}
module keeper() {
    difference() {
        linear_extrude(plate_thickness) plate_profile();
        translate([handle_x, 0, plate_thickness - label_depth])
            linear_extrude(label_depth + epsilon) {
                translate([0, label_row_spacing]) text("REMOVE", size = label_size,
                    halign = "center", valign = "center", font = "Liberation Sans:style=Bold");
                text("BEFORE", size = label_size, halign = "center", valign = "center",
                    font = "Liberation Sans:style=Bold");
                translate([0, -label_row_spacing]) text("ASSEMBLY", size = label_size,
                    halign = "center", valign = "center", font = "Liberation Sans:style=Bold");
            }
    }
}
module contact_coupon() {
    // Exact crop of the same slot/body profile, including root, mouth and thickness.
    // Omits the removal tab; cannot establish full-plate aperture containment.
    linear_extrude(plate_thickness)
        intersection() {
            plate_profile();
            translate([slot_x - coupon_width / 2, coupon_bottom])
                square([coupon_width, coupon_height]);
        }
}
if (part == "keeper") keeper();
else contact_coupon();
