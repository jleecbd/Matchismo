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

@property (nonatomic) bool lastEventWasMatchCheck;

@property (nonatomic) int lastCardIndex;

@property (nonatomic) bool lastMatchSuccess;

@property (nonatomic)int scoreAdjust;

@end

@implementation CardMatchingGame


-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSMutableArray *)cardsToMatch
{
    if(!_cardsToMatch) _cardsToMatch = [[NSMutableArray alloc] init];
    return _cardsToMatch;
}

-(int) numberOfCardsToMatch
{
    if (_numberOfCardsToMatch <= 0) _numberOfCardsToMatch = 1;
    return _numberOfCardsToMatch;
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
    self.lastEventWasMatchCheck = NO;
    self.lastMatchSuccess = NO;
    Card *card = [self cardAtIndex:index];
    self.lastCardIndex = index;
    self.cardsToMatch = nil;
    if (!card.isUnplayable) {
        
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    
                    [self.cardsToMatch addObject:otherCard];
                    
                }
            }
            
            self.score -= FLIP_COST;
        } 
        card.faceUp = !card.isFaceUp;
        if (self.cardsToMatch.count == self.numberOfCardsToMatch)
        {
            int matchScore = [card match: self.cardsToMatch];
            self.lastEventWasMatchCheck = YES;
            if (matchScore == 0)
            {
                self.score -= MISMATCH_PENALTY;
                
                self.scoreAdjust = MISMATCH_PENALTY;
                
                for (Card *otherCard in self.cardsToMatch) {
                    otherCard.faceUp = NO;
                }
                
            } else
            {
                self.lastMatchSuccess = YES;
                
                card.unplayable= YES;
                for (Card *otherCard in self.cardsToMatch) {
                    otherCard.unplayable = YES;
                }
                self.score += matchScore * MATCH_BONUS;
                
                self.scoreAdjust = matchScore * MATCH_BONUS;
                
            }
            
        } 
        
    }
}
-(NSString *)createCardMatchMessageFrom:(NSArray *)cardArray
{
    
    NSString *message = @"";
    int counter = 1;
    for (Card *otherCard in cardArray)
    {
        if (cardArray.count == 1){
            message = [NSString stringWithFormat:@"the %@", otherCard.contents];
        }
        else if (counter == cardArray.count)
        {
            message = [NSString stringWithFormat:@"%@ and the %@", message, otherCard.contents];
        } else if (cardArray.count == 2){
            
            message = [NSString stringWithFormat: @"%@ the %@", message, otherCard.contents];
            
        } else {
            
            message = [NSString stringWithFormat: @"%@ the %@,", message, otherCard.contents];
        }
        counter++;
    }
    
    return message;
}


@end
