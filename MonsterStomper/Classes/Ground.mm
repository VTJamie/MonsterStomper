//
//  Ground.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 4/22/14.
//
//

#import "Ground.h"

@implementation Ground

- (id) initWithLoc: (b2Vec2) position andSize: (b2Vec2) size
{
    self = [super init];
    if (self)
    {
        self.initwidth = size.x;
        self.initheight = size.y;
        self.initx = position.x;
        self.inity = position.y;

        [self setup];
    }
    return self;
}

- (void) setup
{
    [self loadSprite];
    [self setupPhysics];
    
    [[Game instance].playarea addEventListener:@selector(handleObjectPhysics) atObject:self forType:EVENT_PHYSICS_READY_FOR_CHANGES];
    [[Game instance].playarea addEventListener:@selector(physicsUpdated) atObject:self forType:EVENT_PHYSICS_UPDATE];
}

- (void) handleObjectPhysics
{
    
}

- (void) physicsUpdated
{
    self.x = self.body->GetPosition().x * PTM_RATIO + [[Game instance].playarea.currentlevel.player offset];
    self.y = Sparrow.stage.height - self.body->GetPosition().y * PTM_RATIO;
    
    self.rotation = -1 * self.body->GetAngle();
}

- (void) setupPhysics
{
    self.pivotX = self.initwidth*PTM_RATIO/2.0f;
    self.pivotY = self.initheight*PTM_RATIO/2.0f;
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_staticBody;

    ballBodyDef.position.Set(self.initx, self.inity);
    ballBodyDef.userData = (__bridge void*) self;
    ballBodyDef.fixedRotation = YES;
    self.body = [Game instance].playarea.world->CreateBody(&ballBodyDef);
    
    b2PolygonShape polyshape;
    polyshape.SetAsBox(self.initwidth/2.0f, self.initheight/2.0f);
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &polyshape;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 0.0f;
    ballShapeDef.restitution = 0.0f;
    
    self.body->CreateFixture(&ballShapeDef);
}

- (void) loadSprite
{
    SPQuad* playerrectangle = [[SPQuad alloc] initWithWidth:self.initwidth*PTM_RATIO height:self.initheight*PTM_RATIO];
    playerrectangle.color = 0x0000FF;
    
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
    
}

@end
