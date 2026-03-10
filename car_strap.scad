$fn=128;

//car_strap(); //uncomment for 3d printing

module car_strap() {
show_others = true;  //set false for 3d printing
show_mount = true;

screw_gap_l = 20;
screw_gap_w = 20;
car_w = 27;
car_l = 45;
car_h = 10;
car_offset = 3;
rail_h = 8;
rail_w = 12;
rail_l = 200;
screw_d = 3 + .1; //m3 
screw_inset = 3.5;
mount_h = 5;
receiver_d = 54;
strap_w = 14;
strap_h = 2;



difference() {
    union() {
        //mount
        if (show_mount) {
            color("orange")
            translate([0,0,mount_h/2]) cube([car_l,car_w,mount_h], center=true);
        }
        if (show_others) {
            //rail
            color("purple") translate([-40,0,-rail_h/2  - car_h + car_offset]) cube([rail_l, rail_w, rail_h], center=true);

            //car
            color("grey") translate([0,0,-car_h/2]) cube([car_l, car_w, car_h], center=true);
        
            //receiver preview
            translate([0,0,29])  rotate([180,-90,0])  difference() {
                color(c = [0,0,1,.5]) cylinder(d=receiver_d,h=180,center=true);
                cylinder(d=receiver_d-1,h=180+1,center=true);
            }

            //strap preview
            color("brown") translate([0,0,29-mount_h/2]) rotate([0,90,0])
            difference() {
                cylinder(d=receiver_d+mount_h+strap_h,h=strap_w,center=true);
                cylinder(d=receiver_d+mount_h,h=strap_w+1,center=true);            }
        }

    }
    for (x = [-1:2:1]) {
        for (y = [-1:2:1]) {
            //car screw
            translate([x*screw_gap_l/2,y*screw_gap_w/2,-screw_inset]) cylinder(d=screw_d,h=20);
            //countersink
            translate([x*screw_gap_l/2,y*screw_gap_w/2,2]) cylinder(d=screw_d*2,h=20);
        }
    }
    //strap slot
    translate([0,0,strap_h/2]) cube([strap_w,100,strap_h],center=true);
    
    //receiver shape
    translate([0,0,29]) rotate([180,-90,0])  cylinder(d=receiver_d,h=180,center=true);
}
}

