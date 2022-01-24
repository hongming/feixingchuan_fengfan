//
// NopSCADlib Copyright Chris Palmer 2018
// nop.head@gmail.com
// hydraraptor.blogspot.com
//
// This file is part of NopSCADlib.
//
// NopSCADlib is free software: you can redistribute it and/or modify it under the terms of the
// GNU General Public License as published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// NopSCADlib is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with NopSCADlib.
// If not, see <https://www.gnu.org/licenses/>.
//
include <NopSCADlib/utils/core/core.scad>
  include <NopSCADlib/vitamins/extrusions.scad>
  include <NopSCADlib/utils/layout.scad>
  include <NopSCADlib/printed/flat_hinge.scad>
  include <extrusion_wedge_up.scad>
  include <extrusion_wedge_down.scad>
  include <linear_actuator.scad>
  include <equipments.scad>

  /*
  能够快速拆分为两个部分
  */

  /*
  Parallelogram平行四边形
  宽：150mm
  高：500mm，要考虑增高节
  长：500mm
  木板：17mm

  铝型材尺寸20*20mm
  */
p_width = 150;
p_height = 500;
p_length = 500;
wall_thickness = 17;
extrusion_specs=E2020;
extrusion_specs_offset=20;
rotate_left=30;
rotate_right=60;

//extrusion_specs=E4040;
//extrusion_specs_offset=40;

//大四边形
rotate([0, -rotate_left, 0]) {
 
translate([extrusion_specs_offset/2,0,0])
    {
        
          parallelgram();
  translate([-extrusion_specs_offset/2, -extrusion_specs_offset/2 - wall_thickness/2, -extrusion_specs_offset]) {

    //polygon_extrude_A();
  } //盖子A
  translate([-extrusion_specs_offset/2, p_length + 2*extrusion_specs_offset - extrusion_specs_offset/2 + wall_thickness/2, -extrusion_specs_offset]) {
  //  polygon_extrude_A();
  } //盖子A-后面

  //大四边形-左侧覆盖物
  //侧面长方形
  // 左边
  //polygon_extrude_B_wall();
  //顶盖-左侧
  //polygon_extrude_C_cover_left();
        }

}

//大四边形-右侧
translate([p_width * 2+2*extrusion_specs_offset, 0]) {
  rotate([0, rotate_right, 0]) {
      translate([0,0,0]){
    // 右边
    color("grey")
    translate([extrusion_specs_offset + wall_thickness, 0, 0]) {
//      polygon_extrude_B_wall();
    }
    //顶盖-右侧
    translate([0, p_length + extrusion_specs_offset, 0]) {
      rotate([0, 0, 180]) {

 //       polygon_extrude_C_cover_right();
      }
    }

    mirror([1, 0, 0]) {
        translate([extrusion_specs_offset/2,0,0])
      parallelgram();
      translate([-extrusion_specs_offset/2, -extrusion_specs_offset/2 - wall_thickness/2, -extrusion_specs_offset]) {

 //       polygon_extrude_A();
      } //盖子A
      translate([-extrusion_specs_offset/2, p_length + 2*extrusion_specs_offset - extrusion_specs_offset/2 + wall_thickness/2, -extrusion_specs_offset]) {
//        polygon_extrude_A();
      } //盖子A-后面

    }
    
}
  }
}


translate([extrusion_specs_offset/2,0,0])
obs_base();


//底部框架
module obs_base(){
//望远镜

translate([p_width + extrusion_specs_offset/2, p_length/2, -extrusion_specs_offset]) {
//  equipments();
}

//底座
base_box();

translate([0, 0, -extrusion_specs_offset]) {
        color("green")
  base_box();
}

translate([0, 0, -380 - 2*extrusion_specs_offset ]) {

  base_box_base();
}

//电动伸缩杆-左侧
translate([290, 5, 0]) {
  rotate([-90, -145, 0]) {
  //  linear_actuator_close();
  }
}

//电动伸缩杆-右侧
translate([50, p_length - extrusion_specs_offset/2, 0]) {
  rotate([90, -20, 0]) {
 //   linear_actuator_open();
  }
}

//铰链
translate([-11, -5, 0]) {
  flat_hinges();
}

translate([-11, -extrusion_specs_offset + p_length, 0]) {
  flat_hinges();
}

//windbreak();


}


//前后挡板
module windbreak() {

  translate([0, -5, 0]) {

    rotate([90, 0, 0]) {

      color("grey") {
        linear_extrude(height = extrusion_specs_offset, center = true, convexity = 10) {
          polygon(points = [
            [extrusion_specs_offset/2, 0],
            [p_width * 2 + extrusion_specs_offset/2, 0],
            [p_width * 2 + extrusion_specs_offset/2, 100],
            [p_width, 200],
            [extrusion_specs_offset/2, 100]
          ]);
        }
      }
    }
  }
}

