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


//铝型材的楔子，上方的
module  extrusion_wedge_up(){
  difference(){
translate([-(20/2)*cos(45),0,(20/2)*cos(45)]){
rotate([0,45,0]){
extrusion(E2020,20,center=false,cornerHole=true);}}

translate([0,-11,0]){
cube([30*cos(45),22,20/cos(45)]);}}}