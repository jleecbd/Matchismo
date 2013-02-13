//
//  PlayingCardDeck.h
//  Matchismo
//
//  Created by Jeffrey Lee on 1/30/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "Deck.h"
#import "PlayingCard.h"

@interface PlayingCardDeck : Deck
-(PlayingCard *)drawRandomCard;
@end
