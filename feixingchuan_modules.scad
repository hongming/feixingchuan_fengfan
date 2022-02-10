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




module obs(linear_actuator_preview,obs_cover_preview){
    
    if(linear_actuator_preview==1){
    //左侧
mirror([1,0,0]){
    
        translate([2*extrusion_specs_offset-2*p_width,extrusion_specs_offset/2+45/2+p_length-2*extrusion_specs_offset-5,extrusion_specs_offset+5]){
 linear_actuator_in_place(90-rotate_left/2-42);}
    }

//右侧
    translate([3*extrusion_specs_offset,extrusion_specs_offset/2+45/2,extrusion_specs_offset+5]){
 linear_actuator_in_place(90-rotate_right/2-42);}
 }
 

//大四边形
rotate([0, -rotate_left, 0]) {
 
translate([
  extrusion_specs_offset/2
  ,0,0])
    {
        
          parallelgram();
  translate([-extrusion_specs_offset/2, -extrusion_specs_offset/2 - wall_thickness/2, -extrusion_specs_offset]) {

if(obs_cover_preview ==1)
    polygon_extrude_A();
  } //盖子A
  translate([
    -extrusion_specs_offset/2
    , p_length + 2*extrusion_specs_offset - extrusion_specs_offset/2 + wall_thickness/2, -extrusion_specs_offset]) {
      if(obs_cover_preview ==1)
  polygon_extrude_A();
  } //盖子A-后面

  //大四边形-左侧覆盖物
  //侧面长方形
  // 左边墙
  if(obs_cover_preview ==1)
  polygon_extrude_B_wall();}
  //顶盖-左侧
  if(obs_cover_preview ==1)


  translate([0, -extrusion_specs_offset / 2 - 2 * wall_thickness, p_height -extrusion_specs_offset])
   {
     rotate([ 0, 45, 0 ])
        translate([ 0, 0, -wall_thickness / cos(45) ])
          mirror([ 1, 0, 0 ])
            polygon_extrude_C_cover_left();
  }
  
}

//大四边形-右侧
translate([p_width * 2+2*extrusion_specs_offset, 0]) {
  rotate([0, rotate_right, 0]) {
      translate([0,0,0]){
    // 右边
    color("grey")
    translate([extrusion_specs_offset/2 + wall_thickness, 0, 0]) {
        if(obs_cover_preview ==1)
     polygon_extrude_B_wall();
    }
    //顶盖-右侧
    translate([-extrusion_specs_offset/2, p_length + extrusion_specs_offset, 0]) {
      rotate([0, 0, 180]) {
if(obs_cover_preview ==1)
     polygon_extrude_C_cover_right();
      }
    }

    mirror([1, 0, 0]) {
        translate([extrusion_specs_offset/2,0,0])
      parallelgram();
      translate([0, -extrusion_specs_offset/2 - wall_thickness/2, -extrusion_specs_offset]) {
if(obs_cover_preview ==1)
      polygon_extrude_A();
      } //盖子A
      translate([0, p_length + 2*extrusion_specs_offset - extrusion_specs_offset/2 + wall_thickness/2, -extrusion_specs_offset]) {
          if(obs_cover_preview ==1)
        polygon_extrude_A();
      } //盖子A-后面

    }
    
}
  }
}

translate([extrusion_specs_offset/2,0,0]){
    if(obs_windbreak_preview ==1)
  windbreak();
translate([0, p_length+extrusion_specs_offset+wall_thickness, 0]) {
        if(obs_windbreak_preview ==1)
  windbreak();
}}

}



//底部框架
module obs_base(equipments_preview, telescope_pier_preview,rotate_left){

//望远镜
translate([p_width + extrusion_specs_offset/2, p_length/2, -extrusion_specs_offset]) {
    
if(equipments_preview ==1)
    equipments(rotate_left);


if( telescope_pier_preview ==1)
{
    translate([0,0,-base_height-base_offset-2*extrusion_specs_offset])
telescope_pier();
    }

}
//底座
base_box();

// translate([0, 0, -extrusion_specs_offset-10*extrusion_specs_offset]) {
//         color("green")
//   base_box();
// }

translate([0, 0, -base_height - 2*extrusion_specs_offset-base_offset ]) {

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

//铰链-左侧
translate([-11, extrusion_specs_offset+5, 0]) {
  flat_hinges();
}

translate([-11, -extrusion_specs_offset-extrusion_specs_offset+ p_length-15, 0]) {
  flat_hinges();
}

//铰链-右侧
translate([2*p_width+2*extrusion_specs_offset+5, 0, 0]) {
  mirror([0,0,1]){
translate([-11, extrusion_specs_offset+5, 0]) {
  flat_hinges();
}

translate([-11,-extrusion_specs_offset-extrusion_specs_offset+ p_length-15, 0]) {
  flat_hinges();
}
}
}




}


//前后挡板
module windbreak() {

