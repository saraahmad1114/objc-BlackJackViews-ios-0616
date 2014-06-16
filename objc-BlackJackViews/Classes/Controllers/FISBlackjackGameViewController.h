//
//  FISBlackjackGameViewController.h
//  objc-BlackJackViews
//
//  Created by Al Tyus on 6/16/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISBlackjackGame.h"

@interface FISBlackjackGameViewController : UIViewController

@property (nonatomic) FISBlackjackGame *blackjackGame;


@property (weak, nonatomic) IBOutlet UILabel *card1;
@property (weak, nonatomic) IBOutlet UILabel *card2;
@property (weak, nonatomic) IBOutlet UILabel *card3;
@property (weak, nonatomic) IBOutlet UILabel *card4;
@property (weak, nonatomic) IBOutlet UILabel *card5;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;

- (IBAction)hit:(id)sender;
- (IBAction)deal:(id)sender;
- (void)updateUI; 

@end
