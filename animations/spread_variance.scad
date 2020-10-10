include <../src/tree.scad>;

spread_variance=(sin($t*360)/2+0.5)*30;

// RENDER flatgif
module demo() {
    tree(5,40,120,1234);
}

demo();
