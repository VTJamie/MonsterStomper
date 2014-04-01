//
//  ContactListener.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 3/10/14.
//
//

#import <Foundation/Foundation.h>

class ContactListener : public b2ContactListener
{
private:
    void BeginContact(b2Contact* contact);
    void EndContact(b2Contact* contact);
    void PostSolve(b2Contact *contact, const b2ContactImpulse *impulse);
    void PreSolve(b2Contact *contact, const b2Manifold *oldManifold);
};