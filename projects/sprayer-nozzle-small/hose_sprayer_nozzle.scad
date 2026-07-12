// =====================================================================
// Low-Pressure Hose Sprayer Nozzle
// Fits: 8.2mm OD / 5.54mm ID clear vinyl tubing
//
// DESIGN LOGIC:
// A weak pump can't add pressure, but it CAN be helped by physics:
// continuity (A1*V1 = A2*V2) means narrowing the exit orifice raises
// exit velocity for whatever flow the pump can push. Too small an
// orifice raises back-pressure and chokes flow, too big and you're
// back to a dribble. orifice_d below is the one variable worth
// re-printing at a few sizes to find your pump's sweet spot.
//
// PRINT ORIENTATION: print as-oriented (barb end down on the bed,
// tip pointing up). The internal bore only ever gets SMALLER as it
// goes up, so it's fully self-supporting -- no supports needed.
//
// MATERIAL: PETG or ASA recommended over PLA -- this part lives
// outside, in the sun, wet, with fertilizer running through it.
// PLA will get brittle and swell over a season.
//
// AFTER PRINTING: FDM-printed round holes usually print slightly
// undersized. Ream the orifice out with a drill bit matching
// orifice_d (or the next size up) for a true, clean, consistent hole.
// =====================================================================

/* [Hose Fit] */
hose_od = 8.2;      // measured outer diameter of your tubing (mm)
hose_id = 5.54;     // measured inner diameter of your tubing (mm)

/* [Barb - grips the hose] */
barb_count    = 3;         // number of ridges
barb_pitch    = 3.2;       // mm between ridge peaks
barb_peak_d   = 6.6;       // ridge peak diameter (stretches the ID for a seal)
barb_valley_d = 5.6;       // ridge valley diameter (just above hose ID)
barb_lead_in  = 1.5;       // entry chamfer length, eases hose install
barb_bore_d   = 3.6;       // channel through the barb (not the flow bottleneck)

/* [Grip - hex for fingers/pliers] */
grip_af       = 11;        // hex across-flats
grip_length   = 7;

/* [Nozzle Taper - THE PART THAT MATTERS] */
taper_length  = 14;        // gentle taper = less turbulence = better throw
orifice_d     = 2.0;       // *** re-print at 1.5 / 2.0 / 2.5 / 3.0 and test ***
tip_outer_d   = 4.5;       // outer diameter at the very tip
land_length   = max(1.2, orifice_d * 1.5); // straight "aiming" section at the exit

/* [Internal flow straightener - reduces swirl for a tighter jet] */
add_straightener = true;
fin_thickness     = 0.8;

/* [Print Quality] */
$fn = 80;

// ---------------------------------------------------------------------
// derived geometry
transition_length = 3;
barb_len = barb_count * barb_pitch;
hex_od = grip_af / cos(30);   // across-flats -> circumdiameter

module barb() {
    // lead-in chamfer so the hose starts easily
    cylinder(h = barb_lead_in, d1 = 4.8, d2 = barb_valley_d);
    // alternating valley -> peak -> valley ridges
    for (i = [0 : barb_count - 1]) {
        z = barb_lead_in + i * barb_pitch;
        translate([0, 0, z])
            cylinder(h = barb_pitch / 2, d1 = barb_valley_d, d2 = barb_peak_d);
        translate([0, 0, z + barb_pitch / 2])
            cylinder(h = barb_pitch / 2, d1 = barb_peak_d, d2 = barb_valley_d);
    }
}

module body_outer() {
    barb();

    z1 = barb_lead_in + barb_len;
    translate([0, 0, z1])
        cylinder(h = transition_length, d1 = barb_valley_d, d2 = hex_od);

    z2 = z1 + transition_length;
    translate([0, 0, z2])
        cylinder(h = grip_length, d = hex_od, $fn = 6);

    z3 = z2 + grip_length;
    translate([0, 0, z3])
        cylinder(h = taper_length, d1 = hex_od, d2 = tip_outer_d);

    z4 = z3 + taper_length;
    translate([0, 0, z4])
        cylinder(h = land_length, d = tip_outer_d);
}

module bore() {
    eps = 0.5;
    z_taper_start = barb_lead_in + barb_len + transition_length + grip_length;

    // straight channel from below the barb up to the start of the taper
    translate([0, 0, -eps])
        cylinder(h = z_taper_start + eps, d = barb_bore_d);

    // converging taper -- this is what raises exit velocity
    translate([0, 0, z_taper_start])
        cylinder(h = taper_length, d1 = barb_bore_d, d2 = orifice_d);

    // orifice land, poking through the tip face to guarantee a clean hole
    z_land = z_taper_start + taper_length;
    translate([0, 0, z_land])
        cylinder(h = land_length + eps, d = orifice_d);
}

module straightener() {
    z_taper_start = barb_lead_in + barb_len + transition_length + grip_length;
    fin_h = 2;
    fin_d = barb_bore_d + 0.6; // slight overlap so it fuses to the wall
    translate([0, 0, z_taper_start - 4])
        intersection() {
            union() {
                cube([fin_thickness, fin_d, fin_h], center = true);
                cube([fin_d, fin_thickness, fin_h], center = true);
            }
            cylinder(h = fin_h, d = fin_d, center = true, $fn = 40);
        }
}

module nozzle() {
    difference() {
        body_outer();
        bore();
    }
    if (add_straightener) {
        straightener();
    }
}

nozzle();
