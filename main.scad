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
  include <feixingchuan_modules.scad>

  /*
  能够快速拆分为两个部分
  */

  /*
  Parallelogram平行四边形
  宽：150mm
  高：500mm，要考虑增高节
  长：500mm
  木板：17mm
  */
p_width = 150;
p_height = 500;
p_length = 500;

//木板厚度
wall_thickness = 17;

//底座高度
base_height=380;

//底座分离数值
base_offset=0;

//左右两侧张开角度
// rotate_left=60;
// rotate_right=60;
rotate_left=60-60*$t;
rotate_right=60-60*$t;

$vpr = [80,0, -$t * 45];

//铝型材规格
extrusion_specs=E2020;
extrusion_specs_offset=20;
//extrusion_specs=E4040;
//extrusion_specs_offset=40;

//是否放电动推杆
linear_actuator_preview = 1;
//是否显示外壳
obs_cover_preview = 0;
//是否显示挡风板
obs_windbreak_preview = 1;
 
 //是否显示望远镜
 equipments_preview =1;
 telescope_pier_preview=1;
 
if($preview){
 
obs(linear_actuator_preview, obs_cover_preview);
translate([extrusion_specs_offset/2,0,0]){
obs_base(equipments_preview, telescope_pier_preview,rotate_left);
}

}