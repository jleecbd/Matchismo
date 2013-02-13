//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jeffrey Lee on 1/30/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if(otherCards.count > 0) {
        for (PlayingCard *otherCard in otherCards) {
            if ([otherCard.suit isEqualToString:self.suit]) {
                score += 1;
            } else if (otherCard.rank == self.rank) {
                score += 4;
            } else {
            
                score = 0;
                break;
            }
            
        }
        
    }
    
    return score;
}
@synthesize contents = _contents;

-(NSString *)contents
{
    if (!_contents) _contents = [[NSString alloc] init];
    NSArray *rankStrings = [PlayingCard rankStrings];
    _contents = [rankStrings[self.rank] stringByAppendingString:self.suit];
    
    return _contents;
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
-(NSString *)suit
{
    return _suit ? _suit: @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank { return [self rankStrings].count-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
