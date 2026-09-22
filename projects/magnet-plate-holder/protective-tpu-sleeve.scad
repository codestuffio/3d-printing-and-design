// Thin TPU bumper sleeve for the magnet face of magnet-plate-holder.scad.
// It forms a soft barrier between the magnets and the mounting surface.

include <dimensions.scad>;

$fn = 96;

// ---- TPU sleeve fit ----
sleeve_floor_thickness = 0.60; // protective layer over the magnets
sleeve_wall_thickness = 1.00;
sleeve_wall_height = 1.50;     // how far the rim grips the holder sides
sleeve_fit_clearance = 0.25;   // clearance on each side; tune for your TPU

sleeve_inner_width = holder_width + 2 * sleeve_fit_clearance;
sleeve_inner_corner_radius = corner_radius + sleeve_fit_clearance;
sleeve_outer_width = sleeve_inner_width + 2 * sleeve_wall_thickness;
sleeve_outer_corner_radius = sleeve_inner_corner_radius + sleeve_wall_thickness;
sleeve_height = sleeve_floor_thickness + sleeve_wall_height;

module rounded_square(size, radius, height) {
    hull()
        for (x = [-size / 2 + radius, size / 2 - radius])
            for (y = [-size / 2 + radius, size / 2 - radius])
                translate([x, y, 0])
                    cylinder(r = radius, h = height);
}

module protective_tpu_sleeve() {
    difference() {
        rounded_square(sleeve_outer_width, sleeve_outer_corner_radius, sleeve_height);

        // The shallow inner cavity receives the magnet face and creates a
        // flexible rim that grips the holder's outside edge.
        translate([0, 0, sleeve_floor_thickness])
            rounded_square(sleeve_inner_width, sleeve_inner_corner_radius,
                           sleeve_wall_height + epsilon);
    }
}

protective_tpu_sleeve();
