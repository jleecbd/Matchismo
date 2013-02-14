//
//  GameResult.h
//  Matchismo
//
//  Created by Jeffrey Lee on 2/13/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+(NSArray *)allGameResults;
@property (nonatomic, strong)NSString *gameName;
@property (nonatomic, readonly)NSDate *start;
@property (nonatomic, readonly)NSDate *end;
@property (nonatomic, readonly)NSTimeInterval duration;
@property (nonatomic)int score;

@end
