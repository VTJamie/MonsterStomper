//
//  CollisionDelegate.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 3/10/14.
//
//

#import <Foundation/Foundation.h>

@protocol CollisionDelegate

@optional
- (void) startCollisionBetween: (b2Body*) obj1 andObject: (b2Body*) obj2;
- (void) endCollisionBetween: (b2Body*) obj1 andObject: (b2Body*) obj2;
- (void) handleImpulse: (float) impulse;

@end
