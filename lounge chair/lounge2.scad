
angle_body_head=145;
angle_body_rest=136;

//angle_body_floor=27;
angle_body_floor=27;

length_head=33;
length_body=57;
length_rest=47;

thickness_wood=1;
thickness_stretcher=1;
height_wood=2;

space_base=1;
common_angle_base=0;

chair_width=40;

module rotate_about(v,a) {
translate(v) rotate(a) translate(-v) children(0);
}

module rotate_about_debug(v,a) {
    translate(-v) children(0);
}

module side() {
    //feet
    translate([length_body, 0, 0]){
        rotate(a=[0,-(180-angle_body_rest),0]) {
            cube([length_rest,thickness_wood,height_wood]);
        }
    }

    //body
    cube([length_body,thickness_wood,height_wood]);

    //head
    rotate(a=[0,180-angle_body_head,0]) {
        translate([-length_head, 0,0]){
            cube([length_head,thickness_wood,height_wood]);
        }
    }
}



module stretchers() {
    

    
//feet-body stretcher
translate([length_body, 
    0,
    0]){
    rotate(a=[0,-(180-angle_body_rest),0]) {
        cube([thickness_stretcher,chair_width,height_wood]);
    }
}

//head stretcher
rotate(a=[0,180-angle_body_head,0]) {
    translate([-length_head, 0,0]){
        cube([thickness_stretcher,chair_width,height_wood]);
    }
}

//head-body stretcher

    cube([thickness_stretcher,chair_width,height_wood]);


//feet stretcher
translate([length_body + 
    cos(180-angle_body_rest)*(length_rest -thickness_stretcher)
    , 
    0,
    +sin(180-angle_body_rest)*(length_rest -thickness_stretcher)
    ]){
    rotate(a=[0,-(180-angle_body_rest),0]) {
        cube([thickness_stretcher,chair_width,height_wood]);
    }
}
}




module base() {
    
module feet_base() {
    translate([
    length_body+cos(-90+angle_body_rest)*(height_wood+space_base),
    0,
    -sin(-90-angle_body_rest)*(height_wood+space_base)
    ]){
        rotate(a=[0,-(180-angle_body_rest),0]) {
            cube([length_rest,thickness_wood,height_wood]);
        }
    }
}
    
//body renfort
translate([0, 0, -height_wood-space_base]){
        cube([length_body,thickness_wood,height_wood]);
}

//body support
translate([length_body-sin(common_angle_base)*height_wood,
    0,
    -cos(common_angle_base)*height_wood-space_base
]){
    rotate(a=[0,common_angle_base,0]) {
        cube([length_rest-10,thickness_wood,height_wood]);
    }
}

//feet renfort
feet_base();

//feet support
rotate_about([
    length_body-cos(-90-angle_body_rest)*space_base,
    0,
    -sin(-90-angle_body_rest)*space_base], 
    [0,-common_angle_base,0]) {
    translate([
        length_body+
            cos(angle_body_rest-90)*(height_wood+space_base)
            -sin(angle_body_rest-90)*(length_rest),
        0,
        - sin(angle_body_rest-90)*(height_wood+space_base)
            +sin(-(180-angle_body_rest))*length_rest
    ]){
        rotate(a=[0,-(180-angle_body_rest),0]) {
            cube([length_rest,thickness_wood,height_wood]);
        }
    }
}

//feet front
rotate_about([
    length_body+cos(180-angle_body_rest)*length_rest
        +sin(180-angle_body_rest)*(height_wood+space_base),
    0,
    sin(180-angle_body_rest)*length_rest
        -cos(180-angle_body_rest)*(height_wood+space_base)], 
    [0,-48,0]) {
    feet_base();
}





}

rotate(a=[0,angle_body_floor,0]) {
base();
stretchers();

side();


translate([0,chair_width,0]) {
    base();
    side();
}
}
