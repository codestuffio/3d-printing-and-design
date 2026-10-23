// Geometric regression checks; each selected result must be empty.
use <desk-headphone-hook-watch.scad>
check="body-desk";
module exported_body() { rotate([90,0,0]) translate([0,0,-19.97274066]) import("exports/body.stl",convexity=16); }
module fitted_region() {
    translate([-10,0,58.69650192260742]) rotate([0,0,-90])
    multmatrix([[1,0,0,0],[0,sin(20),-cos(20),0],[0,cos(20),sin(20),0],[0,0,0,1]])
    translate([-17.5,-18,-35]) cube([35,38,22]);
}
module headphone_cable(x,z) { translate([x,0,z]) rotate([90,0,0]) cylinder(d=6,h=42,center=true,$fn=48); }
if(check=="body-desk") intersection() {exported_body(); desk();}
if(check=="body-screw") intersection() {exported_body(); screw();}
if(check=="body-shoe") intersection() {exported_body(); shoe();}
if(check=="fit-material-removed") intersection() {fitted_region(); difference() {reference_watch(); watch_body();}}
if(check=="fit-material-added") intersection() {fitted_region(); difference() {watch_body(); reference_watch();}}
// The straight added port clears a 14.5 x 6.3 mm envelope through the jaw
// and overlaps the supplied tunnel at its original bottom aperture.
if(check=="usb-jaw-port") intersection() {
    exported_body(); translate([4.1,-7.25,-0.1]) cube([6.3,14.5,16.2]);
}
if(check=="rear-cable") intersection() {
    exported_body(); translate([11.5,0,1.8]) rotate([0,90,0]) cylinder(d=3,h=34,$fn=48);
}
if(check=="headphone-cables") intersection() {
    exported_body(); union() {
        hull() {headphone_cable(-83,-21); headphone_cable(-42,-21);}
        for(i=[0:2]) hull() {headphone_cable(-66+i*12,-21); headphone_cable(-66+i*12,-29);}
    }
}
