//
//  Playable.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/23/14.
//
//

#import "Playable.h"
#import "ContactListener.h"
#import "Level.h"

@implementation Playable

- (id)init
{
    if ((self = [super init]))
    {
        self.createobjects = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"%@", @"Dealloc");
}

- (void)start
{
    SPQuad* fullbackground = [[SPQuad alloc] initWithWidth:Sparrow.stage.width height:Sparrow.stage.height color: 0x000000];
    [self addChild:fullbackground];

    
    b2Vec2 gravity = b2Vec2(0.0f, -8.0f);
    self.world = new b2World(gravity);
    
    self.world->SetContactListener(new ContactListener());
    self.world->SetContinuousPhysics(YES);
    
    // Create a world
    
    [self createObjects];
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    [self addEventListener:@selector(touch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_PHYSICS_READY_FOR_CHANGES bubbles:YES]];
    self.world->Step(event.passedTime, 10, 10);
    [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_PHYSICS_UPDATE bubbles:YES]];
}


- (void) touch: (SPTouchEvent*) event
{
    SPTouch* touchstart= [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    SPTouch* touchend = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] anyObject];
    if (touchstart)
    {
        SPPoint* point = [touchstart locationInSpace:self];
        
        if (point.x < Sparrow.stage.width/2.0)
        {
            [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_TOUCH_LEFT_START bubbles:YES]];
        }
        else
        {
            [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_TOUCH_RIGHT_START bubbles:YES]];
        }
    }
    else if (touchend)
    {
        SPPoint* point = [touchend locationInSpace:self];
        
        if (point.x < Sparrow.stage.width/2.0)
        {
            [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_TOUCH_LEFT_STOP bubbles:YES]];
        }
        else
        {
            [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_TOUCH_RIGHT_STOP bubbles:YES]];
        }
    }
}

- (void) createObjects
{
    self.currentlevel = [[Level alloc] initWithLevel:1];
    [self addChild: self.currentlevel];
}
@end
