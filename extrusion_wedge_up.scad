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


//extrusion_specs=E2020;
//extrusion_specs_offset=20;
// extrusion_wedge_up(extrusion_specs,extrusion_specs_offset);

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