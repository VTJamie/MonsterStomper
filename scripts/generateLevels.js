var constants = {
        maxheight: 7.0,
        maxwidth: 4.0,
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
    stepobstaclecount = parseInt(args[3], 10),
    idx,
    levels = [];

    for (idx = 1; idx <= numberoflevels; idx++) {
        levels.push(generateLevel(idx, steplength, stepobstaclecount, stepspeed));
    }

    console.log(JSON.stringify(levels));

    fs.writeFile("../MonsterStomper/Classes/Levels.json", JSON.stringify(levels), function(err) {
        if(err) {
            console.log(err);
        } else {
            console.log("The file was saved!");
        }
    });
})();

function generateLevel (level, steplength, stepobstaclecount, stepspeed) {
    var curlevel = {
        "name": "Level " + level,
        "levelLength": level * steplength,
        "levelSpeed": level * stepspeed,
        "obstacles": [
        ]
    }, idx;
    for (idx = 1; idx <= stepobstaclecount*level; idx++) {
        curlevel.obstacles.push({
            "type": "block",
            "width": constants.maxwidth,
            "height": constants.maxheight,
            "x": constants.minx * idx,
            "y": constants.miny
        });
    }
    return curlevel;
}




