// Original parametric design, millimetres. See README for assembly and fit checks.
// No meshes or source from the reference design are imported.
part = "assembly"; // [assembly,body,screw,shoe,thread_sample,screw_sample]
desk_thickness = 21.5;
body_width = 40;
saddle_length = 56;
thread_clearance = 0.35; // radial; print the sample before the full body
thread_axial_clearance = 0.15;
show_desk = true;
$fn = 64;

wall = 12;
top_wall = 10;
jaw_reach = 44;
screw_x = 24;
screw_diameter = 16;
thread_pitch = 4;
thread_depth = 1.2;
shaft_length = 28;
knob_height = 9;
knob_diameter = 30;
shoe_diameter = 28;
shoe_height = 6;
shoe_socket_depth = 3.2;
pilot_length = 4;
edge_radius = 0.8;
edge_segments = 12;
cable_groove_diameter = 8;
cable_groove_pitch = 12;
cable_groove_count = 3;
cable_rail_bottom = -41;
cable_tooth_top = -25;
cable_groove_center_z = -29;
cable_entry_inset = 4;
cable_rail_length = 48;
cable_spine_width = 8;
pad_allowance = 0; // optional nonprinted protective material on each contact
assembly_slack = 4;
gap = desk_thickness + 2*pad_allowance + shoe_height + assembly_slack;
lower_bottom = -gap-wall;
hook_root = -wall;
hook_tip = hook_root-saddle_length-10;
shoe_top = -desk_thickness-2*pad_allowance;
shoe_bottom = shoe_top-shoe_height;
screw_tip = shoe_bottom+shoe_socket_depth;
shaft_bottom = screw_tip-shaft_length;
eps = 0.02;

assert(desk_thickness>=18 && desk_thickness<=30,"desk_thickness must be 18..30 mm");
assert(body_width>=36 && body_width<=50,"body_width must be 36..50 mm");
assert(saddle_length>=45 && saddle_length<=65,"saddle_length must be 45..65 mm");
assert(thread_clearance>=0.2 && thread_clearance<=0.6,"thread_clearance must be 0.2..0.6 mm radial");
assert(thread_axial_clearance>=0.1 && thread_axial_clearance<=0.25,"thread_axial_clearance must be 0.1..0.25 mm");
assert(part=="assembly" || part=="body" || part=="screw" || part=="shoe" || part=="thread_sample" || part=="screw_sample","Unknown part selector");

// A trapezoidal helical ridge, clipped to length and joined into its root.
// Female thread uses this same profile with radial and axial clearances.
module thread(length, radial=0, axial=0) {
    root = screw_diameter/2-thread_depth;
    turns = ceil(length/thread_pitch)+2;
    steps = turns*40;
    z0 = -thread_pitch;
    profile = [[root-0.1+radial,-thread_pitch*0.40-axial],
               [screw_diameter/2+radial,-thread_pitch*0.10-axial],
               [screw_diameter/2+radial,thread_pitch*0.10+axial],
               [root-0.1+radial,thread_pitch*0.40+axial]];
    pts = [for(i=[0:steps],p=profile)
        [p[0]*cos(i*360/40),p[0]*sin(i*360/40),z0+i*thread_pitch/40+p[1]]];
    faces = concat([[3,2,1,0]],
        [for(i=[0:steps-1],j=[0:3],t=[0:1])
            t==0 ? [i*4+j,i*4+(j+1)%4,(i+1)*4+(j+1)%4] :
                   [i*4+j,(i+1)*4+(j+1)%4,(i+1)*4+j]],
        [[steps*4,steps*4+1,steps*4+2,steps*4+3]]);
    intersection() {
        union() {
            cylinder(r=root+radial,h=length);
            polyhedron(points=pts,faces=faces,convexity=12);
        }
        cylinder(r=screw_diameter/2+radial+0.1,h=length);
    }
}

