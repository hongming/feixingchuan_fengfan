

module equipments(){

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