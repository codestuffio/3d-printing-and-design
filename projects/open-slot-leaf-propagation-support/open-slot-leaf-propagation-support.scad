// Loose open-slot leaf support. Millimeters; UNMEASURED EXAMPLE dimensions.
// Support the cutting separately before lifting or sliding this plate free.

/* [Output] */
part = "support"; // [support,contact_coupon]

/* [Jar and cutting: replace all examples with measurements] */
jar_mouth_diameter = 60;
jar_outer_rim_diameter = 66;
bearing_overlap = 2; // Minimum radial land on rim, and plate overhang beyond rim.
petiole_diameter = 3;
petiole_clearance = 1; // Clearance on EACH side; never a friction fit.

/* [Plate: unmeasured examples] */
plate_diameter = 76;
plate_thickness = 3;
opening_diameter = 8;
slot_width = 5;
minimum_web = 6; // Remaining material after contact-edge rounding.
edge_rounding = 0.6; // Shallow stepped rounding on both faces.

/* [Handling tab: opposite the slot] */
tab_length = 12; // Projection beyond the plate's leftmost edge.
tab_width = 18;
tab_overlap = 4; // Tab extends this far inside the nominal plate edge.
tab_corner_radius = 3;

/* [Hidden] */
$fn = 96;
rounding_steps = 6;
plate_radius = plate_diameter / 2;
opening_radius = opening_diameter / 2;
coupon_half_width = opening_radius + minimum_web + 2 * edge_rounding;

assert($fn >= 24, "Curve sampling requires $fn >= 24");
assert(rounding_steps >= 2 && rounding_steps == floor(rounding_steps),
       "rounding_steps must be an integer of at least 2");
assert(part == "support" || part == "contact_coupon", "Unknown part selector");
assert(jar_mouth_diameter > 0 && jar_outer_rim_diameter > 0 &&
       bearing_overlap > 0 && petiole_diameter > 0 && petiole_clearance > 0 &&
       plate_diameter > 0 && plate_thickness > 0 && opening_diameter > 0 &&
       slot_width > 0 && minimum_web > 0 && edge_rounding > 0 &&
       tab_length > 0 && tab_width > 0 && tab_overlap > 0 && tab_corner_radius > 0,
       "Dimensions must be positive");
assert(jar_outer_rim_diameter - jar_mouth_diameter >= 2 * bearing_overlap,
       "Jar rim must provide bearing_overlap outside the mouth");
assert(plate_diameter - 2 * edge_rounding >= jar_outer_rim_diameter + 2 * bearing_overlap,
       "Rounded plate must overhang the outer rim by bearing_overlap");
assert(slot_width >= petiole_diameter + 2 * petiole_clearance,
       "Slot must clear the petiole on both sides without gripping");
assert(opening_diameter >= slot_width,
       "Opening must be at least as wide as the open slot");
assert(2 * edge_rounding < plate_thickness,
       "Edge rounding must preserve a straight plate wall");
assert((plate_diameter - opening_diameter) / 2 - 2 * edge_rounding >= minimum_web,
       "Rounded opening must preserve minimum_web of plate material");
assert(opening_diameter + 2 * edge_rounding <= jar_mouth_diameter,
       "Rounded opening must remain inside the jar mouth to preserve bearing land");
assert(tab_width - 2 * edge_rounding >= minimum_web &&
       tab_width > 2 * tab_corner_radius &&
       tab_length + tab_overlap > 2 * tab_corner_radius &&
       tab_overlap >= tab_corner_radius &&
       tab_overlap < plate_radius - opening_radius - 2 * edge_rounding,
       "Tab must retain a connected rounded web outside the opening");

module rounded_tab() {
    // Original rounded rectangle; no hardware, skirt or locating clamp.
    hull()
        for (x = [-plate_radius - tab_length + tab_corner_radius,
                  -plate_radius + tab_overlap - tab_corner_radius])
            for (y = [-tab_width / 2 + tab_corner_radius,
                       tab_width / 2 - tab_corner_radius])
                translate([x, y]) circle(r = tab_corner_radius);
}

module blank_profile() {
    if (part == "support")
        union() {
            circle(r = plate_radius);
            rounded_tab();
        }
    else
        // Short contact strip: actual opening and whole side-release path.
        offset(r = edge_rounding)
            offset(delta = -edge_rounding)
                translate([-coupon_half_width, -coupon_half_width])
                    square([plate_radius + coupon_half_width, 2 * coupon_half_width]);
}

module contact_profile() {
    difference() {
        blank_profile();
        circle(r = opening_radius);
        // The rectangle overlaps the opening at its centre and exits the blank.
        translate([0, -slot_width / 2])
            square([plate_diameter, slot_width]);
    }
}

module rounded_contact_plate() {
    translate([0, 0, edge_rounding])
        linear_extrude(height = plate_thickness - 2 * edge_rounding)
            contact_profile();
    // Small 2D inset steps approximate a quarter-round, keeping the slot open.
    // Insetting the solid widens the opening/slot rather than narrowing clearance.
    for (i = [0 : rounding_steps - 1])
        let(z = i * edge_rounding / rounding_steps,
            inset = edge_rounding - sqrt(pow(edge_rounding, 2) -
                                         pow(edge_rounding - z, 2)))
            // Tiny inward overlap avoids disconnected coplanar layer seams.
            for (face = [0, 1])
                translate([0, 0, face * plate_thickness])
                    scale([1, 1, face == 0 ? 1 : -1])
                        translate([0, 0, z])
                            linear_extrude(height = edge_rounding / rounding_steps +
                                                    edge_rounding / 1000)
                                offset(delta = -inset) contact_profile();
}

rounded_contact_plate();
