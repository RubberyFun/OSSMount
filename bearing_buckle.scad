include <BOSL2/std.scad>
include <car_strap.scad>

$fn=128;
buckle_d = 20;
buckle_w = 100;
strap_h = 53;
strap_w = 5;
wall = 3;
buckle_h = strap_h + wall*2;
bearing_w = 12;
bearing_h = 8;
screw_offset = 12;
screw_d = 4 + .1; //m4
show_receiver = true; //set false for 3d printing

points = [
    [0,0],
    [0,wall*2],
    [buckle_w/2,buckle_d],
    [buckle_w,wall*2],
    [buckle_w,0],
];


color("orange")
difference() {
     //translate([-buckle_w/2,0,0]) linear_extrude(height=buckle_h, center=true) polygon(points);
     intersection() {
        translate([0,buckle_d/2,0]) cuboid([buckle_w, buckle_d, buckle_h], rounding=3, center=true);
        translate([0,-80,0]) cylinder(h=buckle_h,d=buckle_w*2,center=true);
     }
    translate([0,buckle_d+wall,-buckle_h/2 + wall*2 + bearing_h/2]) rotate([-90,0,0]) cube([bearing_w, bearing_h, buckle_d*2],center=true);
     
    //screw hole
    translate([0,screw_offset+wall,-wall-1]) cylinder(d=screw_d,h=buckle_h-wall*2,center=true);
     
    //strap slots
    for (x = [-1,1]) {
        translate([x*(-buckle_w/2+wall*2),0,0]) rotate([0,0,x*60]) cube([buckle_w,strap_w,strap_h],center=true);
        translate([x*(-buckle_w/2+wall*4 + strap_w),0,0]) rotate([0,0,x*60]) cube([buckle_w,strap_w,strap_h],center=true);
    }
}

if (show_receiver) {
   translate([0,150,-buckle_h/2]) rotate([0,180,-90]) car_strap();
   
   //belt
   color("black")
   translate([0,-132,0]) difference() {
    cylinder(d=300, h = strap_h,center=true);
    cylinder(d=300-1, h = strap_h+1,center=true);
   }
   
   //screw
   color("grey")
   translate([0,screw_offset+wall,-wall-6]) {
       cylinder(d=screw_d,h=buckle_h-wall*2,center=true);
       translate([0,0,-buckle_h/2 + 3]) cylinder(d=screw_d*2,h=2,center=true);
   }

}

