var constants = {
        maxheight: 7.0,
        maxwidth: 1.0,
        maxy: 9.0,
        miny: 1.0,
        minx: 20.0
    };

(function () {

var fs = require('fs'),
    args = process.argv.slice(2),
    numberoflevels = parseInt(args[0], 10),
    steplength = parseInt(args[1], 10),
    stepspeed = parseInt(args[2], 10),
    idx,
    levels = [];

    for (idx = 1; idx <= numberoflevels; idx++) {
        levels.push(generateLevel(idx, steplength, stepspeed));
    }

    fs.writeFile("../MonsterStomper/Classes/Levels.json", JSON.stringify(levels), function(err) {
        if(err) {
            console.log(err);
        } else {
            console.log("The file was saved!");
        }
    });
})();

function generateLevel (level, steplength, stepspeed) {
    var curlevel = {
        "name": "Level " + level,
        "levelLength": (level-1) * steplength + 500.0,
        "levelSpeed": (level-1) * stepspeed + 5.0,
        "obstacles": [
        ]
    }, idx = 1, remainingspace = curlevel.levelLength;

    while (remainingspace >= constants.maxwidth) {
        curlevel.obstacles.push({
            "type": "block",
            "width": constants.maxwidth,
            "height": constants.maxheight,
            "x": constants.minx * idx,
            "y": constants.miny
        });
        idx++;
        remainingspace = remainingspace - curlevel.obstacles[curlevel.obstacles.length-1].width - constants.minx;
    }
    return curlevel;
}




