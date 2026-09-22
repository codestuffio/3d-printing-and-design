// Magnetic steel-plate holder
// All dimensions are in millimeters. Set render_plate_preview or
// render_magnet_preview true only for visual fit checks; preview geometry is
// not included in exported STLs.

include <dimensions.scad>;

$fn = 96;

// ---- Preview controls ----
render_plate_preview = false;
render_magnet_preview = false;

module rounded_square(size, radius, height) {
    hull()
        for (x = [-size / 2 + radius, size / 2 - radius])
            for (y = [-size / 2 + radius, size / 2 - radius])
                translate([x, y, 0])
                    cylinder(r = radius, h = height);
}

module magnet_locations() {
    for (i = [0 : magnet_count - 1])
        rotate([0, 0, i * 360 / magnet_count])
            translate([magnet_pattern_radius, 0, 0])
                children();
}

module magnetic_plate_holder() {
    difference() {
        rounded_square(holder_width, corner_radius, holder_height);

        // Open face for the steel plate. The plate rests directly on the
        // magnets when they are installed in the through-holes below.
        translate([-plate_pocket_width / 2, -plate_pocket_width / 2,
                   holder_height - plate_pocket_depth])
            cube([plate_pocket_width, plate_pocket_width,
                  plate_pocket_depth + epsilon]);

        // Through-holes in the 1/4 in backing plate. A magnet installed from
        // the bottom reaches the plate recess with no plastic between it and
        // the steel.
        magnet_locations()
            translate([0, 0, -epsilon])
                cylinder(d = magnet_pocket_diameter,
                         h = backing_plate_thickness + 2 * epsilon);
    }
}

module previews() {
    if (render_plate_preview)
        color("silver")
            translate([-plate_width / 2, -plate_width / 2,
                       backing_plate_thickness])
                cube([plate_width, plate_width, plate_thickness]);

    if (render_magnet_preview)
        color("royalblue")
            magnet_locations()
                translate([0, 0, 0])
                    cylinder(d = magnet_diameter, h = magnet_thickness);
}

magnetic_plate_holder();
previews();
