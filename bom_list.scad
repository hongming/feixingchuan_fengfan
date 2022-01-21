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
有两个部分组成：升降结构、ROR结构。
升降结构由升降机和连接件组成。
ROR用于放置处于零位的望远镜结构，包含一个滑动顶盖。顶盖上方放置AllSKY相机和信息汇总屏。
*/

/*
Parallelogram平行四边形
宽：150mm
高：450mm，要考虑增高节
长：500mm

铝型材尺寸20*20mm
*/
p_width=150;
p_height=500;
p_length=500;
text_align=20;






translate([0,0,70]){
        part_text("风帆：E2020, 300mm, 4");
rotate([0,90,0])
extrusion(E2020,300,center=false);}


translate([0,0,100]){
        part_text("风帆：E2020, 500mm, 8");
rotate([0,90,0])
extrusion(E2020,500,center=false);}


translate([0,0,130]){
        part_text("风帆：E2020, 540mm, 2");
rotate([0,90,0])
extrusion(E2020,540,center=false);}


 
translate([0,0,40]){
        part_text("风帆：E2020, 500mm, 4,一头切45度");
rotate([0,90,0]){
        color("blue")
extrusion(E2020,p_height-20,center=false,cornerHole=true);
    translate([
    10,0,p_height
    ]){
    rotate([0,90+45,0]){       color("red")
        
extrusion_wedge_down();}}

        }}
        

 translate([0,0,3]){
        part_text("风帆：E2020, 232mm, 8,两头切相反的45度");
rotate([0,45,0])
for(i=[[-10,0,0]]){
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
extrusion_wedge_up();}}}}}



translate([0,0,160]){
        part_text("底部：E2020, 380mm, 6");
rotate([0,90,0])
extrusion(E2020,380,center=false);}

translate([0,0,190]){
        part_text("底部：E2020, 300mm, 5");
rotate([0,90,0])
extrusion(E2020,300,center=false);}

translate([0,0,220]){
        part_text("底部：E2020, 540mm, 2");
rotate([0,90,0])
extrusion(E2020,540,center=false);}


translate([0,0,250]){
        part_text("底部：E2020, 740mm, 2");
rotate([0,90,0])
extrusion(E2020,740,center=false);}


//cover
translate([0,0,280]){
    
    translate([520,-30,420/2]){
        color("white")
        part_color_text("574*463mm，17mm厚，2块");}
cube([574,17,463]);
    ;}
 
translate([0,0,280+30+463]){
    
    translate([520,0,330/2]){
                color("white")
        part_color_text("574*383mm，17mm厚, 1块");}
        
        
            translate([560,0,330/2-100]){
                color("white")
        part_color_text("或者574*300mm，17mm厚, 1块");}
        
        
cube([574,17,383]);
    ;}
        
    
    translate([0,0,280+30+463+30+383]){
    
    translate([520,0,330/2]){
                color("white")
        part_color_text("574*356mm，17mm厚, 1块");
        
        }
        
       translate([560,0,330/2-100]){
                color("white")
        part_color_text("或者574*265mm，17mm厚, 1块");
        
        }
cube([574,17,383]);
    ;}
       
 translate([1300,0,280+30+463+30]){
     
         translate([0,0,130]){
        part_color_text("多边形，17mm厚，1块");
         translate([400,-20,-120]){
             color("white")
             part_color_text("边长：500mm");
             }    
                      translate([600,-20,-10]){
             color("white")
             part_color_text("45度角");
             }    
             
                      translate([820,-20,-60]){
             color("black")
             part_color_text("高度170mm");
             }    
             
             }
rotate([90,0,0])
 polygon(points=[[0,0],[500,0],[500+170,170],[170,170]]); 
    }


  translate([1300,0,280+30+30]){
      
               translate([0,0,80]){
        part_color_text("多边形，20mm厚，2块");}
        
                       translate([280,-40,-30]){
        part_color_text("底边长300mm");}
        
                               translate([600,-40,80]){
        part_color_text("边角高度100mm");}
        
                                       translate([480,-40,180]){
        part_color_text("顶角高度200mm");}
        
 rotate([90,0,0])
polygon(points = [
            [0, 0],
            [150 * 2 , 0],
            [150 * 2 , 100],
            [150, 200],
            [0, 100]
          ]);
  }


module part_text(i){
translate([-text_align,0,0])
rotate([90,0,0])
color("black")
text(i,size=10,halign="right",font="Heiti SC",language="cn")
    ;}

module part_color_text(i){
translate([-text_align,0,0])
rotate([90,0,0])
color("black")
text(i,size=30,halign="right",font="Songti SC",language="cn")
    
    ;}