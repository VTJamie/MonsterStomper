//
//  LevelModel.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 8/3/14.
//
//

#import <Foundation/Foundation.h>

@interface LevelModel : NSObject
@property (nonatomic, assign) float levelLength;
@property (nonatomic, assign) float levelSpeed;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSArray* obstacles;

- (id) initWithDict: (NSDictionary*) dict;
@end
