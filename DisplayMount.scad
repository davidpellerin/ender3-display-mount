include <polyround.scad>;

/*
 * Parameter
 * Feel free to edit this section
 * ALWAYS CHECK THE MODEL BEFORE PRINTING!!!
 */
strength = 3; // Wall thickness
angle=30; // Angle of the display 
// WARNING: Some angle break the corner!!!
angleSupport=5; // Strength of the support between the display plate and the plate with the logo
enderLogo=true; // Enable/Disable the ender logo on the front panel

// Display mounting Holes
mountHeight=6.5; // Defines the height of the mounting stands
holeDiameter=2.8; // Diameter of the holes for the display mounts
outerDiameter=6; // Overall diameter of the display mounts

/*
 * Model Type to export:
 * 0 = Combined stand and button insert
 * 1 = Only the stand
 * 2 = Only the button insert
 * 3 = (Test) Only prints the display mount (with button insert)
 */
modelType=0;


/*
 * Model
 * Changes in this section might break stuff!
 */
        
module ExtrutionEndMount(){
    rotate([90,0,0]){
        cylinder(r=3.5, h=10);
         translate([0,0,-3.5])
                cylinder(r=5, h=5);
    }
    translate([-19.50,0,19.5])
        rotate([90,0,0]){
            cylinder(r=3.5, h=10);
            translate([0,0,-3.5])
                cylinder(r=5, h=5);
        }
}

module MountingPlate(){
    $fs=0.5; 
    difference(){
        translate([0,-strength,0])
            cube([110,strength,50]);
        

            translate([29.5,0,20]){
                color("red")
                    ExtrutionEndMount();
            }
            
            if(enderLogo){
                translate([74,-1,23])
                    scale([0.6,2,0.6])
                        rotate([-90,0,0])
                            color("blue")
                                import("Creality_Ender-3_Logo.stl");
            }
    }
}

module ButtonExt(l){
    cylinder(h=2.4 + strength, d=5);
    translate([0,0,strength+2.4])
        cylinder(h=1, d=8);
    translate([0,0,strength+3.4])
        cylinder(h=l, d=3);
}

module DisplayPlate(){
    difference(){
        cube([110,strength,100]);
        translate([8.5,-mountHeight-5.7,5]){
            translate([65,0,79])
                rotate([-90,0,0]) {
                    cylinder(d=14,h=12);
                    cylinder(d=2,h=30);
                }
                translate([77,0,73]){
                    cube([12,8.2,11.8]);
                    translate([6,0,11.8/2])
                        rotate([-90,0,0])
                            cylinder(d=10,h=30);
                }
                
           translate([7.0,0,9.5])
                color("black")
                    cube([79,30,52]);
                
           translate([50,30,90-11])
                rotate([90,0,0])
                    cylinder(d=6,h=30);
        }
    }
    
    $fs=0.5; 
    translate([8.5,0,5]){
        translate([2.5,0,2.5])
        rotate([90,0,0])
        difference(){
                    cylinder(d=outerDiameter,h=mountHeight);
                    cylinder(d=holeDiameter,h=12);
        }
        
        translate([90.5,0,2.5])
        rotate([90,0,0])
        difference(){
                    cylinder(d=outerDiameter,h=mountHeight);
                    cylinder(d=holeDiameter,h=12);
        }
        
        translate([90.5,0,67.5])
        rotate([90,0,0])
        difference(){
                    cylinder(d=outerDiameter,h=mountHeight);
                    cylinder(d=holeDiameter,h=12);
        }
        
        translate([2.5,0,67.5])
        rotate([90,0,0])
        difference(){
                    cylinder(d=outerDiameter,h=mountHeight);
                    cylinder(d=holeDiameter,h=12);
        }
        
       translate([0,-mountHeight-5.7,0]){
            //Display();
            
       }
       
       if(modelType == 0 || modelType == 3) {
           translate([50,strength,90-11])
                    rotate([90,0,0])
                        ButtonExt(mountHeight-2.6);
       }
    }
}

module Anchor(){
    r=strength;
    r2=angleSupport;
    b=[[0,0,0],[0,r,0],[-tan(angle/2)*r,r,r],[-cos(angle)*r,sin(angle)*r,0]];
    translate([110,-r,0])
            rotate([0,-90,0])
                linear_extrude(110)
                    polygon(polyRound(b));
    
    b2=[[r2,0], [0,0], [-sin(angle)*r2,-cos(angle)*r2]];
    translate([110,-r,0])
            rotate([0,-90,0])
                linear_extrude(110)
                    polygon(b2);
}

/*
module Display(){
    color("red")
        cube([93,1.6,87]);
    color("green")
        cube([93,5.7,70.4]);
    translate([7.5,0,10])
        color("black")
            cube([78.4,14.3,51]);
     color("grey")
        translate([77,0,73]){
            cube([12,8.2,11.8]);
            translate([6,0,11.8/2])
                rotate([-90,0,0])
                    cylinder(d=7,h=30);
    }
    
    color("black")
         translate([65,0,79])
            rotate([-90,0,0])
                cylinder(d=12,h=11.2);
    
    color("grey")
         translate([47,0,87-11])
                cube([6,6.5,6]);
}
*/

if(modelType == 0 || modelType == 1) {
    rotate([180,0,0]){
        MountingPlate();
        Anchor();
        translate([0,-strength,-100])
            translate([0,-cos(angle)*100,100-sin(angle)*100])
                rotate([-90+angle,0,0])
                    DisplayPlate();
    }
}
else if(modelType == 2) {
    rotate([180,0,0])
        ButtonExt(mountHeight-1.4);
}
else if(modelType == 3){
    DisplayPlate();
}






    
    


       
  
    
