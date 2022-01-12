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

translate([0,0,70])
rotate([0,90,0])
extrusion(E2020,300,center=false);

translate([0,0,100])
rotate([0,90,0])
extrusion(E2020,500,center=false);

translate([0,0,130])
rotate([0,90,0])
extrusion(E2020,540,center=false);

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
extrusion_wedge_up();}}}}

translate([0,0,40]){
rotate([0,90,0]){
        color("yellow")
extrusion(E2020,p_height-20,center=false,cornerHole=true);
    translate([
    10,0,p_height
    ]){
    rotate([0,90+45,0]){       color("red")
        
extrusion_wedge_down();}}

        }}