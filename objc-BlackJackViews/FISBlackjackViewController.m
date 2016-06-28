//
//  FISBlackjackViewController.m
//  objc-BlackJackViews
//
//  Created by Flatiron School on 6/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackViewController.h"

@interface FISBlackjackViewController ()

@property (weak, nonatomic) IBOutlet UILabel *winner;
@property (weak, nonatomic) IBOutlet UILabel *house;
//this is the HOUSE LABEL
@property (weak, nonatomic) IBOutlet UILabel *houseStayed;
@property (weak, nonatomic) IBOutlet UILabel *houseScore;


@property (weak, nonatomic) IBOutlet UILabel *houseCard1;
@property (weak, nonatomic) IBOutlet UILabel *houseCard2;
@property (weak, nonatomic) IBOutlet UILabel *houseCard3;
@property (weak, nonatomic) IBOutlet UILabel *houseCard4;
@property (weak, nonatomic) IBOutlet UILabel *houseCard5;


@property (weak, nonatomic) IBOutlet UILabel *playerCard1;
@property (weak, nonatomic) IBOutlet UILabel *playerCard2;
@property (weak, nonatomic) IBOutlet UILabel *playerCard3;
@property (weak, nonatomic) IBOutlet UILabel *playerCard4;
@property (weak, nonatomic) IBOutlet UILabel *playerCard5;

@property (weak, nonatomic) IBOutlet UILabel *houseWins;
@property (weak, nonatomic) IBOutlet UILabel *houseBust;
@property (weak, nonatomic) IBOutlet UILabel *houseLosses;
@property (weak, nonatomic) IBOutlet UILabel *houseBlackjack;

@property (weak, nonatomic) IBOutlet UILabel *player;
//this is the PLAYER LABEL
@property (weak, nonatomic) IBOutlet UILabel *playerStayed;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property (weak, nonatomic) IBOutlet UILabel *playerWins;
@property (weak, nonatomic) IBOutlet UILabel *playerLosses;
@property (weak, nonatomic) IBOutlet UILabel *playerBust;
@property (weak, nonatomic) IBOutlet UILabel *playerBlackjack;

//buttons only
- (IBAction)deal:(id)sender;
- (IBAction)hit:(id)sender;
- (IBAction)stay:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *stayButton;

@end

@implementation FISBlackjackViewController

//done with this method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.houseScore.hidden = YES; 
    self.game = [[FISBlackjackGame alloc] init];
    [self.game.deck resetDeck];
    [self.game dealNewRound];
    //self.winner.accessibilityElementsHidden= NO;
    
    //this will actually start the game!
    //make the deal button animate!
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//setting up a gameover so that you don't have to do this again


//This should be used to end the game with the second method
-(void)gameOverCheck
{
    self.stayButton.enabled = NO;
    self.hitButton.enabled = NO;
    self.dealButton.enabled = YES;
    
    //All the PLAYER CARDS
    if(self.playerCard1.hidden == NO)
    {
        self.playerCard1.hidden = YES;
    }
    if(self.playerCard2.hidden == NO)
    {
        self.playerCard2.hidden = YES;
    }
    if(self.playerCard3.hidden == NO)
    {
        self.playerCard3.hidden = YES;
    }
    if(self.playerCard4.hidden == NO)
    {
        self.playerCard4.hidden = YES;
    }
    if(self.playerCard5.hidden == NO)
    {
        self.playerCard5.hidden = YES;
    }
    
    //All the HOUSE CARDS
    if(self.houseCard1.hidden == NO)
    {
        self.houseCard1.hidden = YES;
    }
    if(self.houseCard2.hidden == NO)
    {
        self.houseCard2.hidden = YES;
    }
    if(self.houseCard3.hidden == NO)
    {
        self.houseCard3.hidden = YES;
    }
    if(self.houseCard4.hidden == NO)
    {
        self.houseCard4.hidden = YES;
    }
    if(self.houseCard5.hidden == NO)
    {
        self.houseCard5.hidden = YES;
    }
    [self.game incrementWinsAndLossesForHouseWins:self.houseWins];
    self.playerWins.text = [NSString stringWithFormat:@"Wins: %lu", self.game.player.wins];
    self.playerWins.text = [NSString stringWithFormat:@"Loss: %lu", self.game.player.losses];
    self.houseWins.text = [NSString stringWithFormat:@"Wins: %lu", self.game.house.wins];
    self.houseWins.text = [NSString stringWithFormat:@"Loss: %lu", self.game.house.losses];
//    self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
//    self.houseScore.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
    
}