  translate([0, -5, 0]) {

    rotate([90, 0, 0]) {

      color("grey") {
        linear_extrude(height = wall_thickness, center = true, convexity = 10) {
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
  //底-前    
  translate([extrusion_specs_offset/2, 0, -extrusion_specs_offset/2])
 color("grey")
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);


  //底-后
  translate([extrusion_specs_offset/2, p_length + extrusion_specs_offset, -extrusion_specs_offset/2])
  color("grey")
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);

  //底-左
  translate([0, -extrusion_specs_offset/2 - 100, -extrusion_specs_offset/2])
  color("grey")
  rotate([-90, 90, 0])
  extrusion(extrusion_specs, p_length + 2*extrusion_specs_offset + 200, center = false, cornerHole = true);

  //底-右
  translate([2 * p_width + extrusion_specs_offset, -extrusion_specs_offset/2 - 100, -extrusion_specs_offset/2])
   color("grey")
  rotate([-90, 90, 0])
  extrusion(extrusion_specs, p_length + 2*extrusion_specs_offset + 200, center = false, cornerHole = true);
 
  //立柱
  translate([0, 0, base_height/2]) {
    extrusion(extrusion_specs, base_height, cornerHole = true);
  }
  translate([p_width * 2 + extrusion_specs_offset, 0, base_height/2]) {
    extrusion(extrusion_specs, base_height, cornerHole = true);
  }
  translate([0, p_length + extrusion_specs_offset, base_height/2]) {
    extrusion(extrusion_specs, base_height, cornerHole = true);
  }
  translate([p_width * 2+extrusion_specs_offset, p_length + extrusion_specs_offset, base_height/2]) {
    extrusion(extrusion_specs, base_height, cornerHole = true);
  }
  translate([0, p_length/2 + extrusion_specs_offset, base_height/2]) {
      
    extrusion(extrusion_specs, base_height, cornerHole = true);
  }
  translate([p_width * 2+extrusion_specs_offset, p_length/2 + extrusion_specs_offset, base_height/2]) {


    extrusion(extrusion_specs, base_height, cornerHole = true);
  }

  //上-前    
  translate([extrusion_specs_offset/2, 0, -extrusion_specs_offset/2+base_height+extrusion_specs_offset])
 color("grey")
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);


  //上-后
  translate([extrusion_specs_offset/2, p_length + extrusion_specs_offset, -extrusion_specs_offset/2+base_height+extrusion_specs_offset])
  color("grey")
  rotate([0, 90, 0])
  extrusion(extrusion_specs, 2 * p_width, center = false, cornerHole = true);

  //上-左
  translate([0, -extrusion_specs_offset/2 - 100, -extrusion_specs_offset/2+base_height+extrusion_specs_offset])
  color("grey")
  rotate([-90, 90, 0])
  extrusion(extrusion_specs, p_length + 2*extrusion_specs_offset + 200, center = false, cornerHole = true);

  //上-右
  translate([2 * p_width + extrusion_specs_offset, -extrusion_specs_offset/2 - 100, -extrusion_specs_offset/2+base_height+extrusion_specs_offset])
  color("grey")
  rotate([-90, 90, 0])
  extrusion(extrusion_specs, p_length + 2*extrusion_specs_offset + 200, center = false, cornerHole = true);
 
 //上-木板
 difference(){
   translate([ extrusion_specs_offset/2, extrusion_specs_offset/2, base_height])
  color("red")
  cube([2*p_width,p_length,wall_thickness]);
   translate([ p_width+extrusion_specs_offset/2, p_length/2-extrusion_specs_offset/2, base_height-extrusion_specs_offset])
  cylinder(d=150,h=3*extrusion_specs_offset);
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
          color("black")
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
          color("black")
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
  color("grey")
  difference(){
  translate([-extrusion_specs_offset/2 - wall_thickness, -extrusion_specs_offset/2 - wall_thickness, 0])
  cube([wall_thickness, p_length + extrusion_specs_offset*2 + 2 * wall_thickness, p_height - extrusion_specs_offset - wall_thickness]);
  translate([-5*wall_thickness, -wall_thickness-extrusion_specs_offset/2+2*extrusion_specs_offset, 0]) {
     cube([10*wall_thickness-0.01,60,25]); 
  }
    translate([-5*wall_thickness,p_length+2*extrusion_specs_offset-60-2*extrusion_specs_offset, 0]) {
     cube([10*wall_thickness-0.01,60,25]); }
  }
}

//四边形覆盖物 -C - 顶盖长方形，左侧
module polygon_extrude_C_cover_left() {

color("grey")

  cube([wall_thickness, p_length + extrusion_specs_offset*2 + 4 * wall_thickness,    (p_width)/cos(45) + extrusion_specs_offset/cos(45) + wall_thickness/cos(45)

  ]);
}

//四边形覆盖物 -C - 顶盖长方形，右侧
module polygon_extrude_C_cover_right() {

  translate([-extrusion_specs_offset/2 - wall_thickness - wall_thickness * cos(45), -extrusion_specs_offset/2 -2*wall_thickness, p_height - extrusion_specs_offset - wall_thickness + wall_thickness * cos(45)])
  rotate([0, 45, 0])
  {
  cube([wall_thickness, p_length + 2*extrusion_specs_offset + 4 * wall_thickness,
    (p_width)/cos(45) + extrusion_specs_offset/cos(45) + wall_thickness/cos(45) + 2*wall_thickness  

  ]);

translate([
  

 0,
 
  0, 
  
    (p_width)/cos(45) + extrusion_specs_offset/cos(45) + wall_thickness/cos(45) + 2*wall_thickness 
  ]) {

//遮雨罩子
color("red")
{
  cube([30, p_length + 2*extrusion_specs_offset + 4 * wall_thickness,1]);
translate([-1,0,1])
rotate([0, 90, 0]) {
  cube([30, p_length + 2*extrusion_specs_offset + 4 * wall_thickness,1]);
}
}


}
  }
  
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
    color("white")
  hinge_fastened_assembly(hinges[$i], 3, 3, angle);
} else {
  translate([-24, 25, 3.5])
  rotate([90, 0, -90])
  hinge_male(hinges[$i]);
}


//铝型材切口

module  extrusion_wedge_down(extrusion_specs,extrusion_specs_offset){
 difference(){
translate([(extrusion_specs_offset/2)*cos(45),0,-(extrusion_specs_offset/2)*cos(45)]){
rotate([0,45,0]){
extrusion(extrusion_specs,extrusion_specs_offset,center=false,cornerHole=true);}}

translate([-2*extrusion_specs_offset,-extrusion_specs_offset,-extrusion_specs_offset*cos(45)]){
cube([4*extrusion_specs_offset,2*extrusion_specs_offset,extrusion_specs_offset*cos(45)]);}

}

}

eps=0.01;

//铝型材的楔子，上方的
module  extrusion_wedge_up(extrusion_specs,extrusion_specs_offset){
  difference(){
translate([-(extrusion_specs_offset/2)*cos(45)+eps,0,(extrusion_specs_offset/2)*cos(45)+eps]){
rotate([0,45,0]){
extrusion(extrusion_specs,extrusion_specs_offset-eps,center=false,cornerHole=true);}}

translate([0,-extrusion_specs_offset+eps,0]){
cube([2*extrusion_specs_offset*cos(45)+eps,2*extrusion_specs_offset,2*extrusion_specs_offset/cos(45)]);
    
    }

}}


//望远镜
module equipments(rotate_left){

//斜劈立柱
difference(){
translate([0,0,10+25+10+12]){
    color("black")
cylinder(h=170,r=40,center=false);

       }
    translate([0,40,50+170+100*cos(60)+10+15]){
    rotate([0,60,90])
    cube([400,200,200],center=true);}
       
       }
    
//望远镜主体
       translate([0,55,190+30]){
       rotate([30,0,0]){
         
    cube([120,150,120],center=true);
      translate([0,40,120+50]){
        rotate([0,0,rotate_left])
        color("black")
      cube([100,360,220],center=true);  }
  }
  }
//四孔调节支架
translate([0,0,5]){
        color("white")
cube([150,150,10],center=true);}
translate([0,0,5+35]){
        color("white")
cube([150,150,10],center=true);
    }

translate([0,0,10+35]){
    color("white")
cylinder(h=12,r=30,center=false);}

for(i=[
[-50,-50,0],
[50,-50,0],
[50,50,0],
[-50,50,0]]){
    translate(i)
cylinder(h=50,r=5,center=false);}}


//地面立柱
module telescope_pier(){
 
        cylinder(h=base_height+2*extrusion_specs_offset,r=40,center=false);
    
         cylinder(h=20,r=100,center=false);
 
    }
//电动推杆

    module linear_actuator_in_place(actuator_angel){
rotate([90,-actuator_angel,0])
   translate([0,-22.5,-22.5])
{
    translate([0,10,17]){
cube([22,24,10]);
        }

    translate([22,45,2]){
        color("blue")
cube([132,40,40]);}

translate([22,0,0]){
        color("black")
cube([200+120-11-11,45,45]);}


//伸缩 -开始

translate([
-(1-cos(actuator_angel))*(200+120-1+200)

,0,0]){
    translate([200+120-11-11+11+10,12,11]){
 cube([200,20,20]);      
}

    translate([200+120-1+200,12,11]){
        color("red")
cube([22,20,20]);}
//伸缩 -结束
}
}
    }