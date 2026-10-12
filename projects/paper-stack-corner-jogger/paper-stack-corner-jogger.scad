// Bottomless paper-stack corner jogger. All dimensions are millimeters.
// The desk is z=0; paper occupies x>=0, y>=0 and rests on the desk.
// Contact faces are y=0 and x=0 from corner_relief_radius to each length.
// Feet extend outwards only. No floor or lower-contact compensation.

contact_x_length = 90;       // Outer end of the straight y=0 registration face.
contact_y_length = 90;       // Outer end of the straight x=0 registration face.
wall_height = 18;            // Example stack envelope, not measured paper data.
wall_thickness = 3;
foot_width = 9;              // Additional outward extension beyond the wall.
foot_height = 3;
corner_relief_radius = 1.5;  // Circular clearance at the paper's inner corner.
exterior_rounding_radius = 0.75; // Only the two outside corners of each bar.

$fn = 64;

// Reject lost contact length, removed connecting material and malformed feet.
assert(contact_x_length > 0 && contact_y_length > 0,
       "Contact lengths must be positive.");
assert(wall_height > 0 && wall_thickness > 0,
       "Wall height and thickness must be positive.");
assert(foot_width > 0 && foot_height > 0 && foot_height < wall_height,
       "Feet must have positive width and height below the wall height.");
assert(corner_relief_radius > 0,
       "Corner relief radius must be positive.");
assert(exterior_rounding_radius >= 0,
       "Exterior rounding radius cannot be negative.");
assert(exterior_rounding_radius <= wall_thickness / 2,
       "Exterior rounding must leave the wall's inner contact strip intact.");
assert(corner_relief_radius + exterior_rounding_radius < wall_thickness,
       "Relief and rounding must leave a connected wall bridge.");
assert(contact_x_length > corner_relief_radius + wall_thickness &&
       contact_y_length > corner_relief_radius + wall_thickness,
       "Each arm must retain contact longer than one wall thickness.");

// Rounds the two corners facing away from the paper only. The y=0 edge
// remains straight through the full height, including its lowest layer.
module exterior_bar_2d(contact_length, depth) {
    r = exterior_rounding_radius;
    x_min = -wall_thickness;
    bar_length = contact_length - x_min;
    if (r == 0) {
        translate([x_min, -depth]) square([bar_length, depth]);
    } else {
        union() {
            translate([x_min, -depth + r])
                square([bar_length, depth - r]);
            translate([x_min + r, -depth])
                square([bar_length - 2 * r, depth]);
            translate([x_min + r, -depth + r]) circle(r = r);
            translate([contact_length - r, -depth + r]) circle(r = r);
        }
    }
}

module l_profile_2d(depth) {
    union() {
        exterior_bar_2d(contact_x_length, depth);
        // Reflection in x=y swaps the two registration axes.
        mirror([1, -1, 0]) exterior_bar_2d(contact_y_length, depth);
    }
}

// Subtract relief in 2D before extrusion; no epsilon cuts or coplanar caps.
module relieved_l_profile_2d(depth) {
    difference() {
        l_profile_2d(depth);
        circle(r = corner_relief_radius);
    }
}

union() {
    linear_extrude(height = wall_height)
        relieved_l_profile_2d(wall_thickness);
    linear_extrude(height = foot_height)
        relieved_l_profile_2d(wall_thickness + foot_width);
}
