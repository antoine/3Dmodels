
angle_body_head=145;
angle_body_rest=136;

angle_body_floor=25;

length_head=33;
length_body=57;
length_rest=47;

chair_width=40;

module side() {

union()  {
//rest
translate([cos(angle_body_floor)*length_body, 
    0,
    -sin(angle_body_floor)*length_body]){
    rotate(a=[0,-(180-angle_body_rest-angle_body_floor),0]) {
        cube([length_rest,3,3]);
    }
}

//body
rotate(a=angle_body_floor, v=[0,1,0]) {
    cube([length_body,3,3]);
}

//head
rotate(a=[0,180-angle_body_head+angle_body_floor,0]) {
    translate([-length_head, 0,0]){
        cube([length_head,3,3]);
    }
}
}
}

side();
translate([0,chair_width,0]) {
    side();
}

//rest bottom stretcher
translate([cos(angle_body_floor)*length_body, 
    0,
    -sin(angle_body_floor)*length_body]){
    rotate(a=[0,-(180-angle_body_rest-angle_body_floor),0]) {
        cube([3,chair_width,3]);
    }
}

//head top stretcher
rotate(a=[0,180-angle_body_head+angle_body_floor,0]) {
    translate([-length_head, 0,0]){
        cube([3,chair_width,3]);
    }
}
