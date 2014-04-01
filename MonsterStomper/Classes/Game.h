//
//  Game.h
//  AppMonsterStomper
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
#import "Playable.h"
#import "StartMenu.h"
#import "GameOver.h"
#import <GameKit/GameKit.h>

#define PTM_RATIO 32.0

@interface Game : SPSprite <GKGameCenterControllerDelegate>

+ (Game*) instance;
@property (nonatomic, retain) SPJuggler* gameJuggler;

@property (nonatomic, retain) Playable* playarea;
@property (nonatomic, retain) StartMenu* startmenu;
@property (nonatomic, retain) GameOver* gameover;


- (void) startGame;
- (void) showStartMenu;
- (void) showGameOver: (int) score;
@end


static Game* gameInstance;