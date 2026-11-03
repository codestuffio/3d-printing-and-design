// Millimeters. Example settings only; select pitch/depth from the actual sowing job.
part = "dibber"; // [dibber, contact_coupon, layout]
pitch = 30;
nominal_depth = 10;
pin_base_diameter = 6;
tip_diameter = 3;
tip_round = 0.6;
shoulder_diameter = 20;
shoulder_thickness = 3;
spine_width = 16;
spine_thickness = 5;
grip_clearance = 10; // Spine top to the shoulder's soil-contact plane.
spine_corner_radius = 4;
label_height = 0.5;
layout_gap = 10;
$fn = 96;

minimum_cleaning_gap = 6;
overlap = 0.05;
shoulder_z = spine_thickness + grip_clearance;
shoulder_bottom = shoulder_z - shoulder_thickness;
neck_radius = spine_width/2 - 1;
spine_length = 2*pitch + shoulder_diameter;

assert(part == "dibber" || part == "contact_coupon" || part == "layout", "Unknown part selector");
assert(pitch >= shoulder_diameter + minimum_cleaning_gap, "Shoulders need separated cleaning gaps");
assert(nominal_depth >= 2 && nominal_depth > 2*tip_round, "Nominal depth must leave a tapered pin");
assert(tip_diameter >= 2 && tip_round >= 0.3 && tip_round <= tip_diameter/4,
       "Tip must retain a broad flat and rounded edge");
assert(pin_base_diameter >= tip_diameter + 1 && shoulder_diameter >= pin_base_diameter + 8,
       "Pin taper and shoulder bearing must remain");
assert(spine_width >= 10 && spine_width <= shoulder_diameter && spine_thickness >= 3,
       "Spine must retain grip width and thickness");
assert(shoulder_thickness >= 2 && grip_clearance >= shoulder_thickness + 3,
       "Shoulder and neck must stay above the spine");
assert(spine_corner_radius >= 1 && spine_corner_radius <= spine_width/2,
       "Spine corner radius must preserve the profile");
assert(label_height > 0 && label_height < grip_clearance - shoulder_thickness,
       "Labels must remain below the shoulder contact plane");
assert(layout_gap >= 5 && $fn >= 48 && $fn % 4 == 0, "Layout and curve resolution must be usable");

module rounded_spine() {
    linear_extrude(height=spine_thickness)
        hull() for(x=[-1,1], y=[-1,1])
            translate([x*(spine_length/2-spine_corner_radius),
                       y*(spine_width/2-spine_corner_radius)]) circle(r=spine_corner_radius);
}

module working_pin() {
    rotate_extrude()
        polygon(concat([[0,0], [pin_base_diameter/2,0]],
            [for(a=[0:10:90]) [tip_diameter/2-tip_round+tip_round*cos(a),
                              nominal_depth-tip_round+tip_round*sin(a)]],
            [[0,nominal_depth]]));
}

module shoulder_pin() {
    translate([0,0,spine_thickness-overlap])
        cylinder(h=shoulder_bottom-spine_thickness+2*overlap,
                 r1=neck_radius, r2=shoulder_diameter/2);
    translate([0,0,shoulder_bottom])
        cylinder(h=shoulder_thickness, d=shoulder_diameter);
    translate([0,0,shoulder_z-overlap])
        cylinder(h=2*overlap, d=pin_base_diameter);
    translate([0,0,shoulder_z]) working_pin();
}

module body() {
    union() {
        rounded_spine();
        for(x=[-pitch,0,pitch]) translate([x,0,0]) shoulder_pin();
    }
}

module labels() {
    for(i=[0,1]) translate([(i-0.5)*pitch,0,spine_thickness-overlap])
        linear_extrude(height=label_height+overlap)
            resize([pitch-2*neck_radius-2,3])
                text(i == 0 ? str("P",pitch) : str("D",nominal_depth),
                     size=3, halign="center", valign="center", font="Liberation Sans");
}

module dibber() { union() { body(); labels(); } }

module contact_coupon() {
    intersection() {
        body();
        translate([-shoulder_diameter/2,-shoulder_diameter/2,-overlap])
            cube([shoulder_diameter,shoulder_diameter,shoulder_z+nominal_depth+2*overlap]);
    }
}

if(part == "dibber") dibber();
else if(part == "contact_coupon") contact_coupon();
else {
    dibber();
    translate([0,shoulder_diameter+layout_gap,0]) contact_coupon();
}
