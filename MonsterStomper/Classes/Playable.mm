//
//  Playable.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/23/14.
//
//

#import "Playable.h"
#import "Background.h"
#import "Death.h"
#import "Golbez.h"
#import "Vampire.h"
#import "Shadow.h"

@implementation Playable

- (id)init
{
    if ((self = [super init]))
    {
        self.timepassed = 0.0;
        self.interval = 2.0;
        self.gameover = NO;
        self.squashed = 0;
        self.secondticker = 0.0;
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"%@", @"Dealloc");
}

- (void)start
{
    [self addChild:[[Background alloc] init]];
    self.currentscore = [[SPTextField alloc] initWithWidth:200 height:50 text:@"0" fontName:@"Arcadepix" fontSize:18 color:0x0000FF];
    self.currentscore.x = Sparrow.stage.width / 2.0 - 100;
    self.currentscore.y = 25;
    [self addChild:self.currentscore];
    
    [self addChild:[[Shadow alloc] init]];
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
   
}

- (void) monsterGotToEnd: (SPEvent*) event
{
    self.gameover = YES;
    [[Game instance] showGameOver:self.squashed];
}

- (void) squashedMonster: (SPEvent*) event
{
    self.squashed++;
    
    self.currentscore.text = [NSString stringWithFormat:@"%d", self.squashed];
}

@end
