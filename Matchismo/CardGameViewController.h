//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Jeffrey Lee on 1/30/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UISlider *flipResultSlider;

@property (weak, nonatomic) IBOutlet UILabel *flipResultsLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
