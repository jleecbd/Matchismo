//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jeffrey Lee on 2/1/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Default Initializer

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly) int score;
@property(nonatomic, readonly, strong) NSString *flipResult;
@property(nonatomic) int numberOfCardsToMatch;

@end
