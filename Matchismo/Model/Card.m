//
//  Card.m
//  Matchismo
//
//  Created by Jeffrey Lee on 1/30/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "Card.h"
@interface Card()


@end

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score += 1;
        } else
        {
            score = 0; //set to 0 if one of the cards in the supposedly matching set doesn't match.
        }
    }
    
    return score;
}

@end
