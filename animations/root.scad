include <../src/tree.scad>;

root=(sin($t*360)/2+0.5)*100+10;

// RENDER flatgif
module demo() {
    tree(5,root,120,1234);
}

// RENDER flatgif
module many() {
    for(i=[1:1:100])
    tree(5,root,120,1234+i);
}

demo();

