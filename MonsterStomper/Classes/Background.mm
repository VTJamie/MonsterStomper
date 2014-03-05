//
//  Background.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/8/14.
//
//

#import "Background.h"

@implementation Background

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

- (void)dealloc
{

}

- (void)setup
{
    SPImage* referencetile = [SPImage imageWithContentsOfFile:@"background.png"];
    referencetile.scaleX =  Sparrow.stage.height / referencetile.height;
    referencetile.scaleY =  Sparrow.stage.height / referencetile.height;
    referencetile.x = 0;
    referencetile.y = 0;

    [self addChild:referencetile];
    
}

@end
