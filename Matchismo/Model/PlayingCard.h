//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jeffrey Lee on 1/30/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic)NSString *contents;


@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
