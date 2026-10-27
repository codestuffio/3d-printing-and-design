// Interference check against a simplified model of the existing half.
// Render with show = "clash": an empty result means the lap fits.
// show = "both" draws the two halves together for a visual check.

include <planter-stand-crossbar.scad>

part = "none";
show = "both";  // "both" or "clash"

// The existing half runs along Y with its notch opening down at the center.
module existing_half() {
    rotate([0, 0, 90]) difference() {
        union() {
            rotate([90, 0, 0])
                linear_extrude(height = beam_thick, center = true)
                    polygon([
                        [-pole_x, 0], [pole_x, 0],
                        [pole_x, beam_h_end], [slant_end, beam_h_end],
                        [slant_start, beam_h_mid], [-slant_start, beam_h_mid],
                        [-slant_end, beam_h_end], [-pole_x, beam_h_end]
                    ]);
            translate([-existing_notch_len / 2 - 5, -existing_hub_thick / 2, 0])
                cube([existing_notch_len + 10, existing_hub_thick, beam_h_mid]);
        }
        translate([-existing_notch_len / 2, -existing_hub_thick, -1])
            cube([existing_notch_len, 2 * existing_hub_thick, existing_notch_top + 1]);
    }
    translate([0, 0, existing_notch_top - boss_h])
        cylinder(h = boss_h, d = boss_d);
}

if (show == "clash")
    intersection() { existing_half(); crossbar(); }
else {
    color("black") existing_half();
    color("orange") crossbar();
}
