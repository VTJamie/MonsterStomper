//
//  ObstacleModel.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 8/3/14.
//
//

#import "ObstacleModel.h"

@implementation ObstacleModel
- (id) initWithDict: (NSDictionary*) dict
{
    self = [super init];
    if (self)
    {
        self.width = [[dict objectForKey:@"width"] floatValue];
        self.height = [[dict objectForKey:@"height"] floatValue];
        self.x = [[dict objectForKey:@"x"] floatValue];
        self.y = [[dict objectForKey:@"y"] floatValue];
        self.type = [dict objectForKey:@"type"];
    }
    return self;
}
@end
