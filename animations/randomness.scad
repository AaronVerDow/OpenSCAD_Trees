include <../src/tree.scad>;

randomness=(sin($t*360)/2+0.5)*2;

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

