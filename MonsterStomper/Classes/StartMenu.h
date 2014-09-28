//
//  Menu.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 2/4/14.
//
//


@interface StartMenu : SPSprite

@property (nonatomic, retain) SPImage* newgame;
@property (nonatomic, retain) SPSprite* monsterlayer;
@property (nonatomic, assign) double timepassed;

- (void) setup;

@end
