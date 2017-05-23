
width_lane=50;
thickness_base=10;
thickness_top=20;
length_lane=200;
nb_cylinders=3;
//cylinder_radius=(length_lane/nb_cylinders)/2;
cylinder_radius=90;
nb_lanes=6;


bottom_lane=[[0,0],
    [width_lane,0],
    [width_lane,thickness_base],
    [width_lane/2,thickness_top],
    [0,thickness_base]];
module lane() {
difference() {
    linear_extrude(height = length_lane,
            center = false,
            convexity = 0,
            twist = 0) {
        polygon(bottom_lane);
    }

    for (a=[0:nb_cylinders]) {
        echo(a);
        translate([0,
                cylinder_radius+thickness_base,
                (length_lane/nb_cylinders)*a]) {
             rotate(a=[90,0,90]) {
                cylinder(h = width_lane,
                    r1 = cylinder_radius,
                    r2 = cylinder_radius,
                    center = true/false);
            }
        }
    }
}
}
for (a=[0:nb_lanes]) {
    translate([a*width_lane,0,0]) {
        lane();
    }
}

