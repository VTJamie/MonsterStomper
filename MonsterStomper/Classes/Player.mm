//
//  Menu.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/4/14.
//
//

#import "Player.h"
#import "Game.h"

@implementation Player

- (id) init
{
    self = [super init];
    if (self)
    {
        [self setup];
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
    self.x = self.body->GetPosition().x * PTM_RATIO + [self offset];
    self.y = Sparrow.stage.height - self.body->GetPosition().y * PTM_RATIO;
    
    self.rotation = -1 * self.body->GetAngle();
    
    if (self.jetpackon)
    {
        self.body->ApplyForce(b2Vec2(0, 30), self.body->GetPosition(), YES);
    }
    
    self.body->ApplyForce(b2Vec2(10.0f, 0), self.body->GetPosition(), YES);
    
    const b2Vec2 velocity = self.body->GetLinearVelocity();
    const float32 speed = velocity.x;
    if (speed > 10.0f)
    {
        self.body->SetLinearVelocity(b2Vec2(10.0f, velocity.y));
    }

  //  self.body->SetLinearVelocity(b2Vec2(5.0f, 0.0f));
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
        self.firing = YES;
    }
    else if ([event.type compare:EVENT_TOUCH_RIGHT_STOP] == 0)
    {
        self.firing = NO;
    }
}

- (void) setupPhysics
{
    self.pivotX = 1*PTM_RATIO/2.0f;
    self.pivotY = 2*PTM_RATIO/2.0f;
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    self.startx = self.x/PTM_RATIO*2.0f;
    ballBodyDef.position.Set(self.x/PTM_RATIO, (Sparrow.stage.height/2.0f - self.y)/PTM_RATIO);
    ballBodyDef.userData = (__bridge void*) self;
    ballBodyDef.fixedRotation = YES;
    self.body = [Game instance].playarea.world->CreateBody(&ballBodyDef);
    
    b2PolygonShape polyshape;
    polyshape.SetAsBox(1/2.0f, 2/2.0f);
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &polyshape;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 0.0f;
    ballShapeDef.restitution = 0.0f;

    self.body->CreateFixture(&ballShapeDef);
}

- (void) loadPlayer
{
    SPQuad* playerrectangle = [[SPQuad alloc] initWithWidth:1*PTM_RATIO height:2*PTM_RATIO];
    playerrectangle.color = 0x00FF00;
    [self addChild:playerrectangle];
//    NSMutableArray* texturearray = [[NSMutableArray alloc] init];
//    
//    for (int i = 9; i <= 12; i++)
//    {
//        [texturearray addObject:[Media atlasTexture:[NSString stringWithFormat:@"player_%02d", i]]];
//    }
//    SPMovieClip* movieclip = [[SPMovieClip alloc] initWithFrames:texturearray fps:5];
//    [[Game instance].gameJuggler addObject:movieclip];
//    [self addChild:movieclip];
//    movieclip.loop = YES;
//    [movieclip play];
    self.x = 64;
    self.y = Sparrow.stage.height - 200.0;
    
}

- (float) offset
{
  //  NSLog(@"%f - %f = %f", self.startx, self.body->GetPosition().x, self.startx - self.body->GetPosition().x);
    return (self.startx - self.body->GetPosition().x)*PTM_RATIO;
}

@end