//底座
module base_box() {
  //前    
  translate([extrusion_specs_offset/2, 0, -extrusion_specs_offset/2])
 
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);

  translate([extrusion_specs_offset/2, 30, -extrusion_specs_offset/2])
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);

  //后
  translate([extrusion_specs_offset/2, p_length + extrusion_specs_offset, -extrusion_specs_offset/2])
 
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);

  translate([extrusion_specs_offset/2, p_length - extrusion_specs_offset/2, -extrusion_specs_offset/2])
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);

  //左
  translate([0, -extrusion_specs_offset/2, -extrusion_specs_offset/2])
 
  rotate([-90, 90, 0])
  extrusion(extrusion_specs, p_length + 2*extrusion_specs_offset, center = false, cornerHole = true);

  //右
  translate([2 * p_width + extrusion_specs_offset, -extrusion_specs_offset/2, -extrusion_specs_offset/2])
 
  rotate([-90, 90, 0])
  extrusion(extrusion_specs, p_length +2*extrusion_specs_offset, center = false, cornerHole = true);

}

//底座-接地支架
module base_box_base() {
  //前    
  translate([extrusion_specs_offset/2, 0, -extrusion_specs_offset/2])
  color("green")
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);

  translate([extrusion_specs_offset/2, p_length/2 + extrusion_specs_offset, -extrusion_specs_offset/2])
  rotate([0, 90, 0])
  color("green")
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);

  //后
  translate([extrusion_specs_offset/2, p_length + extrusion_specs_offset, -extrusion_specs_offset/2])
  color("green")
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);

  //左
  translate([0, -extrusion_specs_offset/2 - 100, -extrusion_specs_offset/2])
  color("green")
  rotate([-90, 90, 0])
  extrusion(extrusion_specs, p_length + 2*extrusion_specs_offset + 200, center = false, cornerHole = true);

  //右
  translate([2 * p_width + extrusion_specs_offset, -extrusion_specs_offset/2 - 100, -extrusion_specs_offset/2])
  color("green")
  rotate([-90, 90, 0])
  extrusion(extrusion_specs, p_length + 2*extrusion_specs_offset + 200, center = false, cornerHole = true);
  //立柱

  translate([0, 0, 190]) {
    extrusion(extrusion_specs, 380, cornerHole = true);
  }
  translate([p_width * 2 + extrusion_specs_offset, 0, 190]) {
    extrusion(extrusion_specs, 380, cornerHole = true);
  }
  translate([0, p_length + extrusion_specs_offset, 190]) {
    extrusion(extrusion_specs, 380, cornerHole = true);
  }
  translate([p_width * 2+extrusion_specs_offset, p_length + extrusion_specs_offset, 190]) {
    extrusion(extrusion_specs, 380, cornerHole = true);
  }
  translate([0, p_length/2 + extrusion_specs_offset, 190]) {
      
    extrusion(extrusion_specs, 380, cornerHole = true);
  }
  translate([p_width * 2+extrusion_specs_offset, p_length/2 + extrusion_specs_offset, 190]) {


    extrusion(extrusion_specs, 380, cornerHole = true);
  }
}

//四边形连接器
module parallelgram() {
  for (k = [
      [0, 0, 0],
   [0, 0, p_height - 10*extrusion_specs_offset],
      [0, 0, p_height - 2*extrusion_specs_offset]
    ]) {
    translate(k) {
      translate([0, extrusion_specs_offset/2, extrusion_specs_offset/2]) {
        rotate([-90, 0, 0]) {
          color("red")
          extrusion(extrusion_specs, p_length, center = false, cornerHole = true);
        }
      }
    }
  }


  for (k = [
      [0.5*p_width+(extrusion_specs_offset)/cos(rotate_left)+0.5*extrusion_specs_offset/cos(45), 0, p_height - 2*extrusion_specs_offset+p_width/2+extrusion_specs_offset+extrusion_specs_offset/cos(rotate_left)]
    ]) {
    translate(k) {
      translate([0, extrusion_specs_offset/2, extrusion_specs_offset/2]) {
        rotate([-90, 45, 0]) {
          color("red")
          extrusion(extrusion_specs, p_length, center = false, cornerHole = true);
        }
      }
    }
  }
  
  
//  for (k = [
//      [p_width/2, extrusion_specs_offset/2, p_height+p_width/2]
//    ]) {
//    translate(k) {
//      translate([0, 0, 0]) {
////                  rotate([0, 0, 0]) {
//        rotate([-90,45, 0]) {
//          color("pink")
//          extrusion(extrusion_specs, p_length, center = false, cornerHole = true);
//        }
//      }
//    }
//  }

