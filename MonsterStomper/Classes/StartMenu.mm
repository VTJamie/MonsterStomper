//
//  Menu.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/4/14.
//
//

#import "StartMenu.h"
#import "Game.h"

#import "Player.h"

@implementation StartMenu

- (id) init
{
    self = [super init];
    if (self)
    {
        self.timepassed = 0.0;
    }
    return self;
}

- (void) setup
{
    self.monsterlayer = [[SPSprite alloc] init];
    [self addChild:self.monsterlayer];
        
    [self.newgame addEventListener:@selector(startGame:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void) startGame: (SPTouchEvent*) event
{
    SPTouch* touch = [[event touchesWithTarget:self.newgame andPhase:SPTouchPhaseEnded] anyObject];
    if (touch)
    {
        [[Game instance] startGame];
    }
}

- (void) onEnterFrame: (SPEnterFrameEvent*) event
{
  
}

@end
