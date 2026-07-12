/* ============================================================
   Fertilizer bucket pump controller enclosure
   Parametric OpenSCAD — battery goes OUTSIDE (velcro), this box
   holds: rocker switch (panel mount), inline fuse, buck converter.

   HOW TO USE
   1. Update the "MEASURE YOURS" parameters below to match your
      actual buck converter board and fuse holder.
   2. Render (F6) then export STL per-part (see render calls at
      the bottom — comment/uncomment PART to export base vs lid).
   3. Print base and lid separately, standing on their open face
      (no supports needed for either).
   ============================================================ */

$fn = 48;

// ---------------- GENERAL ----------------
wall          = 2.2;   // shell wall thickness. Also used as the switch
                        // panel thickness -- most rocker switches are
                        // designed for a 1.5-3mm panel, so 2.2mm works
                        // directly without a separate boss.
corner_r      = 3;     // outer corner rounding radius
lid_lip_h     = 4;     // depth of the tongue-and-groove lip
fit_clearance = 0.25;  // gap between lid lip and base groove

// ---------------- BUCK CONVERTER — measured from actual board ----------------
buck_l = 54.5;  // board length (mm), long edge
buck_w = 24.3;  // board width (mm), short edge
buck_h = 17;    // tallest point incl. inductor / heatsink (mm)
buck_standoff_h = 5; // height of PCB support posts off the floor

// Two mounting holes, diagonal from each other, ~3mm dia
buck_hole_dia     = 3;    // PCB hole clearance diameter
buck_hole_short   = 8.5;  // hole center distance from the nearest SHORT edge
buck_hole_long    = 2.5;  // hole center distance from the nearest LONG edge
standoff_dia       = 6.5; // printed post outer diameter (must clear 3mm hole)
standoff_pilot_dia = 2.5; // blind pilot hole for a self-tapping screw
standoff_pilot_engagement = buck_standoff_h - 1; // leaves ~1mm solid base under the pilot hole

// ---------------- FUSE HOLDER ----------------
fuse_len = 32;  // inline blade fuse holder length
fuse_dia = 9;   // inline blade fuse holder diameter

// ---------------- CLEARANCE ----------------
gap = 6; // breathing room around components for wires + fingers

// ---------------- DERIVED BOX FOOTPRINT ----------------
inner_l = buck_l + fuse_len * 0.45 + gap * 2;
inner_w = max(buck_w, fuse_dia + 4) + gap * 2;
inner_h = max(buck_h + buck_standoff_h, fuse_dia) + gap;

box_l = inner_l + wall * 2;
box_w = inner_w + wall * 2;
box_h = inner_h + wall * 2 + lid_lip_h;

// ---------------- SWITCH CUTOUT (front wall, centered) ----------------
// Your measured hole: 8.6 x 13.25mm, retention ears stop at 15.28mm wide.
switch_hole_w   = 13.25 + 0.35; // + print tolerance so it press-fits snug
switch_hole_h   = 8.6   + 0.3;
switch_flange_w = 15.28 + 1.0;  // clearance pocket so the ears sit flush
switch_flange_h = 11.5;         // NOT measured -- verify your switch's
                                 // short-axis flange and update this
switch_pocket_depth = 1.0;      // shallow recess so the switch face sits flush

// ---------------- CABLE PASS-THROUGH ----------------
cable_hole_dia = 6.5;   // fits a small grommet or a hot-glue seal
cable_boss_h   = 6;     // printed strain-relief boss around the hole

// ============================================================
// BASE
// ============================================================
module rounded_rect(l, w, r) {
    hull() {
        for (x = [r, l - r])
            for (y = [r, w - r])
                translate([x, y, 0]) circle(r = r);
    }
}

module base_shell() {
    difference() {
        linear_extrude(height = box_h)
            rounded_rect(box_l, box_w, corner_r);
        translate([wall, wall, wall])
            linear_extrude(height = box_h)
                rounded_rect(box_l - wall * 2, box_w - wall * 2, max(corner_r - wall, 0.5));
    }
}

module lid_groove_cut() {
    // groove in the top inside edge of the base that the lid's lip drops into
    translate([wall - fit_clearance, wall - fit_clearance, box_h - lid_lip_h])
        linear_extrude(height = lid_lip_h + 1)
            rounded_rect(box_l - wall * 2 + fit_clearance * 2,
                         box_w - wall * 2 + fit_clearance * 2,
                         max(corner_r - wall, 0.5));
}

module screw_boss(h) {
    difference() {
        cylinder(h = h, d = 7);
        cylinder(h = h + 1, d = 2.6); // self-tap pilot for M3, or drill for a heat-set insert
    }
}

module screw_bosses(h) {
    inset = 8;
    for (x = [inset, box_l - inset])
        for (y = [inset, box_w - inset])
            translate([x, y, wall]) screw_boss(h - wall);
}

