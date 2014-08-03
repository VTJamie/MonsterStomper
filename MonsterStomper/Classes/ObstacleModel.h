//
//  ObstacleModel.h
//  MonsterStomper
//
//  Created by Jamieson Abbott on 8/3/14.
//
//

#import <Foundation/Foundation.h>

@interface ObstacleModel : NSObject
@property (nonatomic,assign) float height;
@property (nonatomic, assign) float width;
@property (nonatomic,assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, retain) NSString* type;
- (id) initWithDict: (NSDictionary*) dict;
@end
