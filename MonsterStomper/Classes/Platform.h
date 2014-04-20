//
//  Menu.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/4/14.
//
//

#import "CollisionDelegate.h"

@interface Platform : SPSprite

@property (nonatomic, assign) b2Body *body;

@property (nonatomic, assign) float initwidth;
@property (nonatomic, assign) float initheight;
@property (nonatomic, assign) float initx;
@property (nonatomic, assign) float inity;

- (id) initWithLoc: (b2Vec2) position;
- (void) setup;


@end
