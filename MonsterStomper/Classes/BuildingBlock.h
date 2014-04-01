//
//  Block.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 3/5/14.
//
//

#import "Box2DCreatorDelegate.h"
#import "CollisionDelegate.h"

@interface BuildingBlock : SPSprite <Box2DCreatorDelegate, CollisionDelegate>

@property (nonatomic, assign) b2Body *body;
@property (nonatomic, assign) float boxwidth;
@property (nonatomic, assign) float boxheight;
@property (nonatomic, assign) float health;
@property (nonatomic, retain) NSMutableArray* blockFixtures;


- (void) setup;


- (void) weld: (BuildingBlock*) weldto;

@end
