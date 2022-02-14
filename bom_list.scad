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
/*
12mm厚度版本
长方形板，1块，300mm*500mm，中间打一个直径150mm的孔
长方形板，1块，588mm*258mm
长方形板，1块，588mm*282mm
平行四边形，4块，单边长500mm，170mm高，45度角，如图
五边形板，1块，如图
*/

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/extrusions.scad>
include <NopSCADlib/utils/layout.scad>
include <NopSCADlib/printed/flat_hinge.scad>
include <feixingchuan_modules.scad>

/*
能够快速拆分为两个部分
*/
//铝型材规格
extrusion_specs=E2020;
extrusion_specs_offset=20;
//extrusion_specs=E4040;
//extrusion_specs_offset=40;
wall_thickness=12;
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
        
extrusion_wedge_down(extrusion_specs,extrusion_specs_offset);}}

        }}
        

 translate([0,0,3]){
        part_text("风帆：E2020, 232mm, 8,两头切相反的45度");
rotate([0,45,0])
for(i=[[-10,0,0]]){
    translate(i){
translate([10,0,20/cos(45)]){
rotate([0,180,0]){
    color("red")
extrusion_wedge_up(extrusion_specs,extrusion_specs_offset);}}
translate([10+10*cos(45),0,10*cos(45)+20*cos(45)]){
rotate([0,45,0]){
    color("blue")
extrusion(E2020,(p_width)/cos(45)-20,center=false,cornerHole=true);}}

    translate([p_width+10,0,p_width]){
rotate([0,0,0]){
        color("red")
extrusion_wedge_up(extrusion_specs,extrusion_specs_offset);}}}}}



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
    
    translate([570,-30,420/2]){
        color("white")
                part_color_text("564*468mm，12mm厚，2块");
       translate([0,0,-100]){
                        part_color_text("挖两个方洞60mm*25mm");
                  translate([0,0,-60]){
                        part_color_text("边缘距离50mm");}
           
           }
        }
// cube([
//         p_length+2*extrusion_specs_offset+wall_thickness*2
//         ,wall_thickness
//         ,p_height - extrusion_specs_offset - wall_thickness
//         ]);
translate([extrusion_specs_offset,0,0])
rotate([0,0,-90])
polygon_extrude_B_wall();
    }
 
translate([0,0,280+30+463]){
 
        
            translate([560,0,330/2-100]){
                color("white")
        part_color_text("右盖588*282mm，12mm厚");}
        
        translate([0, wall_thickness, 0]) 
rotate([0,0,-90]){
//开始
 cube([wall_thickness, p_length + 2*extrusion_specs_offset + 4 * wall_thickness,
    (p_width)/cos(45) + extrusion_specs_offset/cos(45) + wall_thickness/cos(45) + 2*wall_thickness  

  ]);
//500+40+4*12=540+48=588
//(150+20+12)/cos(45*pi/180)+24
//结束

}
 
    ;}
        
//左侧翻盖
    
    translate([0,0,280+30+463+30+258]){
    
        
       translate([560,0,330/2-100]){
                color("white")
        part_color_text("左盖588*258mm，12mm厚");
        
        }
        translate([0, wall_thickness, 0]) 
rotate([0,0,-90]){
  cube([wall_thickness, p_length + extrusion_specs_offset*2 + 4 * wall_thickness,    (p_width)/cos(45) + extrusion_specs_offset/cos(45) + wall_thickness/cos(45)

  ]);}


    }

//带洞木板
    translate([-extrusion_specs_offset/2,wall_thickness,280+30+463+30+258+600]){

translate([500, -20, -80]) 
                            color("white")
        part_color_text("300*500mm，12mm厚");
        
        translate([500, -20, -300]) 
                            color("white")
        part_color_text("中心打孔，直径150mm");
rotate([90,90,0])
 difference(){
   translate([ extrusion_specs_offset/2, extrusion_specs_offset/2, 0])
  color("red")
  cube([2*p_width,p_length,wall_thickness]);
   translate([ p_width+extrusion_specs_offset/2, p_length/2-extrusion_specs_offset/2, -extrusion_specs_offset])
  cylinder(d=150,h=3*extrusion_specs_offset);
 }    }
       
 translate([1300,0,280+30+463+30]){
     
         translate([0,0,50]){
        part_color_text("平行四边形，12mm厚，4块");
         translate([-200,-20,-260]){
             color("black")
             part_color_text("单边长：500mm");
             }    
                      translate([120,-80,-80]){
             color("black")
             part_color_text("45度角");
             }    
             
                      translate([180,-20,-160]){
             color("black")
             part_color_text("高度170mm");
             }    
             
             }
          rotate([0,90,180])   
          polygon_extrude_A();   
    }


  translate([1300,0,280+30+30]){
      
               translate([0,0,80]){
        part_color_text("五边形，12mm厚，2块 ->");}
        
                       translate([280,-40,-30]){
        part_color_text("底边长300mm");}
        
                               translate([600,-40,80]){
        part_color_text("边角高度100mm");}
        
                                       translate([480,-40,180]){
        part_color_text("顶角高度200mm");}
       
        windbreak();

        ;
  }


module part_text(i){
translate([-text_align,0,0])
rotate([90,0,0])
color("black")
text(i,size=10,halign="right",font="微软雅黑",language="cn")
    ;}

module part_color_text(i){
translate([-text_align,0,0])
rotate([90,0,0])
color("black")
text(i,size=30,halign="right",font="微软雅黑",language="cn")
    
    ;}