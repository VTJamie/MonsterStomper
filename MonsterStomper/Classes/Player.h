//
//  Menu.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/4/14.
//
//

#import "CollisionDelegate.h"

@interface Player : SPSprite

@property (nonatomic, assign) b2Body *body;

@property (nonatomic, assign) BOOL jetpackon;
@property (nonatomic, assign) BOOL firing;

@property (nonatomic, assign) float startx;

- (void) setup;

- (float) offset;

@end
