//
//  SetCardGame.h
//  Matchismo
//
//  Created by Jeffrey Lee on 2/9/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGame : CardMatchingGame

@property(nonatomic) int numberOfCardsToMatch;
- (SetCard *)cardAtIndex:(NSUInteger)index;

@end
