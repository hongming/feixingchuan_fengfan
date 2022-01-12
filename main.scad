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
include<linear_actuator.scad>
include<equipments.scad>


/*
能够快速拆分为两个部分
*/


/*
Parallelogram平行四边形
宽：150mm
高：450mm，要考虑增高节
长：500mm
木板：17mm

铝型材尺寸20*20mm
*/
p_width=150;
p_height=500;
p_length=500;
wall_thickness=12;
//大四边形
rotate([0, 0, 0]) {
parallelgram();
translate([-10,-10-wall_thickness/2,-20]){

polygon_extrude_A()
    ;
    } //盖子A
translate([-10,p_length+40-10+wall_thickness/2,-20]){
polygon_extrude_A()
    ;
    }//盖子A-后面
    
    

//大四边形-左侧覆盖物
//侧面长方形
// 左边
polygon_extrude_B_wall();
  //顶盖-左侧
polygon_extrude_C_cover_left();  

}


//大四边形-右侧
translate([p_width*2+20,0,0]){
    rotate([0,0,0]){
        // 右边
        color("grey")
translate([20+wall_thickness,0,0]){
  polygon_extrude_B_wall();
    }
//顶盖-右侧
translate([0,p_length+20,0]){
rotate([0,0,180]){
    
polygon_extrude_C_cover_right()
    ;}}
        
        
mirror([1,0,0]){
    parallelgram();
    translate([-10,-10-wall_thickness/2,-20]){
        color("blue")
polygon_extrude_A();
        } //盖子A
translate([-10,p_length+40-10+wall_thickness/2,-20]){
    color("yellow")
polygon_extrude_A()
    ;
    }//盖子A-后面
    
    }}
}

//望远镜

translate([p_width+10,p_length/2,-20]){
equipments();
}

//底座
base_box();


//电动伸缩杆-左侧
translate([290,5,0]){
rotate([-90,-145,0]){
linear_actuator_close();}
}
 
//电动伸缩杆-右侧
translate([50,p_length-10,0]){
rotate([90,-20,0]){
linear_actuator_open();}
}
 

//铰链
translate([-11,-5,0]){
    flat_hinges();
    }

translate([-11,-20+p_length,0]){
    flat_hinges();
    }



windbreak();
//前后挡板
module windbreak(){

    translate([0, -5, 0]) {
        
    
    rotate([90,0,0]) {
        

    
    color("grey"){
linear_extrude(height = 10, center = true, convexity = 10){
polygon(points=[[10,0],[p_width*2+10,0],[p_width*2+10,100],[p_width,200],[10,100]]);
}    }
}}}

//底座
module base_box(){
//前    
    translate([10,0,-10])
         color("grey")
    rotate([0,90,0])
    extrusion(E2020,2*p_width,center=false,cornerHole=true);

    translate([10,30,-10])
    rotate([0,90,0])
    extrusion(E2020,2*p_width,center=false,cornerHole=true);


//后
        translate([10,p_length+20,-10])
                 color("red")
    rotate([0,90,0])
    extrusion(E2020,2*p_width,center=false,cornerHole=true);
    
            translate([10,p_length-10,-10])
    rotate([0,90,0])
    extrusion(E2020,2*p_width,center=false,cornerHole=true);

    
//左
    translate([0,-10,-10])
             color("red")
    rotate([-90,90,0])
    extrusion(E2020,p_length+40,center=false,cornerHole=true);

//右
    translate([2*p_width+20,-10,-10])
             color("red")
    rotate([-90,90,0])
    extrusion(E2020,p_length+40,center=false,cornerHole=true);

    }
    

//四边形连接器
module parallelgram(){
for(k=[[0,0,0],[0,0,p_height-40]]){
    translate(k){
translate([0,10,10]){
rotate([-90,0,0]){
    color("pink")
extrusion(E2020,p_length,center=false,cornerHole=true);}
}
}}

for(k=[[p_width/2,10,p_height+p_width*cos(45)/2]]){
    translate(k){
translate([0,0,0]){
rotate([-90,45,0]){
    color("blue")
extrusion(E2020,p_length,center=false,cornerHole=true);
    }
}
}}

//前后四边形
for(j=[[0,0,0],[0,p_length+20,0]]){
translate(j){
//左侧
        color("yellow")
extrusion(E2020,p_height-20,center=false,cornerHole=true);
    translate([
    10,0,p_height
    ]){
    rotate([0,90+45,0]){       color("yellow")
extrusion_wedge_down();}}

//中段，下方
for(i=[[0,0,150],[0,0,p_height-20/cos(45)]]){
    translate(i){
translate([10,0,20/cos(45)]){
rotate([0,180,0]){
    color("red")
extrusion_wedge_up();}}
translate([10+10*cos(45),0,10*cos(45)+20*cos(45)]){
rotate([0,45,0]){
    color("blue")
extrusion(E2020,(p_width)/cos(45)-20,center=false,cornerHole=true);}}

    translate([p_width+10,0,p_width]){
rotate([0,0,0]){
        color("red")
extrusion_wedge_up();}}}}


}
}
}





//四边形覆盖物 -A
 module polygon_extrude_A(){
//     color("yellow")
//     rotate([-90,-90,0])
//linear_extrude(wall_thickness,center=true){
// polygon([[0,0],[p_height,0],[p_height+p_width+20,p_width+20],[p_width+20,p_width+20]]);
//}

}

//四边形覆盖物 -B -侧面长方形
 module polygon_extrude_B_wall(){
//          color("GhostWhite")
//translate([-10-wall_thickness,-10-wall_thickness,0])
//cube([wall_thickness,p_length+40+2*wall_thickness,p_height-20-wall_thickness]);
}


//四边形覆盖物 -C - 顶盖长方形，左侧
 module polygon_extrude_C_cover_left(){
          color("grey")
translate([-20-10,-10-wall_thickness,
     wall_thickness*cos(45)+p_height-20-wall_thickness
     ])
     rotate([0,45,0])
cube([wall_thickness,p_length+40+2*wall_thickness,
     (p_width)/cos(45)+20/cos(45)+wall_thickness/cos(45)
     
     ]);
}


//四边形覆盖物 -C - 顶盖长方形，右侧
 module polygon_extrude_C_cover_right(){
          color("green")
translate([-10-wall_thickness-wall_thickness*cos(45),-10-wall_thickness,p_height-20-wall_thickness+wall_thickness*cos(45)])
     rotate([0,45,0])
    
cube([wall_thickness,p_length+40+2*wall_thickness,
          (p_width)/cos(45)+20/cos(45)+wall_thickness/cos(45)+wall_thickness+10
     
     ]);
}


//连接铰链

angle = 0;
small_hinge = flat_hinge(name = "small", size =[ 50,   16,    4],        pin_d = 2.85,         knuckle_d = 7,                knuckles =3,        screw = M3_dome_screw, screws =3,      clearance = 0.2,       margin =3);
hinges = [small_hinge];

module flat_hinges()
    layout([for(h = hinges) hinge_width(h)], 10)
        if($preview) {
            translate([-24,25,3.5])
 rotate([90,0,-90])
            hinge_fastened_assembly(hinges[$i], 3, 3, angle); }
        else 
        {translate([-24,25,3.5])
 rotate([90,0,-90])
            hinge_male(hinges[$i]); }
        