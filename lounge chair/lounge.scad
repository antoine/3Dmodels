
angle_body_head=35;
angle_body_rest=-44;

//angle_body_floor=27;
angle_body_floor=27;

length_head=33;
length_body=57;
length_rest=47;

thickness_wood=2;
thickness_stretcher=2;
height_wood=3;

//base
space_between_side_and_base=1;
common_angle_base=0;
spread_angle=10;
front_legs_angle=-48;

chair_width=40;

support_distance=(height_wood+space_between_side_and_base);

module rotate_about(v,a) {
  translate(v) rotate(a) translate(-v) children(0);
}

module rotate_about_debug(v,a) {
  translate(-v) children(0);
}

module sides() {
  //feet
  translate([length_body, 0, 0]) {
    rotate(a=[0,angle_body_rest,0]) {
      cube([length_rest,thickness_wood,height_wood]);
    }
  }

  //body
  cube([length_body,thickness_wood,height_wood]);

  //head
  rotate(a=[0,angle_body_head,0]) {
    translate([-length_head, 0,0]) {
      cube([length_head,thickness_wood,height_wood]);
    }
  }
}



module stretchers() {

  //feet-body stretcher
  translate([length_body, 0, 0]) {
    rotate(a=[0,angle_body_rest,0]) {
      cube([thickness_stretcher,chair_width,height_wood]);
    }
  }

  //head stretcher
  rotate(a=[0,angle_body_head,0]) {
    translate([-length_head, 0,0]) {
      cube([thickness_stretcher,chair_width,height_wood]);
    }
  }

  //head-body stretcher

  cube([thickness_stretcher,chair_width,height_wood]);


  //feet stretcher
  translate([
      length_body + cos(angle_body_rest)*(length_rest -thickness_stretcher) , 
      0,
      -sin(angle_body_rest)*(length_rest -thickness_stretcher) ]) {
    rotate(a=[0,angle_body_rest,0]) {
      cube([thickness_stretcher,chair_width,height_wood]);
    }
  }
}




module base() {

  //body renfort
  translate([0, 0, -support_distance]) {
    cube([length_body,thickness_wood,height_wood]);
  }

  //body leg 
  rotate_about([
      length_body,
      0,
      space_between_side_and_base], 
      [0,0,-spread_angle]) { //10 added for better centering of the feet
    translate([
        length_body - sin(common_angle_base)*height_wood,
        0,
        -cos(common_angle_base)*height_wood - space_between_side_and_base ]) {
      rotate(a=[0,common_angle_base,0]) {
        cube([length_rest-10,thickness_wood,height_wood]);
      }
    }
  }

  //feet renfort
  module feet_base() {
    translate([
        length_body+cos(90+angle_body_rest)*support_distance,
        0,
        -sin(90+angle_body_rest)*support_distance ]) {
      rotate(a=[0,angle_body_rest,0]) {
        cube([length_rest,thickness_wood,height_wood]);
      }
    }
  }

  feet_base();

  //feet leg 
  rotate_about([
      length_body+cos(90+angle_body_rest)*space_between_side_and_base,
      0,
      -sin(90+angle_body_rest)*space_between_side_and_base], 
      [-spread_angle,-10-common_angle_base,0]) { //10 added for better centering of the feet
    translate([
        -sin(angle_body_rest+90)*(length_rest),
        0,
        -cos(90+angle_body_rest)*length_rest]) {
      feet_base();
    }
  }

  //feet front leg
  rotate_about([
      length_body + cos(angle_body_rest)*length_rest + cos(90+angle_body_rest)*support_distance,
      0,
      -sin(angle_body_rest)*length_rest - cos(angle_body_rest)*support_distance], 
      [-spread_angle*1.5,front_legs_angle,0]) { //1.5 is an approximation of the 
      //ratio between the height of the back leg and the front leg (height here being
      //the distance between the legs' floor contact point and the reported point on the 
      //rotation axis of the leg pair)
    feet_base();
  }


  //head renfort
  translate([
      -sin(angle_body_head)*support_distance,
      0,
      -cos(angle_body_head)*support_distance]) {
    rotate(a=[0,angle_body_head,0]) {
      translate([-length_head, 0,0]) {
        cube([length_head,thickness_wood,height_wood]);
      }
    }
  }

  //head leg 
  //using space_between_side_and_base is an approximation, the top of the bar is higher
  rotate_about([0,0,-space_between_side_and_base],[-spread_angle,0,0]){
    translate([
        -sin(angle_body_head)*support_distance + cos(angle_body_head)*length_head ,
        0,
        -cos(angle_body_head)*support_distance - sin(angle_body_head)*length_head]) {
      rotate(a=[0,angle_body_head,0]) {
        translate([-length_head, 0,0]) {
          cube([length_head*2,thickness_wood,height_wood]);
        }
      }
    }
  }


}

difference() {
  rotate(a=[0,angle_body_floor,0]) {
    base();
    stretchers();

    sides();


    translate([0,chair_width,0]) {
      mirror([0,1,0]) {
        base();
        sides();
      }
    }
  }

  //ground
  translate([0,-10,-145]) {
    cube([100, 100, 100]);
  }
}
