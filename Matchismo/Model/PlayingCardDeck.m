//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Jeffrey Lee on 1/30/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "PlayingCardDeck.h"


@interface PlayingCardDeck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation PlayingCardDeck

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++)
            {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}

- (PlayingCard *)drawRandomCard
{
    PlayingCard *randomCard = nil;
    
    if (self.cards.count){
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}


@end
