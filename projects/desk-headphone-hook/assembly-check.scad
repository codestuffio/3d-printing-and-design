// Regression fixtures for the default 21.5 mm assembly, using exported meshes.
// Fixed expected placements are intentional: changing defaults requires review.
check = "body-screw";
module body() {
    rotate([90,0,0]) translate([0,0,-19.97274066]) import("exports/body.stl");
}
module screw(retract=0) {
    translate([24,0,-61.3-retract]) rotate([0,0,-792]) import("exports/screw.stl");
}
module shoe() {
    translate([24,0,-21.5]) rotate([180,0,0]) import("exports/shoe.stl");
}
module desk() { translate([3,-55,-21.5]) cube([95,110,21.5]); }
assert(check=="body-screw" || check=="body-desk" || check=="body-shoe" || check=="screw-shoe", "Unknown assembly check");
if(check=="body-screw") intersection() { body(); screw(); }
if(check=="body-desk") intersection() { body(); desk(); }
if(check=="body-shoe") intersection() { body(); shoe(); }
// Nominally the tip touches the socket floor. Retract 0.01 mm to distinguish
// intended planar contact from solid interference without a zero-volume STL.
if(check=="screw-shoe") intersection() { screw(0.01); shoe(); }
