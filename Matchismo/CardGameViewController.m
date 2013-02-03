//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jeffrey Lee on 1/30/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()


@property (weak, nonatomic) IBOutlet UISegmentedControl *matchNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResultsLabel;
@end

@implementation CardGameViewController

- (IBAction)changeMatchValue:(UISegmentedControl *)sender {
    
    self.game.numberOfCardsToMatch = sender.selectedSegmentIndex + 1;
    NSLog(@"Number of cards to match is %d", self.game.numberOfCardsToMatch);
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
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
-(void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"SimianCardBack.jpg"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState: UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        if (!cardButton.isSelected) {
            [cardButton setBackgroundImage:cardBackImage forState:UIControlStateNormal];
        } else
        {
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipResultsLabel.text = [NSString stringWithFormat:@"Last Flip: %@", self.game.flipResult];
}

- (IBAction)flipCard:(UIButton *)sender {
    
    self.matchNumberButton.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}
- (IBAction)reDeal:(UIButton *)sender {
    self.matchNumberButton.enabled = YES;
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

@end
