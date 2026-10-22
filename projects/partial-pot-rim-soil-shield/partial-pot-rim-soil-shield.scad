// Hand-held partial shield, millimeters. Nominal 6-inch EXAMPLE, not measured fit.
// Hold the grip throughout use; this is neither a clamp nor a pot handle.
part = "shield"; // [shield,contact_coupon]
pot_outer_radius = 76.2; // nominal 6-inch OUTSIDE rim diameter / 2
pot_inner_radius = 70.2; // EXAMPLE: measure the actual mouth and rim profile
rim_clearance = 1.0; // loose radial allowance, never an interference fit
arc_angle = 80;
wall_height = 45;
wall_thickness = 2.8;
ledge_thickness = 2.8; // thickness at the inward free drop edge
return_reach = 4; // inward beyond the measured inner rim
return_slope = 15; // degrees upward toward outside; mix returns inward
root_ball_radius = 62; // EXAMPLE clearance envelope, not plant validation
plant_clearance = 3;
grip_length = 30; // projection beyond outer wall
grip_width = 26;
grip_thickness = 5;
grip_overlap = 3;
grip_corner_radius = 6;
edge_radius = 0.6; // all exposed solid edges rounded by spherical dilation
coupon_angle = 16; // same radial contact profile, no grip
radial_facets = 96;
round_facets = 12;
grip_kernel_height = 0.01; // construction thickness; paired offsets are half this

wall_inner = pot_outer_radius + rim_clearance;
wall_outer = wall_inner + wall_thickness;
drop_radius = pot_inner_radius - return_reach;
function return_z(r) = ledge_thickness + (r-drop_radius)*tan(return_slope);

assert(part=="shield" || part=="contact_coupon", "Unknown part selector");
assert(pot_inner_radius>0 && pot_outer_radius>pot_inner_radius,
       "pot radii must be positive and outer greater than inner");
assert(rim_clearance>=0.5 && rim_clearance<=5, "rim_clearance must be 0.5..5");
assert(arc_angle>=30 && arc_angle<=120, "arc_angle must be 30..120");
assert(coupon_angle>=10 && coupon_angle<=20 && coupon_angle<arc_angle,
       "coupon_angle must be 10..20 and smaller than arc_angle");
assert(wall_height>=20 && wall_height<=80, "wall_height must be 20..80");
assert(wall_thickness>=2.4 && ledge_thickness>=2.4 && grip_thickness>=3,
       "wall, ledge and grip must preserve minimum thickness");
assert(return_reach>=2 && return_reach<=12, "return_reach must be 2..12");
assert(return_slope>=8 && return_slope<=30, "return_slope must be 8..30");
assert(root_ball_radius>=0 && plant_clearance>=2 &&
       drop_radius>=root_ball_radius+plant_clearance,
       "return edge must clear the declared plant envelope");
assert(grip_length>=20 && grip_length<=50 && grip_width>=18 && grip_width<=40,
       "grip length/width outside handled prototype range");
assert(grip_overlap>=2 && grip_overlap<=wall_thickness+rim_clearance,
       "grip_overlap must connect within the external wall/ledge");
assert(edge_radius>=0.3 &&
       2*edge_radius<min(wall_thickness,ledge_thickness) &&
       2*edge_radius+grip_kernel_height<grip_thickness,
       "edge_radius must leave an intact core");
assert(grip_corner_radius>edge_radius &&
       2*grip_corner_radius<min(grip_width,grip_length+grip_overlap),
       "grip_corner_radius must leave a rounded grip core");
assert(grip_thickness<=return_z(wall_outer),
       "grip top must stay below the outside return surface");
assert(radial_facets>=96 && radial_facets<=256 &&
       round_facets>=12 && round_facets<=32,
       "facet counts outside supported export range");

// Convex rounded sweep segments avoid a costly nonconvex whole-body Minkowski.
// Both ledge and wall use the same upward-outward top slope. Their overlapping
// volumes meet without a horizontal shelf on the soil-facing return path.
module rounded_segment(a0,a1,r0,r1,height) {
    hull() for(a=[a0,a1]) for(r=[r0,r1])
        for(z=[edge_radius,return_z(r)+height-edge_radius/cos(return_slope)])
            translate([r*cos(a),r*sin(a),z])
                sphere(r=edge_radius,$fn=round_facets);
}

module rounded_sector(angle) {
    segments = ceil(radial_facets*angle/360);
    for(i=[0:segments-1]) {
        a0 = -angle/2+i*angle/segments;
        a1 = -angle/2+(i+1)*angle/segments;
        rounded_segment(a0,a1,drop_radius+edge_radius,
                        wall_outer-edge_radius,0);
        // Stagger wall/ledge end planes by one rounding radius. Coincident
        // rounded end caps can serialize collinear zero-area STL triangles.
        end_angle = atan(edge_radius/wall_inner);
        w0 = a0-(i==0 ? end_angle : 0);
        w1 = a1+(i==segments-1 ? end_angle : 0);
        rounded_segment(w0,w1,wall_inner+edge_radius,
                        wall_outer-edge_radius,wall_height);
    }
}

module rounded_grip() {
    x0 = wall_outer-grip_overlap;
    x1 = wall_outer+grip_length;
    hull() for(x=[x0+grip_corner_radius,x1-grip_corner_radius])
        for(y=[-grip_width/2+grip_corner_radius,
                grip_width/2-grip_corner_radius])
            for(z=[edge_radius+grip_kernel_height/2,
                    grip_thickness-edge_radius-grip_kernel_height/2])
                translate([x,y,z])
                    // Rounded vertical ends plus eased upper/lower edges.
                    minkowski() {
                        cylinder(r=grip_corner_radius-edge_radius,h=grip_kernel_height,
                                 center=true,$fn=round_facets);
                        sphere(r=edge_radius,$fn=round_facets);
                    }
}

// OpenSCAD spheres omit the polar vertex; align their faceted lower plane
// with the bed rather than leaving a small first-layer gap.
round_floor = edge_radius*(1-cos(180/round_facets));
translate([0,0,-round_floor])
if(part=="shield") union() {
    rounded_sector(arc_angle);
    rounded_grip();
}
else rounded_sector(coupon_angle);
