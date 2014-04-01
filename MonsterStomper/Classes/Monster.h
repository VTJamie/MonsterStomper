//
//  Menu.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/4/14.
//
//

#import "CollisionDelegate.h"

@interface Monster : SPSprite

@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign) b2Body *body;

@property (nonatomic, assign) BOOL jetpackon;

- (void) setup;

@end
