// Version 2: validated 21.5 mm headphone clamp plus the supplied fitted watch head.
// Reference STLs are local immutable inputs; source provenance is in README.md.
part = "assembly"; // [assembly,body,watch_fit_sample]
show_desk = true;
show_access = false;
clamp_width = 39.94548132;
base_print_offset = 19.97274066;
watch_x_offset = -10;
watch_base_z = 15.95;
reference_base_z = -42.74650192260742;
top_jaw_height = 16;
usb_port_x0 = -3;
usb_port_x1 = 12;
usb_port_width = 16;
cable_diameter = 3.6;
$fn = 64;
eps = 0.02;

assert(part=="assembly" || part=="body" || part=="watch_fit_sample", "Unknown part selector");
assert(clamp_width>=39.9 && clamp_width<=40, "clamp_width must preserve the fixed base width");
assert(usb_port_width>=15 && usb_port_width<=17, "USB opening must remain 15..17 mm wide");
assert(cable_diameter>=3.2 && cable_diameter<=4, "Cable route diameter must remain 3.2..4 mm");

module base_body() {
    rotate([90,0,0]) translate([0,0,-base_print_offset])
        import("reference/headphone-hook-body.stl",convexity=16);
}
module reference_watch() {
    translate([watch_x_offset,0,watch_base_z-reference_base_z]) rotate([0,0,-90])
        import("reference/apple-watch-stand-big-usb.stl",convexity=16);
}
module trimmed_watch() {
    intersection() {
        reference_watch();
        translate([-12,-clamp_width/2,watch_base_z-eps])
            cube([56,clamp_width,70]);
    }
}
module usb_port() {
    translate([usb_port_x0,-usb_port_width/2,-eps])
        cube([usb_port_x1-usb_port_x0,usb_port_width,top_jaw_height+2*eps]);
}
module underside_cable_route() {
    translate([usb_port_x0,0,cable_diameter/2]) rotate([0,90,0])
        cylinder(d=cable_diameter,h=46-usb_port_x0);
    translate([usb_port_x0,-cable_diameter/2,-eps])
        cube([46-usb_port_x0,cable_diameter,cable_diameter/2+eps]);
}
module watch_body() {
    difference() {
        union() {
            base_body();
            // Thicken the top jaw before adding its USB opening and cable groove.
            translate([-12,-clamp_width/2,9.5]) cube([56,clamp_width,top_jaw_height-9.5]);
            trimmed_watch();
        }
        usb_port();
        underside_cable_route();
    }
}
module watch_fit_sample() {
    // Full fitted head and notch, clipped above its broad lower base.
    intersection() {
        trimmed_watch();
        translate([-15,-clamp_width/2,watch_base_z+17]) cube([65,clamp_width,60]);
    }
}
module screw() {
    translate([24,0,-61.3]) rotate([0,0,-792])
        import("exports/screw.stl",convexity=12);
}
module shoe() {
    translate([24,0,-21.5]) rotate([180,0,0])
        import("exports/shoe.stl");
}
module desk() { translate([3,-55,-21.5]) cube([95,110,21.5]); }

if(part=="body") translate([0,0,clamp_width/2]) rotate([-90,0,0]) watch_body();
if(part=="watch_fit_sample") translate([0,0,clamp_width/2]) rotate([-90,0,0]) watch_fit_sample();
if(part=="assembly") {
    color("#2e727d") watch_body();
    color("#e8a34b") screw();
    color("#e8a34b") shoe();
    if(show_desk) %desk();
    if(show_access) #underside_cable_route();
}