module switch_cutout() {
    // front wall is the wall at y = 0
    cx = box_l / 2;
    cz = wall + (inner_h) / 2 + wall; // vertical center, roughly mid-height of interior
    translate([cx, 0, cz]) {
        // through-hole
        rotate([-90, 0, 0])
            translate([-switch_hole_w / 2, -switch_hole_h / 2, -1])
                cube([switch_hole_w, switch_hole_h, wall + 2]);
        // shallow flush pocket on the outside face for the retention ears
        rotate([-90, 0, 0])
            translate([-switch_flange_w / 2, -switch_flange_h / 2, -0.1])
                cube([switch_flange_w, switch_flange_h, switch_pocket_depth + 0.1]);
    }
}

// board's bottom-left corner placement inside the enclosure, centered
// across the interior width
board_x0 = wall + gap;
board_y0 = wall + (box_w - wall * 2 - buck_w) / 2;

// the two diagonal hole centers, in world XY coordinates
buck_hole_a = [board_x0 + buck_hole_short,          board_y0 + buck_hole_long];
buck_hole_b = [board_x0 + buck_l - buck_hole_short, board_y0 + buck_w - buck_hole_long];

module buck_standoff_post(pos) {
    translate([pos[0], pos[1], wall])
        difference() {
            cylinder(h = buck_standoff_h, d = standoff_dia);
            // blind pilot hole from the top -- leaves solid material at
            // the base so the screw doesn't punch through the floor
            translate([0, 0, buck_standoff_h - standoff_pilot_engagement])
                cylinder(h = standoff_pilot_engagement + 1, d = standoff_pilot_dia);
        }
}

module buck_standoffs() {
    buck_standoff_post(buck_hole_a);
    buck_standoff_post(buck_hole_b);
}

cable_side = "right"; // which short end wall gets the cable hole: "right" (x = box_l) or "left" (x = 0)
cable_y = box_w / 2;                    // centered on the wall's width
cable_z = (box_h - lid_lip_h) * 0.5;    // centered below the lid groove zone

module cable_boss() {
    // raised collar on the OUTSIDE face for strain relief / grommet seat
    if (cable_side == "right") {
        translate([box_l, cable_y, cable_z])
            rotate([0, 90, 0])
                cylinder(h = cable_boss_h, d = cable_hole_dia + 4);
    } else {
        translate([0, cable_y, cable_z])
            rotate([0, -90, 0])
                cylinder(h = cable_boss_h, d = cable_hole_dia + 4);
    }
}

module cable_exit() {
    // through-hole: starts inside the wall, cuts through wall + boss
    if (cable_side == "right") {
        translate([box_l - wall - 1, cable_y, cable_z])
            rotate([0, 90, 0])
                cylinder(h = wall + cable_boss_h + 2, d = cable_hole_dia);
    } else {
        translate([wall + 1, cable_y, cable_z])
            rotate([0, -90, 0])
                cylinder(h = wall + cable_boss_h + 2, d = cable_hole_dia);
    }
}

module velcro_slots() {
    // two strap slots through the back wall to loop a velcro/strap
    // around the bucket rim or handle
    slot_w = 22; slot_h = 3.2;
    for (z = [box_h * 0.28, box_h * 0.72])
        translate([box_l / 2 - slot_w / 2, -1, z])
            cube([slot_w, wall + 2, slot_h]);
}

module base() {
    difference() {
        union() {
            base_shell();
            buck_standoffs();
            screw_bosses(box_h - lid_lip_h);
            cable_boss();
        }
        lid_groove_cut();
        switch_cutout();
        cable_exit();
        rotate([0,0,180]) translate([-box_l, -box_w, 0]) velcro_slots(); // back wall = y max
    }
}

// ============================================================
// LID
// ============================================================
module lid() {
    lid_h = 3;
    difference() {
        union() {
            linear_extrude(height = lid_h)
                rounded_rect(box_l, box_w, corner_r);
            // tongue that drops into the base groove
            translate([wall, wall, -lid_lip_h + 0.01])
                linear_extrude(height = lid_lip_h)
                    rounded_rect(box_l - wall * 2 - fit_clearance * 2,
                                 box_w - wall * 2 - fit_clearance * 2,
                                 max(corner_r - wall, 0.4));
        }
        // screw clearance holes matching base bosses
        inset = 8;
        for (x = [inset, box_l - inset])
            for (y = [inset, box_w - inset])
                translate([x, y, -1]) cylinder(h = lid_h + lid_lip_h + 2, d = 3.4);
    }
}

// ============================================================
// RENDER -- set PART to "base", "lid", or "both" (both = preview only)
// ============================================================
PART = "both";

if (PART == "base") {
    base();
} else if (PART == "lid") {
    lid();
} else {
    base();
    color("SteelBlue", 0.85)
        translate([0, 0, box_h + 10]) lid();
}
