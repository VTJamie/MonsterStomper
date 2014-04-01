//
//  ContactListener.m
//  MonsterStomper
//
//  Created by Jamieson Abbott on 3/10/14.
//
//

#import "ContactListener.h"
#import "CollisionDelegate.h"

void ContactListener::BeginContact(b2Contact* contact)
{
    b2Body* bodyA = contact->GetFixtureB()->GetBody();
    b2Body* bodyB = contact->GetFixtureA()->GetBody();
    if (bodyA->GetUserData() != NULL)
    {
        SPSprite* bNodeA = (__bridge SPSprite*)bodyA->GetUserData();
        
        if ([bNodeA respondsToSelector:@selector(startCollisionBetween: andObject:)])
        {
            [(id <CollisionDelegate>)bNodeA startCollisionBetween: bodyA andObject: bodyB];
        }
    }
}

void ContactListener::PostSolve(b2Contact *contact, const b2ContactImpulse *impulse)
{
    b2Body* bodyA = contact->GetFixtureB()->GetBody();
        b2Body* bodyB = contact->GetFixtureA()->GetBody();
    if (bodyA->GetUserData() != NULL)
    {
        SPSprite* bNodeA = (__bridge SPSprite*)bodyA->GetUserData();
        if ([bNodeA respondsToSelector:@selector(handleImpulse:)])
        {
            int32 count = contact->GetManifold()->pointCount;
            
            for (int32 i = 0; i < count; ++i)
            {
                [(id <CollisionDelegate>)bNodeA handleImpulse: impulse->normalImpulses[i]];
            }
        }
    }
    
    if (bodyB->GetUserData() != NULL)
    {
        SPSprite* bNodeB = (__bridge SPSprite*)bodyB->GetUserData();
        if ([bNodeB respondsToSelector:@selector(handleImpulse:)])
        {
            int32 count = contact->GetManifold()->pointCount;
            
            for (int32 i = 0; i < count; ++i)
            {
                [(id <CollisionDelegate>)bNodeB handleImpulse: impulse->normalImpulses[i]];
            }
        }
    }
}

void ContactListener::PreSolve(b2Contact *contact, const b2Manifold *oldManifold)
{
    
}

void ContactListener::EndContact(b2Contact* contact)
{
    b2Body* bodyA = contact->GetFixtureB()->GetBody();
    b2Body* bodyB = contact->GetFixtureA()->GetBody();
    if (bodyA->GetUserData() != NULL)
    {
        SPSprite* bNodeA = (__bridge SPSprite*)bodyA->GetUserData();
        if ([bNodeA respondsToSelector:@selector(endCollisionBetween: andObject:)])
        {
            [(id <CollisionDelegate>)bNodeA endCollisionBetween: bodyA andObject: bodyB];
        }
        
    }
}