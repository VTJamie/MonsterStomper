//
//  Playable.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/23/14.
//
//

#import "SPSprite.h"
#import "Player.h"

#define EVENT_PHYSICS_UPDATE @"PHYSICS_UPDATE"
#define EVENT_PHYSICS_READY_FOR_CHANGES @"PHYSICS_READY_FOR_CHANGES"
#define EVENT_TOUCH_LEFT_START @"TOUCH_LEFT_START"
#define EVENT_TOUCH_LEFT_STOP @"EVENT_TOUCH_LEFT_STOP"
#define EVENT_TOUCH_RIGHT_START @"EVENT_TOUCH_RIGHT_START"
#define EVENT_TOUCH_RIGHT_STOP @"EVENT_TOUCH_RIGHT_STOP"

@interface Playable : SPSprite

@property (nonatomic, assign) b2World *world;
@property (nonatomic, retain) NSMutableArray* createobjects;
@property (nonatomic, retain) Player* player;
@property (nonatomic, assign) float centeroffset;


- (void)start;

@end