//Done with this method
- (IBAction)deal:(id)sender
{
    //When a user taps the deal button, a new game should begin dealing two cards to the house and the player.
    
    self.playerCard1.hidden = NO;
    self.playerCard2.hidden = NO;
    self.playerCard1.text = ((FISCard *)self.game.player.cardsInHand[0]).cardLabel;
    self.playerCard2.text = ((FISCard *)self.game.player.cardsInHand[1]).cardLabel;
    
    self.houseCard1.hidden = NO;
    self.houseCard2.hidden = NO;
    self.houseCard1.text = ((FISCard *)self.game.house.cardsInHand[0]).cardLabel;
    self.houseCard2.text = ((FISCard *)self.game.house.cardsInHand[1]).cardLabel;
    self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
    if((self.game.player.blackjack) || (self.game.house.blackjack))
    {
        self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
        [self gameOverCheck];
    }
}

//
//
//Done with this method
//make sure to make this about only the player and to see if the player ever gets busted 
- (IBAction)hit:(id)sender
{
    self.hitButton.enabled = YES;
    if(!(self.game.player.blackjack) || !(self.game.house.blackjack))
    {

        self.stayButton.enabled = YES;
        self.hitButton.enabled = YES;
        if(!(self.game.player.stayed))
        {
            self.hitButton.enabled = YES;
            [self.game dealCardToPlayer];
            self.playerCard3.hidden = NO;
            self.playerCard3.text = ((FISCard *)self.game.player.cardsInHand[2]).cardLabel;
            self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
            if(self.game.player.handscore == 21)
            {
                self.winner.text = @"Player";
            }
            if(self.game.player.busted)
            {
                [self gameOverCheck];
            }
        }
        self.stayButton.enabled = YES;
        self.hitButton.enabled = YES;
        if(!(self.game.player.stayed) && !(self.game.player.busted))
        {
                self.hitButton.enabled = YES;
                [self.game dealCardToPlayer];
                self.playerCard4.hidden = NO;
                self.playerCard4.text = ((FISCard *)self.game.player.cardsInHand[3]).cardLabel;
                self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
            if(self.game.player.handscore == 21)
            {
                self.winner.text = @"Player";
            }
                if(self.game.player.busted)
                {
                    [self gameOverCheck];
                }
        }
        self.stayButton.enabled = YES;
        self.hitButton.enabled = YES;
        if(!(self.game.player.stayed) && !(self.game.player.busted))
        {
            self.hitButton.enabled = YES;
            [self.game dealCardToPlayer];
            self.playerCard5.hidden = NO;
            self.playerCard5.text = ((FISCard *)self.game.player.cardsInHand[4]).cardLabel;
            self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
            if(self.game.player.handscore == 21)
            {
                self.winner.text = @"Player";
            }
            if(self.game.player.busted)
            {
                [self gameOverCheck];
            }
        }
        
    }

}

//enabling each of the buttons
- (IBAction)stay:(id)sender
{
//    self.winner.accessibilityElementsHidden= NO;
    self.stayButton.enabled = YES;
    self.hitButton.enabled = YES;
    self.winner.hidden = NO;
    self.houseScore.hidden = NO;
    if(!(self.game.house.stayed))
    {
        self.hitButton.enabled = YES;
        [self.game dealCardToHouse];
        self.houseCard3.hidden = NO;
        self.houseCard3.text = ((FISCard *)self.game.player.cardsInHand[2]).cardLabel;
        self.houseScore.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
        if(self.game.house.handscore == 21)
        {
            
            self.winner.text = @"House";
            self.houseScore.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
            self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
        }
        if(self.game.house.busted)
        {
            self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
            self.houseScore.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
            [self gameOverCheck];
        }
    }

    self.stayButton.enabled = YES;
    self.hitButton.enabled = YES;
    if(!(self.game.house.stayed) && !(self.game.house.busted))
    {
        self.hitButton.enabled = YES;
        [self.game dealCardToHouse];
        self.houseCard4.hidden = NO;
        self.houseCard4.text = ((FISCard *)self.game.player.cardsInHand[3]).cardLabel;
        self.houseScore.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
        if(self.game.house.handscore == 21)
        {
            self.winner.text = @"House";
            self.houseScore.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
            self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
        }
        if(self.game.house.busted)
        {
            self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
            self.houseScore.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
            [self gameOverCheck];
        }
    }
    
    self.stayButton.enabled = YES;
    self.hitButton.enabled = YES;
    if(!(self.game.house.stayed) && !(self.game.house.busted))
    {
        self.hitButton.enabled = YES;
        [self.game dealCardToHouse];
        self.houseCard5.hidden = NO;
        self.houseCard5.text = ((FISCard *)self.game.house.cardsInHand[4]).cardLabel;
        self.houseCard5.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
        if(self.game.house.handscore == 21)
        {
            self.winner.text = @"House";
            self.houseScore.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
            self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
        }
        if(self.game.house.busted)
        {
            self.playerScore.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
            self.houseScore.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
            [self gameOverCheck];
        }
    }

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
