// A 6 mm cable must enter from outside the hook and lower into every groove.
// Check actual exported bodies at the nominal and supported size boundaries.
check = "cable-default";
assert(check=="cable-default" || check=="cable-thin" || check=="cable-large", "Unknown cable check");
width = check=="cable-thin" ? 36 : check=="cable-large" ? 50 : 40;
saddle = check=="cable-thin" ? 45 : check=="cable-large" ? 65 : 56;
mesh = check=="cable-thin" ? "exports/body-thin.stl" :
       check=="cable-large" ? "exports/body-large.stl" : "exports/body.stl";
tip = -12-saddle-10;
module cable(x,z) {
    translate([x,0,z]) rotate([90,0,0]) cylinder(d=6,h=width+2,center=true,$fn=48);
}
intersection() {
    rotate([90,0,0]) translate([0,0,-(width/2-0.8*(1-cos(15)))]) import(mesh);
    union() {
        hull() { cable(tip-5,-21); cable(tip+36,-21); }
        for(i=[0:2]) hull() {
            cable(tip+12+i*12,-21);
            cable(tip+12+i*12,-29);
        }
    }
}
