//
//  FISBlackjackGameViewController.m
//  objc-BlackJackViews
//
//  Created by Al Tyus on 6/16/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "FISBlackjackGameViewController.h"

@interface FISBlackjackGameViewController ()

@end

@implementation FISBlackjackGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.blackjackGame = [[FISBlackjackGame alloc] init];
    [self.blackjackGame deal];
    
    [self configureAccessibilityLabels];
    [self updateUI];
}

- (void)configureAccessibilityLabels
{
    self.card1.accessibilityLabel = @"card1";
    self.card2.accessibilityLabel = @"card2";
    self.card3.accessibilityLabel = @"card3";
    self.card4.accessibilityLabel = @"card4";
    self.card5.accessibilityLabel = @"card5";

    self.hitButton.accessibilityLabel = @"hitButton";
    self.dealButton.accessibilityLabel = @"dealButton";
    self.scoreLabel.accessibilityLabel = @"scoreLabel";
    self.resultLabel.accessibilityLabel = @"resultLabel"; 
}

- (void)updateUI
{
    self.card1.hidden = YES;
    self.card2.hidden = YES;
    self.card3.hidden = YES;
    self.card4.hidden = YES;
    self.card5.hidden =  YES;
    
    if ([self.blackjackGame.hand count]){
        self.card1.text = [self.blackjackGame.hand[0] description];
        self.card1.hidden = NO;
        
        if([self.blackjackGame.hand count] >1)
        {
            self.card2.text = [self.blackjackGame.hand[1] description];
            self.card2.hidden = NO;
        }
        if([self.blackjackGame.hand count] > 2)
        {
            self.card3.text = [self.blackjackGame.hand[2] description];
            self.card3.hidden = NO;
        }
        if([self.blackjackGame.hand count] > 3)
        {
            self.card4.text = [self.blackjackGame.hand[3] description];
            self.card4.hidden = NO;
        }
        if([self.blackjackGame.hand count] > 4)
        {
            self.card5.text = [self.blackjackGame.hand[4] description];
            self.card5.hidden = NO;
        }
    }
    self.scoreLabel.text = [self.blackjackGame.handScore stringValue];
    if (self.blackjackGame.isBusted)
    {
        self.resultLabel.text = @"Busted!";
    }
    else if (self.blackjackGame.isBlackjack)
    {
        self.resultLabel.text = @"Blackjack!";
    }
    else
    {
        self.resultLabel.text = @"";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)hit:(id)sender {
    [self.blackjackGame hit];
    [self updateUI];
}

- (IBAction)deal:(id)sender {
    [self.blackjackGame deal];
    [self updateUI];
}
@end