  //前后四边形
  for (j = [
      [0, 0, 0],
      [0, p_length + extrusion_specs_offset, 0]
    ]) {
    translate(j) {
      //左侧
      color("black")
      extrusion(extrusion_specs, p_height - extrusion_specs_offset, center = false, cornerHole = true);
      translate([
        extrusion_specs_offset/2, 0, p_height
      ]) {
        rotate([0, 90 + 45, 0]) {
          color("black")
          extrusion_wedge_down(extrusion_specs,extrusion_specs_offset);
        }
      }

      //中段，下方
      for (i = [
          [0, 0, 150],
          [0, 0, p_height - extrusion_specs_offset/cos(45)]
        ]) {
        translate(i) {
            
            
          translate([extrusion_specs_offset/2, 0, extrusion_specs_offset/cos(45)]) {
            rotate([0, 180, 0]) {
              extrusion_wedge_up(extrusion_specs,extrusion_specs_offset);
            }
          }
          translate([extrusion_specs_offset/2 + extrusion_specs_offset/2 * cos(45), 0, (extrusion_specs_offset/2) * cos(45) + extrusion_specs_offset * cos(45)]) {
            rotate([0, 45, 0]) {
 
              extrusion(extrusion_specs, (p_width)/cos(45) - extrusion_specs_offset, center = false, cornerHole = true);
            }
          }

          translate([p_width + extrusion_specs_offset/2, 0, p_width]) {
            rotate([0, 0, 0]) {
  
              extrusion_wedge_up(extrusion_specs,extrusion_specs_offset);
            }
          }
          
          
        }
      }

    }
  }
}

//四边形覆盖物 -A
module polygon_extrude_A() {
  rotate([-90, -90, 0])
  linear_extrude(wall_thickness, center = true) {
    polygon([
      [0, 0],
      [p_height, 0],
      [p_height + p_width + extrusion_specs_offset, p_width + extrusion_specs_offset],
      [p_width + extrusion_specs_offset, p_width + extrusion_specs_offset]
    ]);
  }

}

//四边形覆盖物 -B -侧面长方形
module polygon_extrude_B_wall() {
  translate([-extrusion_specs_offset/2 - wall_thickness, -extrusion_specs_offset/2 - wall_thickness, 0])
  cube([wall_thickness, p_length + extrusion_specs_offset*2 + 2 * wall_thickness, p_height - extrusion_specs_offset - wall_thickness]);
}

//四边形覆盖物 -C - 顶盖长方形，左侧
module polygon_extrude_C_cover_left() {

  translate([ - 5-wall_thickness-wall_thickness, -extrusion_specs_offset/2 - wall_thickness,
    wall_thickness * cos(45) + p_height - extrusion_specs_offset - wall_thickness
  ])
  rotate([0, 45, 0])
  cube([wall_thickness, p_length + extrusion_specs_offset*2 + 2 * wall_thickness,    (p_width)/cos(45) + extrusion_specs_offset/cos(45) + wall_thickness/cos(45)

  ]);
}

//四边形覆盖物 -C - 顶盖长方形，右侧
module polygon_extrude_C_cover_right() {

  translate([-extrusion_specs_offset/2 - wall_thickness - wall_thickness * cos(45), -extrusion_specs_offset/2 - wall_thickness, p_height - extrusion_specs_offset - wall_thickness + wall_thickness * cos(45)])
  rotate([0, 45, 0])

  cube([wall_thickness, p_length + 2*extrusion_specs_offset + 2 * wall_thickness,
    (p_width)/cos(45) + extrusion_specs_offset/cos(45) + wall_thickness/cos(45) + wall_thickness + extrusion_specs_offset/2

  ]);
}

//连接铰链

angle = 0;
small_hinge = flat_hinge(name = "small", size = [50, 16, 4], pin_d = 2.85, knuckle_d = 7, knuckles = 3, screw = M3_dome_screw, screws = 3, clearance = 0.2, margin = 3);
hinges = [small_hinge];

module flat_hinges()
layout([
  for (h = hinges) hinge_width(h)
], 10)
if ($preview) {
  translate([-24, 25, 3.5])
  rotate([90, 0, -90])
  hinge_fastened_assembly(hinges[$i], 3, 3, angle);
} else {
  translate([-24, 25, 3.5])
  rotate([90, 0, -90])
  hinge_male(hinges[$i]);
}