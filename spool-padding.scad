/*
 Spool padding clamps,
 2024
*/

$fa = 1;

thickness = 1; // wall thickness
outer_dia = 51; // wall outer diameter -- should fit into the spool
outer_dia_border = 5;
inner_dia = 30; // holder dia
spindel_len = 85;


module fig() {
  difference() {
    union() {
      cylinder(h = thickness, d = outer_dia + outer_dia_border);
      cylinder(h = spindel_len, d = outer_dia);
    }
    translate([0,0,-spindel_len * 0.05]) cylinder(h = spindel_len * 1.1, d = inner_dia * 1.05);
  }
}

difference() {
  fig();
  translate([-spindel_len/2, 0, -spindel_len/2]) cube([spindel_len, spindel_len, spindel_len * 2]);
}
