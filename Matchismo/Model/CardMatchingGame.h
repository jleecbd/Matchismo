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

@property (nonatomic, readonly) bool lastEventWasMatchCheck;

@property (nonatomic, readonly) int lastCardIndex;

@property (nonatomic, readonly) bool lastMatchSuccess;

@property (nonatomic, readonly)int scoreAdjust;

@property(nonatomic) int numberOfCardsToMatch;

@property(nonatomic, readonly) int score;

@property(nonatomic, strong) NSMutableArray *cardsToMatch;

@end
