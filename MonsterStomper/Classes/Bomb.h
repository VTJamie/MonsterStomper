//
//  Bomb.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 3/10/14.
//
//

#import "SPSprite.h"
#import "CollisionDelegate.h"
#import "Box2DCreatorDelegate.h"

@interface Bomb : SPSprite <CollisionDelegate, Box2DCreatorDelegate>

@property (nonatomic, assign) b2Body *body;
@property (nonatomic, assign) float boxwidth;
@property (nonatomic, assign) float boxheight;

- (void) setup;

@end
