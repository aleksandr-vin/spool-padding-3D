/*
 Spool padding clamps,
 2024
*/

$fa = 1;

thickness = 1; // wall thickness

outer_dia = 53; // wall outer diameter -- should fit into the spool
outer_dia_delta = 1;
outer_width = 10; // outer cylinder width
stopper_width = 2; // stopper width for spool
inner_dia = 30; // holder dia

module outer_ring() {
  difference() {
    cylinder(h = outer_width, d1 = outer_dia + outer_dia_delta, d2 = outer_dia - outer_dia_delta);
    translate([0,0,-1]) cylinder(h = outer_width + 2, d = outer_dia - thickness * 2);
  }
}

module inner_ring() {
  difference() {
    cylinder(h = thickness, d = inner_dia + thickness * 2);
    translate([0,0,-1]) cylinder(h = thickness + 2, d = inner_dia);
  }
}

// % outer_ring();
// % inner_ring();

module gen_support() {
  union()
  for (i = [0:(360/3):360]) {
    rotate([0,0,i])
      scale([(inner_dia + thickness * 2) / (outer_dia + outer_dia_delta),1,1])
        outer_ring();
  }
}

module sphere_cut() {
  r2 = (outer_dia - outer_dia_delta) / 2;
  r1 = inner_dia / 2;
  y = (r2 * r2 - r1 * r1 + outer_width * outer_width) / (2 * outer_width);
  sphere_r = sqrt(inner_dia * inner_dia + y * y);
  raise_ = sqrt(sphere_r * sphere_r - inner_dia * inner_dia / 4);
    translate([0,0, thickness + raise_]) sphere(r = sphere_r);
}

difference() {
  gen_support();
  sphere_cut();
}
