//
//  Bomb.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 3/10/14.
//
//

#import "Bomb.h"

@implementation Bomb

- (id) init
{
    self = [super init];
    if (self)
    {
        self.boxwidth = 1.0f;
        self.boxheight = 1.0f;
    }
    return self;
}

- (void) setup
{
    
    self.pivotX = self.boxwidth*PTM_RATIO / 2.0f;
    self.pivotY = self.boxheight*PTM_RATIO / 2.0f;
    
    
    SPQuad* quad = [[SPQuad alloc] initWithWidth:self.boxwidth*PTM_RATIO height:self.boxheight*PTM_RATIO color:0x00AAAA];
    [self addChild:quad];
    
    
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(self.x/PTM_RATIO, (Sparrow.stage.height - self.y)/PTM_RATIO);
    ballBodyDef.userData = (__bridge void*) self;

    
    b2PolygonShape polyshape;
    polyshape.SetAsBox(self.boxwidth/2.0f, self.boxheight/2.0f);
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &polyshape;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 1.0f;
    ballShapeDef.restitution = 0.5f;
    self.body = [Game instance].playarea.world->CreateBody(&ballBodyDef);
    self.body->CreateFixture(&ballShapeDef);
}

- (void) startCollisionBetween: (b2Body*) obj1 andObject: (b2Body*) obj2
{
    if([self.parent containsChild:self])
    {
        
        [[Game instance].playarea.createobjects addObject:self];
    }
}

- (void) handleImpulse:(float)impulse
{
    
}

- (void) endCollisionBetween: (b2Body*) obj1 andObject: (b2Body*) obj2
{
  
}

- (void) handleCreateDestroy
{
      NSLog(@"%@", @"Destroy Bomb");
    [self removeFromParent];
    [self explosionCenter:self.body->GetPosition()];
    self.body->SetUserData(nil);
    [Game instance].playarea.world->DestroyBody(self.body);
    self.body = nil;
}

- (void) explosionCenter: (b2Vec2) center
{
    //  dispatch_async(dispatch_get_main_queue(), ^{
    
    int numRays = 20;
    int blastPower = 200;
    for (int i = 0; i < numRays; i++) {
//        SPQuad* quad = [[SPQuad alloc] initWithWidth:0.15*PTM_RATIO height:0.15*PTM_RATIO color:0x33BBCC];
//        [self addChild:quad];
        float angle = i*(2*M_PI / (float)numRays);
        b2Vec2 rayDir( sinf(angle), cosf(angle) );
        
        b2BodyDef bd;
        bd.type = b2_dynamicBody;
        bd.fixedRotation = true; // rotation not necessary
        bd.bullet = true; // prevent tunneling at high speed
        bd.linearDamping = 10; // drag due to moving through air
        bd.gravityScale = 0; // ignore gravity
        bd.position = center; // start at blast center
        //    bd.userData = (__bridge void*)quad;
        
        bd.linearVelocity = blastPower * rayDir;
        
        b2CircleShape circleShape;
        circleShape.m_radius = 0.05; // very small
        
        b2FixtureDef fd;
        fd.shape = &circleShape;
        fd.density = 2000 / (float)numRays; // very high - shared across all particles
        fd.friction = 0; // friction not necessary
        fd.restitution = 0.99f; // high restitution to reflect off obstacles
        fd.filter.groupIndex = -1; // particles should not collide with each other
        b2Body* body = [Game instance].playarea.world->CreateBody( &bd );
    //    body->SetUserData((__bridge void*)quad);
        body->SetUserData((__bridge void*)@"volatile");
        body->CreateFixture( &fd );
    }
    
    
    //  });
}


@end
