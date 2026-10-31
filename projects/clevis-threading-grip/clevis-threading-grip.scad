// Nominal examples only. Measure one spare fitting before choosing dimensions.
// Jaw plane: XY. Clevis/pushrod axis: Z. Opening: +X. Hold fitting still and move tool toward -X to remove.
part = "grip"; // grip, contact_coupon, layout
flat_spacing = 5.5; // fitting across flats, not thread diameter
flat_clearance = 0.15; // allowance per flat
contact_depth = 2.4; // must fit entirely inside the usable gripping length
entry_chamfer = 0.25;
arm_clearance_radius = 6.5; // measured arm/pin/keeper envelope plus allowance
head_radius = 9;
handle_length = 44; // axis to far end
handle_width = 14;
handle_thickness = 5.5;
handle_corner_radius = 3;
minimum_wall = 1.8;
coupon_back = 12; // crop behind the axis; jaw and relief stay identical
layout_gap = 8;
$fn = 96;
cut_epsilon = 0.02;

jaw_spacing = flat_spacing + 2*flat_clearance;
hex_radius = jaw_spacing/sqrt(3);

assert(part == "grip" || part == "contact_coupon" || part == "layout", "Unknown part");
assert(flat_spacing > 0 && flat_clearance > 0 && flat_clearance <= flat_spacing/10,
       "Flat size and clearance must be positive with limited play");
assert(contact_depth >= 1.2 && handle_thickness >= contact_depth,
       "Contact depth and handle thickness must preserve printable material");
assert(entry_chamfer > 0 && 2*entry_chamfer < contact_depth,
       "Chamfer must leave a straight contact band");
assert(minimum_wall >= 1.2 && head_radius - hex_radius - entry_chamfer >= minimum_wall,
       "Jaw must retain a continuous back and side wall");
assert(arm_clearance_radius > hex_radius + entry_chamfer &&
       head_radius - arm_clearance_radius >= minimum_wall,
       "Arm relief must clear the jaw and retain an outer wall");
assert(handle_width >= 2*minimum_wall && handle_width <= 2*head_radius &&
       handle_corner_radius > 0 && 2*handle_corner_radius < handle_width,
       "Handle must retain width and rounded ends");
assert(handle_length > head_radius + handle_width &&
       handle_length - arm_clearance_radius > 2*handle_corner_radius,
       "Handle must extend beyond the relief with a broad join");
assert(coupon_back >= head_radius && coupon_back < handle_length-handle_corner_radius,
       "Coupon must preserve the entire jaw and a rear bridge");
assert(layout_gap > 0 && cut_epsilon > 0 && cut_epsilon < entry_chamfer/2 && $fn >= 48,
       "Layout, resolution and cutting overlap must be valid");

module outer_profile() {
    union() {
        circle(r=head_radius);
        hull() for (x=[-handle_length+handle_corner_radius,-head_radius/2])
            for (y=[-handle_width/2+handle_corner_radius,handle_width/2-handle_corner_radius])
                translate([x,y]) circle(r=handle_corner_radius);
    }
}

module jaw_profile(extra=0) {
    offset(delta=extra) union() {
        polygon([for (a=[0:60:300]) [hex_radius*cos(a),hex_radius*sin(a)]]);
        translate([0,-jaw_spacing/2]) square([head_radius+cut_epsilon,jaw_spacing]);
    }
}

module relief_profile() {
    union() {
        circle(r=arm_clearance_radius);
        translate([0,-arm_clearance_radius])
            square([head_radius+cut_epsilon,2*arm_clearance_radius]);
    }
}

module jaw_void() {
    translate([0,0,-cut_epsilon]) linear_extrude(height=contact_depth+2*cut_epsilon)
        jaw_profile();
    hull() {
        translate([0,0,-cut_epsilon]) linear_extrude(height=cut_epsilon) jaw_profile(entry_chamfer);
        translate([0,0,entry_chamfer]) linear_extrude(height=cut_epsilon) jaw_profile();
    }
    hull() {
        translate([0,0,contact_depth-entry_chamfer-cut_epsilon]) linear_extrude(height=cut_epsilon) jaw_profile();
        translate([0,0,contact_depth]) linear_extrude(height=cut_epsilon) jaw_profile(entry_chamfer);
    }
}

module grip() {
    difference() {
        linear_extrude(height=handle_thickness) outer_profile();
        jaw_void();
        translate([0,0,contact_depth])
            linear_extrude(height=handle_thickness-contact_depth+cut_epsilon) relief_profile();
    }
}

module contact_coupon() {
    intersection() {
        grip();
        translate([-coupon_back,-head_radius-cut_epsilon,-cut_epsilon])
            cube([coupon_back+head_radius+cut_epsilon,2*(head_radius+cut_epsilon),
                  handle_thickness+2*cut_epsilon]);
    }
}

if (part == "grip") grip();
else if (part == "contact_coupon") contact_coupon();
else {
    grip();
    translate([0,2*head_radius+layout_gap,0]) contact_coupon();
}
