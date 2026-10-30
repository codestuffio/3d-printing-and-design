// Four-compartment RC bench hardware cassette. All dimensions are millimeters.
// Example sizing, not measured Timber X hardware. Print interface coupons first.
part = "layout"; // tray, lid, tray_coupon, lid_coupon, layout, assembly

well_length = 40;
well_width = 24;
well_depth = 12;
floor_thickness = 2;
wall_thickness = 2.4;
divider_width = 2.4;
pocket_radius = 3;
bottom_fillet = 1.2;
outer_radius = 4;

lid_thickness = 2.4;
skirt_thickness = 1.8;
skirt_depth = 6;
lateral_clearance = 0.3; // Per side, between tray and lid skirt.
closed_gap = 0; // Nominal lid underside to rim/divider; print warp is unmeasured.
smallest_part_thickness = 0.5; // Example only. Measure your thinnest loose washer.
band_width = 8; // Side guides for one ordinary elastic band, not a printed latch.
band_groove_depth = 0.6;
thumb_radius = 3;
coupon_depth = 16;
layout_gap = 12;
minimum_material = 1.2;
rounding_steps = 6;
$fn = 48;
cut_epsilon = 0.02;

tray_length = 2*well_length + 2*wall_thickness + divider_width;
tray_width = 2*well_width + 2*wall_thickness + divider_width;
tray_height = floor_thickness + well_depth;
lid_margin = lateral_clearance + skirt_thickness;
lid_length = tray_length + 2*lid_margin;
lid_width = tray_width + 2*lid_margin;
lid_height = lid_thickness + skirt_depth;
crop_y = -lid_width/2;

assert(well_length > 0 && well_width > 0 && well_depth > 0,
       "Well dimensions must be positive");
assert(minimum_material >= 1.2 && floor_thickness >= minimum_material &&
       wall_thickness >= minimum_material && divider_width >= minimum_material &&
       lid_thickness >= minimum_material, "Floor, walls and divider must retain minimum material");
assert(bottom_fillet > 0 && bottom_fillet < pocket_radius &&
       pocket_radius < min(well_length,well_width)/2 && bottom_fillet < well_depth,
       "Pocket radii must preserve a flat floor and open mouth");
assert(outer_radius > 0 && outer_radius <= wall_thickness+pocket_radius &&
       outer_radius < min(tray_length,tray_width)/2,
       "Outer radius must preserve corner walls");
assert(lateral_clearance >= 0.1 && lateral_clearance <= 1,
       "Lateral clearance must be between 0.1 and 1 mm per side");
assert(closed_gap >= 0 && smallest_part_thickness > 0 && closed_gap < smallest_part_thickness,
       "Closed gap must be smaller than the smallest loose part thickness");
assert(skirt_depth-closed_gap >= minimum_material &&
       skirt_depth <= tray_height+closed_gap-minimum_material,
       "Skirt must locate the tray without bottoming on the bench");
assert(band_width > divider_width && band_width < well_length && band_groove_depth > 0 &&
       min(wall_thickness,skirt_thickness)-band_groove_depth >= minimum_material,
       "Band grooves must retain wall and skirt material");
assert(thumb_radius > 0 && thumb_radius <= skirt_depth-minimum_material &&
       thumb_radius < well_width/2, "Thumb recess must leave an intact upper skirt");
assert(coupon_depth > lid_margin+wall_thickness+bottom_fillet+2 && coupon_depth < lid_width/2,
       "Coupon depth must include the mating edge and remain before the middle divider");
assert(rounding_steps >= 4 && rounding_steps == floor(rounding_steps) && $fn >= 24,
       "Curve sampling requires at least four steps and 24 facets");
assert(layout_gap > 0 && cut_epsilon > 0 && cut_epsilon < 0.05,
       "Layout gap and cut epsilon must be positive and bounded");
assert(part == "tray" || part == "lid" || part == "tray_coupon" ||
       part == "lid_coupon" || part == "layout" || part == "assembly", "Unknown part selector");

echo(tray_mm=[tray_length,tray_width,tray_height],
     lid_mm=[lid_length,lid_width,lid_height], well_mm=[well_length,well_width,well_depth]);

module rounded_rectangle(length,width,radius) {
    hull() for (x=[-1,1], y=[-1,1])
        translate([x*(length/2-radius),y*(width/2-radius)]) circle(r=radius);
}

module well_cut() {
    module layer(step) {
        angle = 90*step/rounding_steps;
        inset = bottom_fillet*(1-sin(angle));
        translate([0,0,floor_thickness+bottom_fillet*(1-cos(angle))])
            linear_extrude(height=cut_epsilon)
                rounded_rectangle(well_length-2*inset,well_width-2*inset,pocket_radius-inset);
    }
    for (step=[0:rounding_steps-1]) hull() {
        layer(step);
        layer(step+1);
    }
    translate([0,0,floor_thickness+bottom_fillet])
        linear_extrude(height=well_depth-bottom_fillet+cut_epsilon)
            rounded_rectangle(well_length,well_width,pocket_radius);
}

module side_band_cuts(width,height) {
    for (sign=[-1,1])
        translate([-band_width/2,
                   sign < 0 ? -width/2-cut_epsilon : width/2-band_groove_depth,
                   -cut_epsilon])
            cube([band_width,band_groove_depth+cut_epsilon,height+2*cut_epsilon]);
}

module tray() {
    difference() {
        linear_extrude(height=tray_height)
            rounded_rectangle(tray_length,tray_width,outer_radius);
        for (x=[-1,1], y=[-1,1])
            translate([x*(well_length+divider_width)/2,y*(well_width+divider_width)/2,0])
                well_cut();
        side_band_cuts(tray_width,tray_height);
    }
}

// Print with the exterior roof on z=0 and the locating skirt pointing upward.
module lid() {
    difference() {
        union() {
            linear_extrude(height=lid_thickness)
                rounded_rectangle(lid_length,lid_width,outer_radius+lid_margin);
            translate([0,0,lid_thickness-cut_epsilon])
                linear_extrude(height=skirt_depth+cut_epsilon)
                    difference() {
                        rounded_rectangle(lid_length,lid_width,outer_radius+lid_margin);
                        rounded_rectangle(tray_length+2*lateral_clearance,
                                          tray_width+2*lateral_clearance,
                                          outer_radius+lateral_clearance);
                    }
        }
        side_band_cuts(lid_width,lid_height);
        translate([lid_length/2-skirt_thickness-cut_epsilon,0,lid_height])
            rotate([0,90,0]) cylinder(r=thumb_radius,h=skirt_thickness+2*cut_epsilon);
    }
}

module contact_coupon(which) {
    intersection() {
        if (which == "tray") tray(); else lid();
        translate([-lid_length/2-cut_epsilon,crop_y,-cut_epsilon])
            cube([lid_length+2*cut_epsilon,coupon_depth,lid_height+tray_height+2*cut_epsilon]);
    }
}

module assembled_lid() {
    translate([0,0,tray_height+closed_gap+lid_thickness]) mirror([0,0,1]) lid();
}

if (part == "tray") tray();
else if (part == "lid") lid();
else if (part == "tray_coupon") contact_coupon("tray");
else if (part == "lid_coupon") contact_coupon("lid");
else if (part == "assembly") {
    color("SteelBlue") tray();
    color("LightSteelBlue",0.65) assembled_lid();
} else {
    color("SteelBlue") tray();
    translate([(tray_length+lid_length)/2+layout_gap,0,0]) color("LightSteelBlue") lid();
}
