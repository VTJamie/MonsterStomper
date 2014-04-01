//
//  Playable.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/23/14.
//
//

#import "Playable.h"
#import "Death.h"
#import "BuildingBlock.h"
#import "ContactListener.h"
#import "Bomb.h"

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
    
    
    SPQuad* quad = [[SPQuad alloc] initWithWidth:Sparrow.stage.width height:1*PTM_RATIO color:0x00FFFF];
    quad.x = 0;
    quad.y = Sparrow.stage.height - PTM_RATIO;
    
    
    [self addChild:quad];
    
    b2Vec2 gravity = b2Vec2(0.0f, -8.0f);
    self.world = new b2World(gravity);
    
    //in FooTest constructor
    self.world->SetContactListener(new ContactListener());
    self.world->SetContinuousPhysics(YES);
    
    self.followobject = [[Death alloc] init];
    [self addChild:self.followobject];
    // Create a world
    
    
    double right = Sparrow.stage.width/PTM_RATIO;
    double top = Sparrow.stage.height/PTM_RATIO - 1;
    //b2Vec2(0,0), b2Vec2(Sparrow.stage.width/PTM_RATIO, 0)
    [self createWall:b2Vec2(0,0) end:b2Vec2(right, 0)];
    [self createWall:b2Vec2(0,0) end:b2Vec2(0, top)];
    [self createWall:b2Vec2(right, 0) end:b2Vec2(right, top)];
    [self createWall:b2Vec2(right, top) end:b2Vec2(0, top)];
    
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    [self addEventListener:@selector(touch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_PHYSICS_READY_FOR_CHANGES bubbles:YES]];
    self.world->Step(event.passedTime, 10, 10);
    [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_PHYSICS_UPDATE bubbles:YES]];
    
//    for(b2Body *b = self.world->GetBodyList(); b; b=b->GetNext()) {
//        if (b->GetUserData() != NULL) {
//            NSObject *obj = (__bridge NSObject *)b->GetUserData();
//            if ([[obj class] isSubclassOfClass:[NSString class]])
//            {
//                if (ABS(b->GetLinearVelocity().x) + ABS(b->GetLinearVelocity().y) <= 2.0f)
//                {
//                    if ([[obj class] isSubclassOfClass:[SPQuad class]])
//                    {
//                        [(SPQuad*)obj removeFromParent];
//                    }
//                    self.world->DestroyBody(b);
//                }
//            }
//            else if ([[obj class] isSubclassOfClass:[SPSprite class]])
//            {
//                
//                SPSprite* sprite = (SPSprite*)obj;
//                sprite.x = b->GetPosition().x * PTM_RATIO;
//                sprite.y = Sparrow.stage.height - b->GetPosition().y * PTM_RATIO;
//                
//                sprite.rotation = -1 * b->GetAngle();
//            }
//        }
//    }
}

- (void) createWall: (b2Vec2) start end: (b2Vec2) end
{
    b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0,1);
    
    b2EdgeShape groundEdge;
	b2FixtureDef boxShapeDef;
    
	b2Body *groundBody = self.world->CreateBody(&groundBodyDef);
    
	boxShapeDef.shape = &groundEdge;
    
	//wall definitions
    //	groundEdge.Set(b2Vec2(0,0), b2Vec2(Sparrow.stage.width/PTM_RATIO, 0));
    groundEdge.Set(start, end);
	groundBody->CreateFixture(&boxShapeDef);
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
@end
