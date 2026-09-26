// Desktop RC airplane stand — prototype, dimensions in mm.
// Select a printable part or the assembled layout. Measure pipe before printing.
part = "assembly"; // [assembly,corner,tee,cradle,fit_1,fit_075]
pipe_1_od = 33.40;
pipe_075_od = 26.67;
diametral_clearance = 0.50;
wall = 5;
stop_offset = 26; // hub center to pipe end; keeps blind bores separate
socket_depth = 35;
bolt_d = 4.5; // M4 through bolt, washers and locknut; drill PVC in assembled joint
base_length = 460; // corner center spacing, nose-tail direction
base_width = 340; // corner center spacing, left-right
post_centers = 180; // tee center to cradle center
arm_angle = 40; // outward from vertical; included V angle = 80 degrees
arm_cut = 140; // total length including inserted portion
noodle_od = 65; // visualization only: replace with measured diameter
noodle_length = 95;
$fn = $preview ? 40 : 80;

mouth = stop_offset + socket_depth;
big_r = (pipe_1_od + diametral_clearance)/2 + wall;
small_r = (pipe_075_od + diametral_clearance)/2 + wall;
base_z = big_r;
assert(wall >= 4 && socket_depth >= 30);
assert(diametral_clearance >= 0 && diametral_clearance <= 1.5);
assert(base_length > 2*mouth && base_width/2 > 2*mouth);
assert(post_centers > 2*mouth && arm_cut > socket_depth + noodle_length);
assert(arm_angle >= 30 && arm_angle <= 55);

// Orient local +Z along an arbitrary vector; local X/Y remain transverse.
module along(v) {
    rotate([0, acos(v[2]/norm(v)), atan2(v[1],v[0])]) children();
}
module socket_solid(v, od) {
    along(v) cylinder(h=mouth, d=od+diametral_clearance+2*wall);
}
module socket_void(v, od) {
    along(v) {
        translate([0,0,stop_offset]) cylinder(h=socket_depth+1,d=od+diametral_clearance);
        // Small entry chamfer.
        translate([0,0,mouth-1]) cylinder(h=2,d1=od+diametral_clearance,d2=od+diametral_clearance+4);
        translate([0,0,mouth-12]) rotate([90,0,0]) cylinder(h=od+2*wall+6,d=bolt_d,center=true);
    }
}
module connector(dirs, ods) {
    difference() {
        union() {
            sphere(r=big_r);
            for(i=[0:len(dirs)-1]) socket_solid(dirs[i],ods[i]);
        }
        for(i=[0:len(dirs)-1]) socket_void(dirs[i],ods[i]);
    }
}
module corner() { connector([[1,0,0],[0,1,0]],[pipe_1_od,pipe_1_od]); }
module tee() { connector([[1,0,0],[-1,0,0],[0,0,1]],[pipe_1_od,pipe_1_od,pipe_1_od]); }
module cradle() {
    connector([[0,0,-1],[sin(arm_angle),0,cos(arm_angle)],[-sin(arm_angle),0,cos(arm_angle)]],
              [pipe_1_od,pipe_075_od,pipe_075_od]);
}
module fit_ring(od) {
    difference() {
        cylinder(h=12,d=od+diametral_clearance+2*wall);
        translate([0,0,-1]) cylinder(h=14,d=od+diametral_clearance);
    }
}
module tube(v,length,od) {
    along(v) difference() {
        cylinder(h=length,d=od);
        translate([0,0,-1]) cylinder(h=length+2,d=od-5);
    }
}
module assembly() {
    // X = across airplane, Y = nose-tail, Z = up.
    for(y=[-base_length/2,base_length/2]) {
        for(x=[-base_width/2,base_width/2]) {
            translate([x,y,base_z])
                scale([x<0?1:-1,y<0?1:-1,1]) color("#334d60") corner();
        }
        translate([0,y,base_z]) {
            color("#334d60") tee();
            for(s=[-1,1]) color("#d6dce0")
                translate([s*stop_offset,0,0]) tube([s,0,0],base_width/2-2*stop_offset,pipe_1_od);
            color("#d6dce0") translate([0,0,stop_offset]) tube([0,0,1],post_centers-2*stop_offset,pipe_1_od);
            translate([0,0,post_centers]) {
                color("#334d60") cradle();
                for(s=[-1,1]) along([s*sin(arm_angle),0,cos(arm_angle)]) {
                    color("#d6dce0") translate([0,0,stop_offset]) tube([0,0,1],arm_cut,pipe_075_od);
                    // Foam extends 8 mm beyond the hard pipe tip.
                    color("#e8ce42") translate([0,0,stop_offset+arm_cut-noodle_length+8])
                        difference() {
                            cylinder(h=noodle_length,d=noodle_od);
                            translate([0,0,-1]) cylinder(h=noodle_length+2,d=pipe_075_od);
                        }
                }
            }
        }
    }
    for(x=[-base_width/2,base_width/2]) color("#d6dce0")
        translate([x,-base_length/2+stop_offset,base_z]) tube([0,1,0],base_length-2*stop_offset,pipe_1_od);
}
// Print parts flat on their side. Socket axes remain parallel to the bed;
// support the upper bore surfaces. Remove support before fitting pipe.
if(part=="assembly") assembly();
else if(part=="corner") translate([0,0,big_r]) corner();
else if(part=="tee") translate([0,0,big_r]) rotate([90,0,0]) tee();
else if(part=="cradle") translate([0,0,big_r]) rotate([90,0,0]) cradle();
else if(part=="fit_1") fit_ring(pipe_1_od);
else if(part=="fit_075") fit_ring(pipe_075_od);
else assert(false,"Unknown part selector");

echo(base_pipe_cuts=[base_length-2*stop_offset,base_width/2-2*stop_offset,post_centers-2*stop_offset]);
