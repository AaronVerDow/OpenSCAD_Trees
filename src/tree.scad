max_levels=6;

// parts that dip below this angle will be stubbed
angle_cutoff=360;

// how much shorter each level is
height_divider=0.7;
height_variance = 0.2;

// taper of each piece
taper = 0.7;
taper_variance = 0.1;

// how far branches can be spread
spread = 65;
spread_variance = 8;

// 1 for normal randomness, 0 to disable
randomness = 1;

// stack parts 
stack=0;

colors=[
    "Indigo", "Red", "Orange", "Yellow", "Green", "Blue",
    "Indigo", "Red", "Orange", "Yellow", "Green", "Blue",
    "Indigo", "Red", "Orange", "Yellow", "Green", "Blue",
];

//seed=$t*100;
//seed=rands(1,1000000,1)[0];
seed=0;

rolls=6;

echo(seed=seed);

function roll(seed, salt=1) = 
    (seed) ? rands(-1,1,rolls,seed*salt)*randomness
    : rands(-1,1,rolls)*randomness;

branch_odds = [0,6,20,6];

function list_sum(list,i=-1,tally=0) = 
    ( i == -1 ) ? list_sum(list,len(list)-1,tally)
    : ( i > 0 ) ? list_sum(list,i-1,tally+list[i])
    : tally+list[i];

function branch(roll, i=0) = 
    ( i >= len(branch_odds) ) ? len(branch_odds)-1
    : ( i < 0 ) ? 0
    : ( (roll/2+0.5)*list_sum(branch_odds) <= list_sum(branch_odds, i) ) ? i
    : branch(roll, i+1);

module tree(level, root, height, seed=0, angle=0, angle_total=0, id=1) {
    if(abs(angle_total) < angle_cutoff)
    if(level > 0) {
        roll=roll(seed, id);
        this_height=height+height*roll[0]*height_variance;
        this_angle=angle+roll[1]*spread_variance;
        this_taper=taper+roll[2]*taper_variance;
        branches=branch(roll[3]);

        tip=root*this_taper;
        color(colors[level])
        hull() {
            circle(d=root);
            rotate([0,0,this_angle])
            translate([0,this_height])
            circle(d=tip);
        }
        if(branches == 1) {
            rotate([0,0,this_angle])
            translate([0,this_height,stack])
            tree(level-1,tip,height*height_divider,seed,0,angle_total+this_angle,id*10+branches);
        } else { 
            for(branch=[1:1:branches])
            rotate([0,0,this_angle])
            translate([0,this_height,stack])
            tree(level-1,tip,height*height_divider,seed,-spread/2+spread/(branches-1)*(branch-1),angle_total+this_angle,id*10+branch);
        }
    }
}

//for(n=[0:1:80])
//tree(max_levels,40,120);
