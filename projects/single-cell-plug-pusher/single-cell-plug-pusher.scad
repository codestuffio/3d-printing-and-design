// Single-cell seedling plug pusher. Millimeters throughout.
// UNMEASURED EXAMPLES: establish an actual tray/interface before printing.

/* [Output] */
part = "tool"; // [tool,contact_coupon]

/* [Measured tray interface: all defaults are UNMEASURED EXAMPLES] */
hole_diameter = 10; // Smallest circular clearance through the actual hole.
land_inner_diameter = 12; // Inner boundary of firm, coplanar annular contact.
land_outer_diameter = 24; // Outer boundary, before ribs/unsupported material.
underside_recess_depth = 0; // This interface requires zero recess.
minimum_contact_width = 2; // Required radial overlap; geometric input only.
maximum_projection = 10; // Establish for this tray/plug; no universal safe stroke.

/* [Tip and shoulder: UNMEASURED EXAMPLES] */
tip_diameter = 8.4;
tip_edge_radius = 0.6; // Round the upper rim, retaining a flat blunt face.
pin_projection = 8; // Exact height above the shoulder contact plane.
shoulder_diameter = 22; // Diameter of the flat shoulder contact plane.
shoulder_thickness = 3;
junction_radius = 2; // Solid fillet BELOW contact plane, at palm/shoulder junction.

/* [Palm pad: UNMEASURED EXAMPLES] */
palm_diameter = 42;
palm_thickness = 7;

/* [Hidden] */
$fn = 96;
rounding_segments = 16;
tip_radius = tip_diameter / 2;
shoulder_radius = shoulder_diameter / 2;
palm_radius = palm_diameter / 2;
diametral_clearance = hole_diameter - tip_diameter;
contact_width = (shoulder_diameter - land_inner_diameter) / 2;
shoulder_contact_z = part == "tool" ? palm_thickness + shoulder_thickness : shoulder_thickness;
tip_top_z = shoulder_contact_z + pin_projection;

assert(part == "tool" || part == "contact_coupon", "Unknown part selector");
assert(hole_diameter > 0 && land_inner_diameter > 0 && land_outer_diameter > 0 &&
       minimum_contact_width > 0 && maximum_projection > 0 && tip_diameter > 0 &&
       tip_edge_radius > 0 && pin_projection > 0 && shoulder_diameter > 0 &&
       shoulder_thickness > 0 && junction_radius > 0 && palm_diameter > 0 &&
       palm_thickness > 0, "Dimensions must be positive");
assert(underside_recess_depth == 0,
       "Recessed or offset contact lands are unsupported; underside_recess_depth must be zero");
assert(diametral_clearance > 0, "Tip must have positive diametral clearance through hole");
assert(pin_projection <= maximum_projection,
       "pin_projection exceeds measured maximum_projection");
assert(tip_edge_radius < tip_radius && tip_edge_radius < pin_projection,
       "Tip rounding must retain a flat blunt face and straight pin length");
assert(land_inner_diameter >= hole_diameter && land_outer_diameter > land_inner_diameter &&
       shoulder_diameter <= land_outer_diameter && contact_width >= minimum_contact_width,
       "Shoulder must fit firm annular contact land with minimum_contact_width");
assert(shoulder_thickness > junction_radius && palm_thickness > junction_radius &&
       palm_radius - junction_radius > shoulder_radius + junction_radius,
       "Junction rounding must preserve solid shoulder thickness and palm material");

// Shared flat shoulder contact and full pin profile; only the datum changes.
function shoulder_and_tip_profile() = concat(
    [[shoulder_radius, shoulder_contact_z],
     [tip_radius, shoulder_contact_z],
     [tip_radius, tip_top_z - tip_edge_radius]],
    [for (i = [1 : rounding_segments])
        let(angle = 90 * i / rounding_segments)
        [tip_radius - tip_edge_radius + tip_edge_radius * cos(angle),
         tip_top_z - tip_edge_radius + tip_edge_radius * sin(angle)]],
    [[0, tip_top_z]]
);

module tool() {
    rotate_extrude(convexity = 2)
        polygon(concat(
            [[0, 0], [palm_radius, 0], [palm_radius, palm_thickness - junction_radius]],
            [for (i = [1 : rounding_segments])
                let(angle = 90 * i / rounding_segments)
                [palm_radius - junction_radius + junction_radius * cos(angle),
                 palm_thickness - junction_radius + junction_radius * sin(angle)]],
            [[shoulder_radius + junction_radius, palm_thickness]],
            [for (i = [1 : rounding_segments])
                let(angle = 270 - 90 * i / rounding_segments)
                [shoulder_radius + junction_radius + junction_radius * cos(angle),
                 palm_thickness + junction_radius + junction_radius * sin(angle)]],
            shoulder_and_tip_profile()
        ));
}

module contact_coupon() {
    // Flat bed face at z=0; same shoulder contact and pin, omitting palm/junction.
    rotate_extrude(convexity = 2)
        polygon(concat([[0, 0], [shoulder_radius, 0]], shoulder_and_tip_profile()));
}

if (part == "tool") tool();
else contact_coupon();
