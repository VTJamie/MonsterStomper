//
//  Ground.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 4/22/14.
//
//

#import "CollisionDelegate.h"
#import "Player.h"

@interface Level : SPSprite

@property (nonatomic, assign) int levelnumber;
@property (nonatomic, retain) Player* player;
- (id) initWithLevel: (int) levelnum;
- (void) setup;


@end
