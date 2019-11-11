/* [VENT BASE] */
BASE_WIDTH = 158;   //195
BASE_HEIGHT = BASE_WIDTH;  //195
BASE_THICKNESS = 0.5; //2
WITH_BASE = true;

/* [TUBE] */
TUBE_DIAMETER = 155;    //152
TUBE_WALL_THICKNESS = 2;
TUBE_HEIGHT = 5;   // 40

/* [LINES] */
LINE_HEIGHT = 26;   // 25
LINE_THICKNESS = 2;
LINE_ANGLE = 40;    // 45
LINE_SPACING = 15;
LINES_COUNT = 10;
WITH_LINES = false;

// HIDDEN
EXPLODE = 0;
$fn = 128;

air_vent();

module air_vent(){
    color("white")
    union(){
        difference(){
            base_with_tube();
            hole();        
        }
        if(WITH_LINES){
            intersection(){
                horizontal_lines();
                tube();
            }
        }
    }
}

module base_with_tube(){
    union(){
        if(WITH_BASE){
            base();
        }
        tube();
    }    
}

module base(){
    translate([0,0, BASE_THICKNESS/2])    
    rounded_corners(BASE_WIDTH, BASE_HEIGHT, BASE_THICKNESS, 20);
}

//module tube_with_spacers(){
//    difference(){
//        tube();
//    }
//    
//    
//    translate([0,0,TUBE_HEIGHT/2])
//    cube([BASE_WIDTH, LINE_HEIGHT, TUBE_HEIGHT], true);    
//}

module tube(){
    radius = TUBE_DIAMETER/2;
    cylinder(TUBE_HEIGHT, radius, radius);    
}

module hole(){
    radius = (TUBE_DIAMETER - TUBE_WALL_THICKNESS) / 2;
    translate([0,0,-TUBE_HEIGHT/2])
    cylinder(2*TUBE_HEIGHT, radius, radius);
}

module horizontal_lines(){
    count = LINES_COUNT;    
    translate_step = LINE_SPACING;
    initial_translate = count*translate_step;
    for (n = [-count/2:1:count/2]){
        translate([0, n*translate_step, 0])
        rotate([LINE_ANGLE,0,0])
        line();
    };         
}

module line(){
    translate([0, 0, LINE_THICKNESS/2])
    cube([BASE_WIDTH, LINE_HEIGHT, LINE_THICKNESS], true);
}

// To be a library
module rounded_corners(width, height, depth, corner_curve){
    x_translate = width-corner_curve;
    y_translate = height-corner_curve;     
    
    hull(){
            translate([-x_translate/2, -y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);    
            
            translate([-x_translate/2, y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);

            translate([x_translate/2, y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);        
            
            translate([x_translate/2, -y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);        
    }        
}

