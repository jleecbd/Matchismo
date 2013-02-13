//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Jeffrey Lee on 2/9/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//


//Rewrite this by creating message responders in the SetCard class and testing whether the card is that kind and act accordingly.  This should allow me to move code out of here and into the superclasses

#import "SetCardGameViewController.h"
#import "SetCardGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@property (strong, nonatomic) SetCardGame *game;
@property (strong, nonatomic)UIImage *cardBackImage;
@property (strong, nonatomic)NSMutableArray *flipResultHistory;
@end

@implementation SetCardGameViewController

- (SetCardGame *)game
{
    if (!_game) _game = [[SetCardGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
    return _game;
    
}

-(UIImage *)cardBackImage {
    if(!_cardBackImage) _cardBackImage = [UIImage imageNamed:@"SetCardBack.png"];
    return _cardBackImage;
}

-(UIColor *)getUIColorFor:(NSString *)colorText {
    
    UIColor *colorForColorText = [UIColor blackColor];
    
    if (colorText == @"Red"){
        colorForColorText = [UIColor redColor];
    } else if (colorText == @"Purple") {
        colorForColorText = [UIColor purpleColor];
    } else if (colorText == @"Green") {
        colorForColorText = [UIColor greenColor];
    }
    
    return colorForColorText;
    
}
-(NSArray *)flipResultHistory {
    
    if(!_flipResultHistory) _flipResultHistory = [[NSMutableArray alloc] init];
    return _flipResultHistory;
    
}

-(NSNumber *)alphaValueFor:(NSString *)shadingText {
    
    NSNumber *alphaValue = @1.0;
    
    if (shadingText == @"None") {
        alphaValue = @0.0;
    } else if (shadingText == @"Partial"){
        alphaValue = @0.5;
    } else if (shadingText == @"Full"){
        alphaValue = @1.0;
    }
    
    return alphaValue;
}

-(NSAttributedString *)getAttributedTextFor:(SetCard *)card {
    
    UIColor *symColor = [self getUIColorFor:card.symbolColor];
    CGFloat alphaVal = [[self alphaValueFor:card.shading] floatValue];
    UIColor *foreColor = [symColor colorWithAlphaComponent:alphaVal];
    
    NSAttributedString *cardTitle = [[NSAttributedString alloc] initWithString:card.contents attributes:@{NSForegroundColorAttributeName: foreColor, NSStrokeColorAttributeName: symColor, NSStrokeWidthAttributeName: @-8}];
    
    return cardTitle;
    
}
-(void)updateUI
{
    
    for (UIButton *cardButton in self.cardButtons) {
        
        SetCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setAttributedTitle:[self getAttributedTextFor:card] forState:UIControlStateNormal];
        
        cardButton.selected = card.isFaceUp;
        if (!cardButton.isSelected) {
            
            [cardButton setBackgroundImage:self.cardBackImage forState:UIControlStateNormal];
            
        } else
        {
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.flipResultsLabel.attributedText = [self getFlipResult];

}


- (NSMutableAttributedString *)getFlipResult {
    
    NSMutableAttributedString *message;
    SetCard *card = [self.game cardAtIndex:self.game.lastCardIndex];
    if (self.game.lastCardIndex == 0) {
        
        message = [[NSMutableAttributedString alloc] initWithString:@"Last Flip:"];
    } else {
        
    if (self.game.lastEventWasMatchCheck) {
        
        SetCard *card2 = [self.game.cardsToMatch objectAtIndex:0];
        SetCard *card3 = [self.game.cardsToMatch objectAtIndex:1];

        
        if (self.game.lastMatchSuccess) {
            
            NSAttributedString *ampersandFrag = [[NSMutableAttributedString alloc] initWithString:@"&"];
            
            
            message = [[NSMutableAttributedString alloc] initWithString: @"Successfully matched the "];
            
            [message appendAttributedString:[self getAttributedTextFor:card]];
            [message appendAttributedString:ampersandFrag];
            [message appendAttributedString:[self getAttributedTextFor:card2]];
            [message appendAttributedString:ampersandFrag];
            [message appendAttributedString:[self getAttributedTextFor:card3]];
            [message appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@".  You have earned %d points", self.game.scoreAdjust]]];
            
        } else
        {
            
            NSAttributedString *ampersandFrag = [[NSMutableAttributedString alloc] initWithString:@"&"];
            
            
            message = [[NSMutableAttributedString alloc] initWithString: @"Sorry,  "];
            
            [message appendAttributedString:[self getAttributedTextFor:card]];
            [message appendAttributedString:ampersandFrag];
            [message appendAttributedString:[self getAttributedTextFor:card2]];
            [message appendAttributedString:ampersandFrag];
            [message appendAttributedString:[self getAttributedTextFor:card3]];
            [message appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" don't match."]];
            [message appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  You have lost %d points", self.game.scoreAdjust]]];
            
            
        }
        
        
    } else {
        
        if (card.isFaceUp){
            
            message = [[NSMutableAttributedString alloc] initWithString: @"Last Flip: Flipped up the "];
            
            [message appendAttributedString:[self getAttributedTextFor:card]];
            
            
        } else {
            
            
            message = [[NSMutableAttributedString alloc] initWithString: @"Last Flip: Flipped down the "];
            
            [message appendAttributedString:[self getAttributedTextFor:card]];
        }
        
        
        
     }
    }
    
    return message;
    
}




@end
