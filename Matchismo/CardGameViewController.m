//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jeffrey Lee on 1/30/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()

@property (strong, nonatomic) NSString *gameName;

@property (weak, nonatomic) IBOutlet UISegmentedControl *matchNumberButton;

@property (nonatomic) int flipCount;

@property (strong, nonatomic) CardMatchingGame *game;


@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic)UIImage *cardBackImage;

@property (strong, nonatomic)NSMutableArray *flipResultHistory;

@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

-(NSString *)gameName
{
    if (!_gameName) _gameName = [[NSString alloc] init];
    _gameName = @"Playing Card Game";
    return _gameName;
}

-(GameResult *)gameResult
{
    if(!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (IBAction)changeMatchValue:(UISegmentedControl *)sender {
    
    self.game.numberOfCardsToMatch = sender.selectedSegmentIndex + 1;
    
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[PlayingCardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
    
}
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(NSArray *)flipResultHistory {
    
    if(!_flipResultHistory) _flipResultHistory = [[NSMutableArray alloc] init];
    return _flipResultHistory;
    
}

- (IBAction)scrollFlipHistory:(UISlider *)sender {
    
    self.flipResultsLabel.alpha = 0.3;
    int flipResultIndex = round(sender.value);
    if (flipResultIndex == 0) flipResultIndex = 1;
    self.flipResultsLabel.text = [NSString stringWithFormat:@"Last Flip: %@", [self.flipResultHistory objectAtIndex: flipResultIndex-1]];
    
}
-(UIImage *)cardBackImage {
    if(!_cardBackImage) _cardBackImage = [UIImage imageNamed:@"SimianCardBack.jpg"];
    return _cardBackImage;
}
-(void)updateUI
{
     
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState: UIControlStateSelected|UIControlStateDisabled];
                
            
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
    if (self.flipResultHistory.count == 1)
    {
        self.flipResultSlider.maximumValue = 1;
    } else
    {
        self.flipResultSlider.maximumValue = self.flipResultHistory.count;
    }
    
    self.flipResultSlider.value = self.flipResultSlider.maximumValue;
    self.flipResultsLabel.alpha = 1.0;
    self.flipResultsLabel.text = [NSString stringWithFormat:@"Last Flip: %@", self.flipResultHistory.lastObject];
}

- (NSString *)getFlipResult {
    
    NSString *message;
    Card *card = [self.game cardAtIndex:self.game.lastCardIndex];
    if (self.game.lastEventWasMatchCheck) {
        
        if (self.game.lastMatchSuccess) {
            
            message = [NSString stringWithFormat:@"Successfully matched the %@ with %@ for %d points", card.contents, [self createCardMatchMessageFrom: self.game.cardsToMatch], self.game.scoreAdjust];
            
        } else
        {
            message = [NSString stringWithFormat:@"Sorry, the %@ doesn't match %@.  You have lost %d points", card.contents, [self createCardMatchMessageFrom: self.game.cardsToMatch], self.game.scoreAdjust];
            
            
        }
        
        
    } else {
        
        
        if (card.isFaceUp){
            message = [NSString stringWithFormat:@"Last Flip: Flipped up the %@", card.contents];
        } else {
            message = [NSString stringWithFormat:@"Last Flip: Flipped down the %@", card.contents];
        }
        
        
        
    }
    
    return message;
    
}



- (IBAction)flipCard:(UIButton *)sender {
    
    self.matchNumberButton.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    NSString *message = [self getFlipResult];
    [self.flipResultHistory addObject:message];
    [self updateUI];
    self.gameResult.score = self.game.score;
    self.gameResult.gameName = self.gameName;
}
- (IBAction)reDeal:(UIButton *)sender {
    self.matchNumberButton.enabled = YES;
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    self.flipResultSlider.maximumValue = 1;
    self.flipResultSlider.value = 0;
    [self updateUI];
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
