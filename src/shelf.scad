include <tree.scad>;

in=25.4;
wood=0.5*in;
shelf_x=3145;
shelf_lip=94;
shelf_lip_h=525;
lip_to_wall=40;
heater=58;
heater_h=185;

shelf_y=200;
shelf_z=shelf_lip_h;


neato=380;

randomness=1;

bit=in/4;

lip=in/2;
lip_gap=bit;

groove_h=in/8;

groove=wood+in/8;

led=in/2;
led_h=in/4;

trees=5;
tree_gap=shelf_x/trees;
echo(tree_gap=tree_gap);
tree_offset=100;
seed=1235;
top_wood=in/4;

pad=0.1;

module top_wood() {
    linear_extrude(height=top_wood)
    children();
}

module wood() {
    linear_extrude(height=wood)
    children();
}

module wall() {
    extra=1.3;

    color("darkslategray")
    translate([0,shelf_y+lip_to_wall]) {
        translate([-shelf_x/2*extra,-lip_to_wall,shelf_lip_h-wood])
        cube([shelf_x*extra,shelf_lip,wood]);

        translate([-shelf_x/2*extra,-heater,0])
        cube([shelf_x*extra,heater,heater_h]);

        translate([-shelf_x/2*extra,0,0])
        cube([shelf_x*extra,wood,shelf_lip_h]);
    }
}

module _lip() {
    translate([0,0,shelf_z-wood])
    wood()
    difference() {
        shelf();
        shelf(lip);
    }
}

module lip() {
    color("saddlebrown")
    _lip();
    color("sienna")
    translate([0,0,-wood])
    _lip();
}

module shelf(extra=0) {
    translate([0,shelf_y/2+extra/2,0])
    square([shelf_x-extra*2,shelf_y-extra],center=true);
}

module trees(this_seed=0) {
    for(x=[-shelf_x/2+tree_gap/2:tree_gap:shelf_x/2-tree_gap/2]) {
        seed=x+1+seed+this_seed;
        echo(seed);
        translate([x,-tree_offset])
        tree(5,93,280,seed);
    }
}

module trees_3d(this_seed=0) {
    translate([0,wood])
    rotate([90,0])
    wood()
    intersection() {
        translate([-shelf_x/2+lip,0])
        square([shelf_x-lip*2,shelf_z-wood+groove_h]);
        trees(this_seed);
    }
}

module top() {
    color("brown")
    translate([0,0,shelf_z])
    top_wood()
    shelf();
}

module groove() {
    for(n=[0:1:len(tree_layers)-1])
    translate([0,shelf_y/(len(tree_layers)+1)*(n+1)-wood/2])
    translate([-shelf_x/2,-groove/2+wood/2])
    square([shelf_x,groove]);
}


module grooves() {
    groove();

}

module leds() {
    for(n=[0:1:len(tree_layers)])
    translate([0,shelf_y/(len(tree_layers)+2)*(n+1)-wood/2])
    translate([-shelf_x/2,-groove/2+wood/2])
    square([shelf_x,groove]);
}

module shelf_base() {
    //color("chocolate")
    translate([0,0,shelf_z-wood])
    difference() {
        wood()
        shelf(lip+lip_gap);

        grooves();
        leds();
    }
}

shelf_base();

top(); lip();
wall();
// values are seeds
tree_layers=[1,12];
tree_colors=["white", "tan"];
tree_1=shelf_y/3-wood/2;
tree_2=shelf_y/3*2-wood/2;

for(n=[0:1:len(tree_layers)-1])
color(tree_colors[n])
translate([0,shelf_y/(len(tree_layers)+1)*(n+1)-wood/2])
trees_3d(tree_layers[n]);
