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
@property(nonatomic, readonly, strong) NSString *flipResult; //place the text of the last flip result here in the game, as this is the place that this activity is going on.  The controller can then display (or not) the contents of this.
@property(nonatomic) int numberOfCardsToMatch;
@property(nonatomic, strong, readonly)NSMutableArray *flipResultHistory;

@end
