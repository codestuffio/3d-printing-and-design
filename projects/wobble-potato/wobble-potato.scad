// One rigid desktop rocker. Units: mm. Print on a broad face.
belly_radius = 26;
cap_height = 20;
cap_lump = 0.05;             // subtle shoulder/top variation; 0..0.05
body_width = 34;
edge_round = 9;
face_depth = 0.8;
face = "both";              // "none", "front" (top in print), "both"
orientation = "print";      // "print" or "upright"
contact_segments = 192;      // divisible by 4, includes bottom contact vertex

// A circular lower half joins a fuller, gently uneven cap.
// Cap width follows the belly diameter so the join stays tangent.
cap_width = 2 * belly_radius;
round_steps = 6;
detail_segments = 24;
slice_thickness = 0.01;
cut_overlap = 0.02;
minimum_core = 2;
half_steps = contact_segments / 2;
profile_points = concat(
    [for (i = [0:half_steps])
        [belly_radius * cos(180 + i * 180 / half_steps),
         belly_radius * sin(180 + i * 180 / half_steps)]],
    [for (i = [1:half_steps-1])
        [cap_width / 2 * cos(i * 180 / half_steps),
         cap_height * sin(i * 180 / half_steps)
         * (1 + cap_lump * pow(sin(i * 180 / half_steps), 2)
            * cos(4 * i * 180 / half_steps))]]);

// Fuller oval shoulders expand the upper body while the central circle
// remains the support surface within +/-15 degrees near upright.
shoulder_x = belly_radius * 0.72;
shoulder_rx = belly_radius * 0.75;
shoulder_ry = cap_height * 0.83;
shoulder_y = -belly_radius * 0.015;
contact_angle = 15;
shoulder_support = shoulder_x * sin(contact_angle)
    + sqrt(pow(shoulder_rx * sin(contact_angle), 2)
           + pow(shoulder_ry * cos(contact_angle), 2))
    - shoulder_y * cos(contact_angle);
// The polygon's inradius accounts for faceting between circular vertices.
contact_support = belly_radius * cos(180 / contact_segments);

// Face dimensions scale with the profile; cuts stay far from the belly arc.
eye_spacing = belly_radius * 0.35;
eye_radius = belly_radius * 0.08;
eye_y = cap_height * 0.25;
line_radius = belly_radius * 0.025;
mouth_length = belly_radius * 0.32;
mouth_y = -belly_radius * 0.16;
mouth_sag = belly_radius * 0.04;
mouth_steps = 12;
dimple_radius = belly_radius * 0.035;
// Sparse paired potato eyes on the skin, separate from the cartoon face.
dimple_centers = [for (side = [-1, 1], p = [[0.48, 0.20], [0.45, -0.28], [0.18, -0.50]])
    [side * belly_radius * p.x, belly_radius * p.y]];
mouth_points = [for (i = [0:mouth_steps])
    let(x = mouth_length * (i / mouth_steps - 0.5))
    [x, mouth_y + mouth_sag * pow(2*x/mouth_length, 2)]];

// The central profile is convex and counterclockwise. Keeping every recess
// within its inset is a conservative bound for the larger shoulder hull.
function profile_margin(p) = min([for (i = [0:len(profile_points)-1])
    let(a=profile_points[i], b=profile_points[(i+1)%len(profile_points)], e=b-a)
    (e.x * (p.y-a.y) - e.y * (p.x-a.x)) / norm(e)]);
face_margin = min(
    min([for (x = [-eye_spacing, eye_spacing]) profile_margin([x, eye_y])]) - eye_radius,
    min([for (p = mouth_points) profile_margin(p)]) - line_radius,
    min([for (p = dimple_centers) profile_margin(p)]) - dimple_radius);

assert(belly_radius > 0, "belly_radius must be positive");
assert(cap_height > 0 && cap_height < belly_radius,
       "cap_height must be positive and below belly_radius (ideal low mass)");
assert(cap_lump >= 0 && cap_lump <= 0.05, "cap_lump must be between 0 and 0.05");
assert(cap_height * (1 + cap_lump) < belly_radius,
       "cap_height and cap_lump must keep the top below belly_radius");
assert(shoulder_support < contact_support,
       "shoulders must preserve the circular contact arc through 15 degrees");
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

module profile() {
    hull() {
        polygon(profile_points);
        for (side = [-1, 1]) translate([side * shoulder_x, shoulder_y])
            scale([shoulder_rx, shoulder_ry]) circle(1, $fn=contact_segments);
    }
}

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

module expression() {
    for (x = [-eye_spacing, eye_spacing])
        translate([x, eye_y]) circle(eye_radius, $fn=detail_segments);
    for (i = [0:mouth_steps-1]) hull() {
        translate(mouth_points[i]) circle(line_radius, $fn=detail_segments);
        translate(mouth_points[i+1]) circle(line_radius, $fn=detail_segments);
    }
    for (p = dimple_centers)
        translate(p) scale([1, 0.7]) circle(dimple_radius, $fn=detail_segments);
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

echo(circular_contact_angle_degrees=contact_angle);
// In upright coordinates: X rocking, Y width, Z vertical; bottom Z = 0.
if (orientation == "upright")
    translate([0, body_width/2, belly_radius]) rotate([90, 0, 0]) potato();
else potato();
