// UNMEASURED EXAMPLE dimensions; no standard RJ45 geometry is assumed.
// mm. +X approaches from cable side; -Z presses latch. See README datums.
part = "tool"; // tool, contact_coupon
handle_length = 35;
handle_width = 22;
handle_thickness = 3;
neck_length = 20;
neck_width = 7;
neck_thickness = 3;
junction_overlap = 3;
edge_radius = 0.7;
pad_length = 7;
pad_width = 5;
pad_offset = 3; // shoulder forward plane to pad rear edge, along +X
pad_drop = 1.5; // main underside Z=0 to pad contact plane, along -Z
shoulder_position = 12; // X of the forward stop face, from neck root X=0
shoulder_length = 2.5;
shoulder_width = 8;
shoulder_height = 5; // downward from Z=0; stop is for +X reach, not -Z force
minimum_section = 2; // example minimum retained solid section, not a strength rating
contact_margin = 0.5;
// Measured interface values relative to the shoulder's forward face:
latch_contact_start = 2; // along +X
latch_contact_end = 11;
latch_contact_width = 6;
latch_release_travel = 0.8; // measured downward travel to release
latch_plane_drop = 1.5; // latch contact plane at the chosen alignment, below Z=0
datum_band_bottom = -4.5; // firm external body face, in Z at chosen alignment
datum_band_top = -3;
datum_contact_width = 6; // centered firm face width in Y
socket_mouth_distance = 14; // shoulder face to socket mouth, along +X
allowed_insertion_depth = 12; // maximum allowed tool reach ahead of shoulder
socket_clearance = 2; // minimum distance behind socket mouth, along X
approach_start = 4; // narrow access corridor starts at this X
approach_gap = 10; // corridor width in Y
approach_height = 5; // corridor upper limit above Z=0
approach_depth = 6.5; // corridor lower limit below Z=0
side_clearance = 0.5;
vertical_clearance = 0.5;
coupon_grip_length = 16;
coupon_grip_width = 18;
$fn = 40;

pad_start = shoulder_position + pad_offset;
pad_end = pad_start + pad_length;
forward_end = max(neck_length, pad_end, shoulder_position);

assert(part == "tool" || part == "contact_coupon", "Unknown part selector");
assert(min(handle_length, handle_width, handle_thickness, neck_length,
           neck_width, neck_thickness, junction_overlap, edge_radius, pad_length,
           pad_width, pad_drop, shoulder_position, shoulder_length,
           shoulder_width, shoulder_height, minimum_section, contact_margin,
           latch_contact_width, latch_plane_drop, latch_release_travel, datum_contact_width,
           socket_mouth_distance, allowed_insertion_depth, socket_clearance,
           approach_start, approach_gap, approach_height, approach_depth,
           side_clearance, vertical_clearance, coupon_grip_length,
           coupon_grip_width) > 0, "Dimensions and clearances must be positive");
assert(min(neck_width, neck_thickness, handle_thickness, shoulder_length,
           shoulder_width, pad_length, pad_width) >= minimum_section,
       "Retain minimum neck, junction, pad and shoulder sections");
assert(min(handle_length, handle_width, neck_length, neck_width, pad_length,
           pad_width, shoulder_length, shoulder_width, coupon_grip_length,
           coupon_grip_width, neck_thickness + pad_drop) > 2*edge_radius,
       "Rounding must retain positive profiles and pad contact flats");
assert(handle_width >= neck_width + 2*edge_radius &&
       coupon_grip_width >= neck_width + 2*edge_radius &&
       junction_overlap >= minimum_section &&
       junction_overlap < min(handle_length, coupon_grip_length) - 2*edge_radius &&
       junction_overlap <= approach_start && approach_start < shoulder_position - shoulder_length,
       "Grip junction must overlap neck and remain behind approach corridor");
assert(pad_offset >= contact_margin &&
       pad_start >= latch_contact_start + shoulder_position + contact_margin &&
       pad_end <= latch_contact_end + shoulder_position - contact_margin &&
       pad_width + 2*contact_margin <= latch_contact_width &&
       abs(pad_drop - latch_plane_drop) < 0.0001,
       "Pad must fit measured exposed latch contact at chosen alignment");
// Reach the pad's flat core; nominal overlap can vanish under XYZ rounding.
assert(pad_start + edge_radius + minimum_section <= neck_length &&
       neck_length <= pad_end - edge_radius && pad_width <= neck_width,
       "Pad must overlap a solid neck and retain its rounded forward tip");
assert(shoulder_position - shoulder_length >= approach_start &&
       shoulder_position <= neck_length - edge_radius && shoulder_width >= neck_width &&
       datum_band_bottom < datum_band_top &&
       datum_band_top <= -(pad_drop + latch_release_travel) - contact_margin &&
       -shoulder_height <= datum_band_bottom &&
       neck_thickness - latch_release_travel >= datum_band_top &&
       shoulder_width - 2*edge_radius >= datum_contact_width,
       "Shoulder must be supported and cover firm datum below latch plane");
assert(forward_end - shoulder_position <= allowed_insertion_depth &&
       allowed_insertion_depth <= socket_mouth_distance - socket_clearance,
       "Forward reach must respect allowed insertion and socket-mouth clearance");
assert(max(neck_width, pad_width, shoulder_width) + 2*side_clearance <= approach_gap &&
       max(neck_thickness, handle_thickness) + vertical_clearance <= approach_height &&
       max(pad_drop, shoulder_height) + latch_release_travel + vertical_clearance <= approach_depth,
       "Contact assembly must fit measured approach corridor");

module rounded_profile(length, width) {
    translate([edge_radius, -width/2 + edge_radius])
        offset(r=edge_radius) square([length - 2*edge_radius, width - 2*edge_radius]);
}

module rounded_plate(start, length, width, height, bottom=0) {
    translate([start, 0, bottom]) linear_extrude(height)
        rounded_profile(length, width);
}

// Rounded in XYZ: a broad flat bottom remains, with blunt contact edges.
module latch_pad() {
    hull()
        for (x=[pad_start + edge_radius, pad_end - edge_radius])
            for (y=[-pad_width/2 + edge_radius, pad_width/2 - edge_radius])
                for (z=[-pad_drop + edge_radius, neck_thickness - edge_radius])
                    translate([x,y,z]) sphere(r=edge_radius);
}

module paddle(grip_length, grip_width) {
    union() {
        rounded_plate(junction_overlap - grip_length, grip_length,
                      grip_width, handle_thickness);
        rounded_plate(0, neck_length, neck_width, neck_thickness);
        // Front X face is flat except its Y corner rounds. No hook or clamp.
        rounded_plate(shoulder_position - shoulder_length, shoulder_length,
                      shoulder_width, shoulder_height + neck_thickness, -shoulder_height);
        latch_pad();
    }
}

if (part == "tool") paddle(handle_length, handle_width);
if (part == "contact_coupon") paddle(coupon_grip_length, coupon_grip_width);
