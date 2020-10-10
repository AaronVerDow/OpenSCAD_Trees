include <../src/tree.scad>;

levels=(sin($t*360)/2+0.5)*12+1;

// RENDER flatgif
module demo() {
    tree(floor(levels),40,120,1234);
}

// RNDER flatgif
module many() {
    for(i=[1:1:100])
    tree(5,40,120,1234+i);
}

demo();

