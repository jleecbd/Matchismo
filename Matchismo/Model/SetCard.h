//
//  SetCard.h
//  Matchismo
//
//  Created by Jeffrey Lee on 2/9/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic)NSUInteger rank;
@property (nonatomic, strong)NSString *symbol;
@property (nonatomic, strong)NSString *symbolColor;
@property (nonatomic)NSString  *shading;
@property (strong, nonatomic)NSString *contents;

+(NSArray *)validSymbols;
+(NSArray *)validColors;
+(NSArray *)validShadings;



@end
