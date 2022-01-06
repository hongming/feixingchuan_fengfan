
module linear_actuator_close(){
    translate([0,12,17]){
cube([22,24,10]);}

    translate([22,45,2]){
        color("blue")
cube([132,40,40]);}

translate([22,0,0]){
    color("black")
cube([200+120-11-11,45,45]);}

    translate([200+120-11-11+11+10,12,11]){
        color("red")
cube([22,20,20]);}
    }
    
    

module linear_actuator_open(){
    translate([0,18,11]){
cube([22,10,24]);}

    translate([22,45,2]){
        color("blue")
cube([132,40,40]);}

translate([22,0,0]){
        color("black")
cube([200+120-11-11,45,45]);}

    translate([200+120-11-11+11+10+200,12,11]){
        color("red")
cube([22,20,20]);}

    translate([200+120-11-11+11+10,12,11]){
 
cube([200,20,20]);}

    }