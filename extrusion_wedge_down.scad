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
//
//extrusion_wedge_down(extrusion_specs,extrusion_specs_offset);

//铝型材的楔子，切口在下方的
module  extrusion_wedge_down(extrusion_specs,extrusion_specs_offset){
 difference(){
translate([(extrusion_specs_offset/2)*cos(45),0,-(extrusion_specs_offset/2)*cos(45)]){
rotate([0,45,0]){
extrusion(extrusion_specs,extrusion_specs_offset,center=false,cornerHole=true);}}

translate([-2*extrusion_specs_offset,-extrusion_specs_offset,-extrusion_specs_offset*cos(45)]){
cube([4*extrusion_specs_offset,2*extrusion_specs_offset,extrusion_specs_offset*cos(45)]);}

}

}