module profile() {
    // Two offset pairs round convex corners and reinforce inside corners.
    offset(r=-1.5) offset(r=1.5)
    offset(r=1.5) offset(delta=-1.5)
    difference() {
        union() {
            polygon([[hook_tip,-17],[hook_tip,7],[hook_tip+10,7],
                [hook_tip+10,-5],[-wall,-5],[-wall,top_wall],
                [jaw_reach,top_wall],[jaw_reach,0],[0,0],[0,-gap],
                [jaw_reach,-gap],[jaw_reach,lower_bottom],[-wall,lower_bottom],
                [-wall,-34],[hook_tip+cable_entry_inset+cable_rail_length-cable_spine_width,-17]]);
            // Return rail joins the saddle at the clamp end; its outer end is open.
            translate([hook_tip+cable_entry_inset,cable_rail_bottom])
                square([cable_rail_length,cable_tooth_top-cable_rail_bottom]);
            translate([hook_tip+cable_entry_inset+cable_rail_length-cable_spine_width,
                       cable_rail_bottom])
                square([cable_spine_width,-14-cable_rail_bottom]);
        }
        for(i=[0:cable_groove_count-1])
            translate([hook_tip+cable_entry_inset+8+i*cable_groove_pitch,
                       cable_groove_center_z]) {
                circle(d=cable_groove_diameter);
                translate([-cable_groove_diameter/2,0])
                    square([cable_groove_diameter,cable_tooth_top-cable_groove_center_z+eps]);
            }
    }
}
module female_thread() {
    translate([0,0,-eps]) thread(wall+2*eps,thread_clearance,thread_axial_clearance);
    translate([0,0,-eps]) cylinder(h=1.5,r1=9,r2=7);
    translate([0,0,wall-1.5]) cylinder(h=1.5+eps,r1=7,r2=9);
}
module body() {
    difference() {
        // Round the body and underside cable rail before cutting the clamp thread.
        minkowski() {
            rotate([90,0,0]) linear_extrude(height=body_width-2*edge_radius,center=true)
                offset(delta=-edge_radius) profile();
            sphere(r=edge_radius,$fn=edge_segments);
        }
        translate([screw_x,0,lower_bottom]) female_thread();

    }
}
module screw(length=shaft_length) {
    union() {
        difference() {
            cylinder(d=knob_diameter,h=knob_height);
            for(a=[0:45:359]) rotate([0,0,a])
                translate([knob_diameter/2+1.2,0,-eps])
                    cylinder(d=6,h=knob_height+2*eps);
        }
        translate([0,0,knob_height-eps]) {
            intersection() {
                thread(length-pilot_length+eps);
                union() {
                    cylinder(d=screw_diameter+1,h=length-pilot_length-1);
                    translate([0,0,length-pilot_length-1]) cylinder(h=1.1,d1=screw_diameter+1,d2=12);
                }
            }
            // Smooth pilot bears on the shoe, keeping the thread off the desk.
            translate([0,0,length-pilot_length-eps]) cylinder(d=10,h=pilot_length+2*eps);
        }
    }
}
module shoe() {
    difference() {
        union() {
            cylinder(d1=shoe_diameter-1,d2=shoe_diameter,h=0.5);
            translate([0,0,0.5]) cylinder(d=shoe_diameter,h=shoe_height-1);
            translate([0,0,shoe_height-0.5]) cylinder(d1=shoe_diameter,d2=shoe_diameter-1,h=0.5);
        }
        // Flat desk face is down for printing. Blind socket opens upward.
        translate([0,0,shoe_height-shoe_socket_depth]) cylinder(d=10.8,h=shoe_socket_depth+eps);
        translate([0,0,shoe_height-0.7]) cylinder(d1=10.8,d2=12,h=0.7+eps);
    }
}
module thread_sample() {
    difference() {
        cylinder(d=26,h=wall);
        female_thread();
    }
}

if(part=="body") translate([0,0,body_width/2-edge_radius*(1-cos(180/edge_segments))])
    rotate([-90,0,0]) body();
if(part=="screw") screw();
if(part=="shoe") shoe();
// Same sideways hole orientation as the full body; flat base for support-free print.
if(part=="thread_sample") intersection() {
    translate([0,wall/2,12]) rotate([90,0,0]) thread_sample();
    translate([-20,-20,0]) cube([40,40,40]);
}
if(part=="screw_sample") screw(18);
if(part=="assembly") {
    color("#2e727d") body();
    color("#e8a34b") translate([screw_x,0,shaft_bottom-knob_height])
        rotate([0,0,(shaft_bottom-lower_bottom)*360/thread_pitch]) screw();
    color("#e8a34b") translate([screw_x,0,shoe_top]) rotate([180,0,0]) shoe();
    if(show_desk) %translate([3,-55,-desk_thickness-pad_allowance]) cube([95,110,desk_thickness]);
}
