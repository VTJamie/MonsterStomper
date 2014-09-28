//
//  Level.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 4/22/14.
//
//

#import "Level.h"
#import "Ground.h"
#import "LevelModel.h"
#import "Obstacle.h"
#import "ObstacleModel.h"

@implementation Level

- (id) initWithLevel: (int) levelnum
{
    self = [super init];
    if (self)
    {
        self.levelnumber = levelnum;
        [self setup];
    }
    return self;
}

- (void) setup
{
    LevelModel* level = [self loadLevel];
    [self addChild:[[Ground alloc ] initWithLoc:b2Vec2(0,0) andSize:b2Vec2(level.levelLength, 1.0f)]];
    [self addChild:[[Ground alloc ] initWithLoc:b2Vec2(0,Sparrow.stage.height/PTM_RATIO) andSize:b2Vec2(level.levelLength, 1.0f)]];
    for (int i = 0; i < [level.obstacles count]; i++)
    {
        ObstacleModel* curobs = [level.obstacles objectAtIndex:i];
        [self addChild:[[Obstacle alloc] initWithLoc:b2Vec2(curobs.x, curobs.y) andSize:b2Vec2(curobs.width, curobs.height)]];
    }
    
    self.player = [[Player alloc] init];
    [self addChild:self.player];
}

- (LevelModel*) loadLevel {
    
    NSError* error = nil;
    NSString *levelname = @"Levels";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:levelname ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return [[LevelModel alloc] initWithDict:[json objectAtIndex:self.levelnumber-1]];
}


@end
