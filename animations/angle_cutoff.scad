include <../src/tree.scad>;

angle_cutoff=(sin($t*360)/2+0.5)*180;

// RENDER flatgif
module demo() {
    tree(5,40,120,1234);
}

// RENDER flatgif
module many() {
    for(i=[1:1:100])
    tree(5,40,120,1234+i);
}

demo();
