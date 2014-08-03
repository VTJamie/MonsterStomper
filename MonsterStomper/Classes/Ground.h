//
//  Ground.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 4/22/14.
//
//

#import "CollisionDelegate.h"

@interface Ground : SPSprite

@property (nonatomic, assign) b2Body *body;

@property (nonatomic, assign) float initwidth;
@property (nonatomic, assign) float initheight;
@property (nonatomic, assign) float initx;
@property (nonatomic, assign) float inity;


- (id) initWithLoc: (b2Vec2) position andSize: (b2Vec2) size;
- (void) setup;


@end
