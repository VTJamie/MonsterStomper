//
//  Menu.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/4/14.
//
//

#import "Monster.h"
#import "Game.h"

@implementation Monster

- (id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void) setup
{
    [self loadPlayer];
    [self setupPhysics];
    
    [[Game instance].playarea addEventListener:@selector(handleObjectPhysics) atObject:self forType:EVENT_PHYSICS_READY_FOR_CHANGES];
    [[Game instance].playarea addEventListener:@selector(physicsUpdated) atObject:self forType:EVENT_PHYSICS_UPDATE];
    
    [[Game instance].playarea addEventListener:@selector(touch:) atObject:self forType:EVENT_TOUCH_LEFT_START];
    [[Game instance].playarea addEventListener:@selector(touch:) atObject:self forType:EVENT_TOUCH_LEFT_STOP];
    [[Game instance].playarea addEventListener:@selector(touch:) atObject:self forType:EVENT_TOUCH_RIGHT_START];
    [[Game instance].playarea addEventListener:@selector(touch:) atObject:self forType:EVENT_TOUCH_RIGHT_STOP];
}

- (void) handleObjectPhysics
{
    
}

- (void) physicsUpdated
{
    self.x = self.body->GetPosition().x * PTM_RATIO;
    self.y = Sparrow.stage.height - self.body->GetPosition().y * PTM_RATIO;
    
    self.rotation = -1 * self.body->GetAngle();
    
    if (self.jetpackon)
    {
        self.body->ApplyForce(b2Vec2(0, 30), self.body->GetPosition(), YES);
    }
}

- (void) touch: (SPEvent*) event
{
    if ([event.type compare:EVENT_TOUCH_LEFT_START] == 0)
    {
        self.jetpackon = YES;
    }
    else if ([event.type compare:EVENT_TOUCH_LEFT_STOP] == 0)
    {
        self.jetpackon = NO;
        
    }
    else if ([event.type compare:EVENT_TOUCH_RIGHT_START] == 0)
    {
        
    }
    else if ([event.type compare:EVENT_TOUCH_RIGHT_STOP] == 0)
    {
        
    }
}

- (void) setupPhysics
{
    self.pivotX = 32/2.0f;
    self.pivotY = 48/2.0f;
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(self.x/PTM_RATIO, (Sparrow.stage.height - self.y)/PTM_RATIO);
    ballBodyDef.userData = (__bridge void*) self;
    self.body = [Game instance].playarea.world->CreateBody(&ballBodyDef);
    
    b2PolygonShape polyshape;
    polyshape.SetAsBox(32.0f/PTM_RATIO/2.0f, 48.0f/PTM_RATIO/2.0f);
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &polyshape;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 0.0f;
    ballShapeDef.restitution = 0.0f;
    self.body->CreateFixture(&ballShapeDef);
}

- (void) loadPlayer
{
    
    NSMutableArray* texturearray = [[NSMutableArray alloc] init];
    
    for (int i = 9; i <= 12; i++)
    {
        [texturearray addObject:[Media atlasTexture:[NSString stringWithFormat:@"%@_%02d", self.name, i]]];
    }
    SPMovieClip* movieclip = [[SPMovieClip alloc] initWithFrames:texturearray fps:5];
    [[Game instance].gameJuggler addObject:movieclip];
    [self addChild:movieclip];
    movieclip.loop = YES;
    [movieclip play];
    self.x = 64;
    self.y = Sparrow.stage.height - 200.0;
    
}

@end
