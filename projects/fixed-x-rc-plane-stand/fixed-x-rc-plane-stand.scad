// Two identical printed hubs + four continuous legs + one spine. Units: mm.
part = "assembly"; // [assembly,hub,fit_samples]
leg_od = 21.34; // nominal 1/2 inch US IPS PVC: measure your stock
spine_od = 26.67; // nominal 3/4 inch US IPS PVC
leg_clearance = 0.80; // diametral; extra room for support-scarred channels
spine_clearance = 0.50; // diametral; vertical socket
wall = 5;
angle = 40; // each leg from vertical, 80-degree included V
channel_length = 90;
web = 10; // solid distance between the two crossing bores
spine_depth = 35;
bolt_d = 4.5; // M4 bolts through printed hub AND drilled PVC
leg_bolt_t = -30; // distance along leg axis from crossing, toward foot
station_spacing = 460;
leg_length = 420;
foot_to_crossing = 230;
noodle_od = 65;
noodle_length = 110;
noodle_overhang = 8;
print_flat = 1; // shave rear exterior only to establish bed contact
$fn = $preview ? 40 : 80;

leg_bore = leg_od + leg_clearance;
leg_r = leg_bore/2 + wall;
spine_r = (spine_od+spine_clearance)/2 + wall;
offset = (leg_bore+web)/2; // crossed pipes occupy separate fore/aft planes
spine_stop = offset + leg_bore/2 + wall + 5;
spine_mouth = spine_stop + spine_depth;
spine_cut = station_spacing - 2*spine_stop;
hub_height = foot_to_crossing*cos(angle) + leg_od/2*sin(angle);
upper = leg_length-foot_to_crossing;
rear_face = -offset-leg_r+print_flat;

assert(angle >= 30 && angle <= 50);
assert(wall >= 5 && web >= 8 && print_flat <= 1 && print_flat >= 0);
assert(leg_clearance >= 0 && leg_clearance <= 1.5);
assert(spine_clearance >= 0 && spine_clearance <= 1.5);
assert(station_spacing > 2*spine_mouth);
assert(upper > channel_length/2 + noodle_length);
assert(foot_to_crossing > channel_length/2 + 20);
assert(abs(leg_bolt_t) < channel_length/2-10);
assert(abs(leg_bolt_t)*sin(2*angle) > leg_bore/2+bolt_d/2+wall);
assert(abs(leg_bolt_t) > spine_r+bolt_d/2);
assert(noodle_od > leg_od && spine_depth >= 30);

module along(v) { rotate([0,acos(v[2]/norm(v)),atan2(v[1],v[0])]) children(); }
module leg_axis(s) { translate([0,s*offset,0]) rotate([0,s*angle,0]) children(); }
module hub() {
    difference() {
        intersection() {
            union() {
                // Hull joins both sleeves into one rigid body.
                hull() for(s=[-1,1]) leg_axis(s)
                    cylinder(h=channel_length,r=leg_r,center=true);
                along([0,1,0]) cylinder(h=spine_mouth,r=spine_r);
            }
            // Flat rear face, also used as the print bed face.
            translate([-200,rear_face,-200]) cube([400,400,400]);
        }
        for(s=[-1,1]) {
            leg_axis(s) cylinder(h=channel_length+20,d=leg_bore,center=true);
            // Through-bolt axes run fore/aft; the opposite pipe is clear.
            translate([s*leg_bolt_t*sin(angle),0,leg_bolt_t*cos(angle)])
                along([0,1,0]) cylinder(h=200,d=bolt_d,center=true);
        }
        along([0,1,0]) {
            translate([0,0,spine_stop]) cylinder(h=spine_depth+1,d=spine_od+spine_clearance);
            translate([0,0,spine_mouth-1]) cylinder(h=2,d1=spine_od+spine_clearance,d2=spine_od+spine_clearance+4);
        }
        translate([0,spine_mouth-12,0]) rotate([0,90,0]) cylinder(h=100,d=bolt_d,center=true);
    }
}
module ring(od, fit_clearance) {
    difference() {
        cylinder(h=12,d=od+fit_clearance+2*wall);
        translate([0,0,-1]) cylinder(h=14,d=od+fit_clearance);
    }
}
module pipe(length,od) {
    difference() {
        cylinder(h=length,d=od);
        translate([0,0,-1]) cylinder(h=length+2,d=od-5);
    }
}
module end_support() {
    color("#334d60") hub();
    for(s=[-1,1]) leg_axis(s) {
        color("#d6dce0") translate([0,0,-foot_to_crossing]) pipe(leg_length,leg_od);
        color("#e8ce42") translate([0,0,upper+noodle_overhang-noodle_length])
            difference() {
                cylinder(h=noodle_length,d=noodle_od);
                translate([0,0,-1]) cylinder(h=noodle_length+2,d=leg_od);
            }
    }
}
module assembly() {
    translate([0,-station_spacing/2,hub_height]) end_support();
    translate([0,station_spacing/2,hub_height]) rotate([0,0,180]) end_support();
    color("#d6dce0") translate([0,-station_spacing/2+spine_stop,hub_height])
        along([0,1,0]) pipe(spine_cut,spine_od);
}
if(part=="assembly") assembly();
else if(part=="hub") translate([0,0,-rear_face]) rotate([90,0,0]) hub();
else if(part=="fit_samples") {
    ring(leg_od, leg_clearance);
    translate([leg_od/2+spine_od/2+2*wall+10,0,0]) ring(spine_od, spine_clearance);
} else assert(false,"Unknown part selector");

echo(spine_cut=spine_cut, leg_cut=leg_length, hub_center_height=hub_height);
