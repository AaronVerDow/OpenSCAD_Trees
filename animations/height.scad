include <../src/tree.scad>;

stack=1;
height=(sin($t*360)/2+0.5)*300+10;

// RENDER flatgif
module demo() {
    tree(5,40,height,1234);
}

// RNDER flatgif
module many() {
    for(i=[1:1:100])
    tree(5,40,height,1234+i);
}

demo();

