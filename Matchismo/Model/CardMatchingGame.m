//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jeffrey Lee on 2/1/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property(strong, nonatomic) NSMutableArray *cards;
@property(nonatomic) int score;
@property(nonatomic, strong) NSString *flipResult;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        
        for (int i = 0; i < count; i++) {
            
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            
            } else {
                
                self.cards[i] = card;
            }
            
        }
        
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (NSString *)flipResult
{
    if (!_flipResult) _flipResult = [[NSString alloc] init];
    return _flipResult;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.flipResult = [NSString stringWithFormat:@"Successfully matched the %@ with the %@ for %d points", card.contents, otherCard.contents, (matchScore * MATCH_BONUS)];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.flipResult = [NSString stringWithFormat:@"Sorry, the %@ doesn't match the %@.  You have lost %d points", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
                
                self.flipResult = [NSString stringWithFormat:@"Flipped up the %@", card.contents];
            }
            
            self.score -= FLIP_COST;
        } else {
            self.flipResult = [NSString stringWithFormat:@"Flipped down the %@", card.contents];
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
