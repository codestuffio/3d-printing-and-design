// One rigid desktop rocker. Units: mm. Print on a broad face.
belly_radius = 26;
cap_height = 12;
body_width = 22;
edge_round = 0.8;
face_depth = 0.8;
face = "both";              // "none", "front" (top in print), "both"
orientation = "print";      // "print" or "upright"
contact_segments = 192;      // divisible by 4, includes bottom contact vertex

// A circular lower half joins a half-ellipse at its widest points.
// Cap width follows the belly diameter so the join stays tangent.
cap_width = 2 * belly_radius;
round_steps = 6;
detail_segments = 24;
slice_thickness = 0.01;
cut_overlap = 0.02;
minimum_core = 2;
ideal_centroid_y = 4 * (cap_height - belly_radius) / (3 * PI);
half_steps = contact_segments / 2;
profile_points = concat(
    [for (i = [0:half_steps])
        [belly_radius * cos(180 + i * 180 / half_steps),
         belly_radius * sin(180 + i * 180 / half_steps)]],
    [for (i = [1:half_steps-1])
        [cap_width / 2 * cos(i * 180 / half_steps),
         cap_height * sin(i * 180 / half_steps)]]);

// Face dimensions scale with the profile; cuts stay far from the belly arc.
eye_spacing = belly_radius * 0.35;
eye_length = belly_radius * 0.24;
eye_y = cap_height * 0.25;
line_radius = belly_radius * 0.025;
mouth_length = belly_radius * 0.32;
mouth_y = -belly_radius * 0.16;

// The profile is convex and counterclockwise. Signed edge distances bound
// the entire capsule, so a facial recess stays inside the rounded face.
function profile_margin(p) = min([for (i = [0:len(profile_points)-1])
    let(a=profile_points[i], b=profile_points[(i+1)%len(profile_points)], e=b-a)
    (e.x * (p.y-a.y) - e.y * (p.x-a.x)) / norm(e)]);
face_centers = concat(
    [for (x = [-eye_spacing, eye_spacing], end = [-1, 1])
        [x + end * eye_length/2, eye_y]],
    [for (end = [-1, 1]) [end * mouth_length/2, mouth_y]]);
face_margin = min([for (p = face_centers) profile_margin(p)]) - line_radius;

assert(belly_radius > 0, "belly_radius must be positive");
assert(cap_height > 0 && cap_height < belly_radius,
       "cap_height must be positive and below belly_radius (ideal low mass)");
assert(body_width > minimum_core, "body_width must exceed minimum_core");
assert(edge_round >= 0 && edge_round < min(body_width / 2, cap_height / 2),
       "edge_round must leave the cap and width intact");
assert(contact_segments >= 48 && contact_segments == floor(contact_segments)
       && contact_segments % 4 == 0, "contact_segments must be >=48 and divisible by 4");
assert(face == "none" || face == "front" || face == "both", "Unknown face selector");
assert(orientation == "print" || orientation == "upright", "Unknown orientation");
assert(face_depth > 0 && 2 * face_depth <= body_width - minimum_core,
       "face_depth must preserve minimum_core between both faces");
assert(face == "none" || face_margin > edge_round,
       "face clearance must exceed edge_round; reduce rounding or use no face");

module profile() { polygon(profile_points); }

// Rounded broad-face edges, approximated by quarter-circle sections.
// The central width keeps the original circular belly contact profile.
module body() {
    if (edge_round == 0)
        linear_extrude(body_width) profile();
    else hull() {
        for (i = [0:round_steps]) {
            angle = i * 90 / round_steps;
            inset = edge_round * (1 - sin(angle));
            z = edge_round * (1 - cos(angle));
            translate([0, 0, z])
                linear_extrude(slice_thickness) offset(delta=-inset) profile();
            translate([0, 0, body_width - z - slice_thickness])
                linear_extrude(slice_thickness) offset(delta=-inset) profile();
        }
    }
}

module stroke(length) {
    hull() for (x = [-length/2, length/2])
        translate([x, 0]) circle(line_radius, $fn=detail_segments);
}

module expression() {
    for (x = [-eye_spacing, eye_spacing])
        translate([x, eye_y]) stroke(eye_length);
    translate([0, mouth_y]) stroke(mouth_length);
}

module potato() {
    difference() {
        body();
        if (face != "none")
            translate([0, 0, body_width - face_depth])
                linear_extrude(face_depth + cut_overlap) expression();
        if (face == "both")
            translate([0, 0, -cut_overlap])
                linear_extrude(face_depth + cut_overlap) expression();
    }
}

echo(ideal_uniform_unrounded_centroid_below_arc_center=-ideal_centroid_y);
// In upright coordinates: X rocking, Y width, Z vertical; bottom Z = 0.
if (orientation == "upright")
    translate([0, body_width/2, belly_radius]) rotate([90, 0, 0]) potato();
else potato();
