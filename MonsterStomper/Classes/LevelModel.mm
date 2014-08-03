//
//  LevelModel.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 8/3/14.
//
//

#import "LevelModel.h"
#import "ObstacleModel.h"

@implementation LevelModel
- (id) initWithDict: (NSDictionary*) dict
{
    self = [super init];
    if (self)
    {
        self.levelLength = [[dict objectForKey:@"levelLength"] floatValue];
        self.levelSpeed = [[dict objectForKey:@"levelSpeed"] floatValue];
        self.name = [dict objectForKey:@"name"];
        self.obstacles = [self buildObstacleArray: [dict objectForKey:@"obstacles"]];
    }
    return self;
}

- (NSArray*) buildObstacleArray: (NSArray*) arrayofobstacles {
    NSMutableArray* returnobj = [[NSMutableArray alloc] init];
    for (int i = 0; i < [arrayofobstacles count]; i++)
    {
        [returnobj addObject:[[ObstacleModel alloc] initWithDict:[arrayofobstacles objectAtIndex:i]]];
    }
    return returnobj;
}
@end
