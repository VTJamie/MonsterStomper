//
//  Box2DCreatorDelegate.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 3/16/14.
//
//

#import <Foundation/Foundation.h>

@protocol Box2DCreatorDelegate <NSObject>

@required
- (void) handleCreateDestroy;

@end
