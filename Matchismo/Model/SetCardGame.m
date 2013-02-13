//
//  SetCardGame.m
//  Matchismo
//
//  Created by Jeffrey Lee on 2/9/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "SetCardGame.h"

@interface SetCardGame()

@property(strong, nonatomic) NSMutableArray *cards;


@end

@implementation SetCardGame

@synthesize numberOfCardsToMatch = _numberOfCardsToMatch;

-(int) numberOfCardsToMatch
{
    if (_numberOfCardsToMatch <= 0) _numberOfCardsToMatch = 2;
    return _numberOfCardsToMatch;
}

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (SetCard *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end
