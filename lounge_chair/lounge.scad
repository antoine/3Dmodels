
angle_body_head=145;
angle_body_rest=136;

//angle_body_floor=27;
angle_body_floor=0;
length_head=33;
length_body=57;
length_rest=47;

thickness_wood=1;
thickness_stretcher=1;
height_wood=2;

space_base=1;
common_angle_base=10;

chair_width=40;

module side() {

union()  {
//feet
translate([cos(angle_body_floor)*length_body, 
    0,
    -sin(angle_body_floor)*length_body]){
    rotate(a=[0,-(180-angle_body_rest-angle_body_floor),0]) {
        cube([length_rest,thickness_wood,height_wood]);
    }
}

//body
rotate(a=angle_body_floor, v=[0,1,0]) {
    cube([length_body,thickness_wood,height_wood]);
}

//head
rotate(a=[0,180-angle_body_head+angle_body_floor,0]) {
    translate([-length_head, 0,0]){
        cube([length_head,thickness_wood,height_wood]);
    }
}
}
}



module stretchers() {
//feet-body stretcher
translate([cos(angle_body_floor)*length_body, 
    0,
    -sin(angle_body_floor)*length_body]){
    rotate(a=[0,-(180-angle_body_rest-angle_body_floor),0]) {
        cube([thickness_stretcher,chair_width,height_wood]);
    }
}

//head stretcher
rotate(a=[0,180-angle_body_head+angle_body_floor,0]) {
    translate([-length_head, 0,0]){
        cube([thickness_stretcher,chair_width,height_wood]);
    }
}

//head-body stretcher
rotate(a=angle_body_floor, v=[0,1,0]) {
    cube([thickness_stretcher,chair_width,height_wood]);
}

//feet stretcher
translate([cos(angle_body_floor)*length_body + 
    cos(180-angle_body_rest-angle_body_floor)*(length_rest -thickness_stretcher)
    , 
    0,
    -sin(angle_body_floor)*length_body
    +sin(180-angle_body_rest-angle_body_floor)*(length_rest -thickness_stretcher)
    ]){
    rotate(a=[0,-(180-angle_body_rest-angle_body_floor),0]) {
        cube([thickness_stretcher,chair_width,height_wood]);
    }
}
}




module base() {
//body base
translate([sin(angle_body_floor)*(-height_wood-space_base), 
    0,
    (-height_wood-space_base)*cos(angle_body_floor)]){
    rotate(a=angle_body_floor, v=[0,1,0]) {
        cube([length_body,thickness_wood,height_wood]);
    }
}

//feet base
translate([
    
    cos(angle_body_floor)*length_body
    +sin(angle_body_floor)*(-height_wood-space_base), 
    0,
    -sin(angle_body_floor)*length_body
    + (-height_wood-space_base)*cos(angle_body_floor)]){
    rotate(a=[0,(angle_body_floor+common_angle_base),0]) {
        cube([length_rest-10,thickness_wood,height_wood]);
        
    }
}
    
}

base();

stretchers();

side();

translate([0,chair_width,0]) {
    side();
}

