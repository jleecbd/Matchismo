//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Jeffrey Lee on 2/9/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardDeck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation SetCardDeck

- (int)deckSize {
    
    if(!_deckSize) {
        
        _deckSize = 81;
        
    }
    return _deckSize;
}

- (id)init {
    self = [super init];
    if (self){
        
        
        //build a deck at least as large as necessary
        for(int x = 1; x<=3;x++) {
            
            for (NSString *symbol in [SetCard validSymbols]) {
                for(NSString *symbolColor in [SetCard validColors]){
                    for (NSString *shading in [SetCard validShadings]){
                        SetCard *setCard = [[SetCard alloc] init];
                        setCard.rank = x;
                        setCard.symbol = symbol;
                        setCard.symbolColor = symbolColor;
                        setCard.shading = shading;
                        [self addCard:setCard atTop:YES];
                        
                    }
                }
            }
            
        }
    }
    return self;
}

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


@end
