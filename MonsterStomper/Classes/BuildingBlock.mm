//
//  Block.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 3/5/14.
//
//

#import "BuildingBlock.h"

@implementation BuildingBlock
- (id) init
{
    self = [super init];
    if (self)
    {
        self.boxwidth = 1.0f;
        self.boxheight = 1.0f;
        self.blockFixtures = [[NSMutableArray alloc] init];
        self.health = 100.0f;
    }
    return self;
}

- (void) setup
{
    
    self.pivotX = self.boxwidth*PTM_RATIO/2.0;
    self.pivotY = self.boxheight*PTM_RATIO;
    
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(self.x/PTM_RATIO, (Sparrow.stage.height - self.y)/PTM_RATIO);
    ballBodyDef.userData = (__bridge void*) self;
    self.body = [Game instance].playarea.world->CreateBody(&ballBodyDef);
    
    
    [self drawFixtureAt:b2Vec2(0.0f, -self.boxheight/2.0f) WithSize:b2Vec2(self.boxwidth/2.0f, self.boxheight/2.0f)];
    [self drawFixtureAt:b2Vec2(0.0f, self.boxheight/2.0f) WithSize:b2Vec2(self.boxwidth/2.0f, self.boxheight/2.0f)];
}

- (void) drawFixtureAt: (b2Vec2) position WithSize: (b2Vec2) size
{
    
    SPQuad* quad = [[SPQuad alloc] initWithWidth:size.x*PTM_RATIO*2 height:size.y*PTM_RATIO*2 color:0x0000FF];
    quad.x = 0;
    quad.y = (position.y+size.y)*PTM_RATIO;
    [self addChild:quad];
    
    b2PolygonShape polyshape;
    polyshape.SetAsBox(size.x, size.y, position, 0.0f);
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &polyshape;
    ballShapeDef.density = 0.1f;
    ballShapeDef.friction = 1.0f;
    ballShapeDef.restitution = 0.0f;
    b2Fixture* fixture = self.body->CreateFixture(&ballShapeDef);
    [self.blockFixtures addObject:[NSValue valueWithPointer:fixture]];
    
}

- (void) handleCreateDestroy
{
    NSLog(@"%@", @"Destroy");
    for (int i = 0; i < [self.blockFixtures count]; i++)
    {
        b2Fixture* fixture = (b2Fixture*)[[self.blockFixtures objectAtIndex:i] pointerValue];
        self.body->DestroyFixture(fixture);
    }
    [Game instance].playarea.world->DestroyBody(self.body);
    self.body = nil;
    
//    // Create two bodies from one.
//    b2Body* body1 = m_piece1->GetBody();
//    b2Vec2 center = body1->GetWorldCenter();
//    
//    body1->DestroyFixture(m_piece2);
//    m_piece2 = NULL;
//    
//    b2BodyDef bd;
//    bd.type = b2_dynamicBody;
//    bd.position = body1->GetPosition();
//    bd.angle = body1->GetAngle();
//    
//    b2Body* body2 = m_world->CreateBody(&bd);
//    m_piece2 = body2->CreateFixture(&m_shape2, 1.0f);
//    
//    // Compute consistent velocities for new bodies based on
//    // cached velocity.
//    b2Vec2 center1 = body1->GetWorldCenter();
//    b2Vec2 center2 = body2->GetWorldCenter();
//    
//    b2Vec2 velocity1 = m_velocity + b2Cross(m_angularVelocity, center1 - center);
//    b2Vec2 velocity2 = m_velocity + b2Cross(m_angularVelocity, center2 - center);
//    
//    body1->SetAngularVelocity(m_angularVelocity);
//    body1->SetLinearVelocity(velocity1);
//    
//    body2->SetAngularVelocity(m_angularVelocity);
//    body2->SetLinearVelocity(velocity2);
    
    [self removeFromParent];
}

- (void) handleImpulse:(float)impulse
{
    if (self.health > 0.0f)
    {
        self.health -= impulse;
        if (self.health < 0.0f)
        {
            self.health = 0.0f;
        }
    }
    
    if (self.health == 0.0f)
    {
       // [[Game instance].playarea.createobjects addObject:self];
    }
}

- (void) weld: (BuildingBlock*) weldto
{
    //    b2WeldJointDef jointDef;
    //    jointDef.bodyA = weldto.body;
    //    jointDef.bodyB = self.body;
    //    jointDef.localAnchorA = b2Vec2(0, self.boxheight/2.0);
    //    jointDef.localAnchorB = b2Vec2(0, -self.boxheight/2.0);
    //    //create the joint
    //    [Game instance].playarea.world->CreateJoint( &jointDef );
}

@end
