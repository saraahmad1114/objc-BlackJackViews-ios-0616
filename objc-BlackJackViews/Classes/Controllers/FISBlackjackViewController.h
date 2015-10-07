//  FISBlackjackViewController.h

#import <UIKit/UIKit.h>
#import "FISBlackjackGame.h"

@interface FISBlackjackViewController : UIViewController

@property (nonatomic) FISBlackjackGame *game;

@property (weak, nonatomic) IBOutlet UILabel *houseScore;

@property (weak, nonatomic) IBOutlet UILabel *houseCard1;
@property (weak, nonatomic) IBOutlet UILabel *houseCard2;
@property (weak, nonatomic) IBOutlet UILabel *houseCard3;
@property (weak, nonatomic) IBOutlet UILabel *houseCard4;
@property (weak, nonatomic) IBOutlet UILabel *houseCard5;

@property (weak, nonatomic) IBOutlet UILabel *houseStayed;
@property (weak, nonatomic) IBOutlet UILabel *houseBusted;
@property (weak, nonatomic) IBOutlet UILabel *houseBlackjack;

@property (weak, nonatomic) IBOutlet UILabel *houseWins;
@property (weak, nonatomic) IBOutlet UILabel *houseLosses;


@property (weak, nonatomic) IBOutlet UILabel *winner;


@property (weak, nonatomic) IBOutlet UILabel *playerScore;

@property (weak, nonatomic) IBOutlet UILabel *playerCard1;
@property (weak, nonatomic) IBOutlet UILabel *playerCard2;
@property (weak, nonatomic) IBOutlet UILabel *playerCard3;
@property (weak, nonatomic) IBOutlet UILabel *playerCard4;
@property (weak, nonatomic) IBOutlet UILabel *playerCard5;

@property (weak, nonatomic) IBOutlet UILabel *playerStayed;
@property (weak, nonatomic) IBOutlet UILabel *playerBusted;
@property (weak, nonatomic) IBOutlet UILabel *playerBlackjack;

@property (weak, nonatomic) IBOutlet UILabel *playerWins;
@property (weak, nonatomic) IBOutlet UILabel *playerLosses;

@property (weak, nonatomic) IBOutlet UIButton *deal;
@property (weak, nonatomic) IBOutlet UIButton *hit;
@property (weak, nonatomic) IBOutlet UIButton *stay;

- (IBAction)dealTapped:(id)sender;
- (IBAction)hitTapped:(id)sender;
- (IBAction)stayTapped:(id)sender;

- (void)updateViews;

@end
