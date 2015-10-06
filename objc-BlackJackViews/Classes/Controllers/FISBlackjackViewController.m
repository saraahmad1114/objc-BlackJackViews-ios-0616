//  FISBlackjackViewController.m

#import "FISBlackjackViewController.h"

@interface FISBlackjackViewController ()

@property (strong, nonatomic) NSArray *houseCardViews;
@property (strong, nonatomic) NSArray *playerCardViews;

@end

@implementation FISBlackjackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.houseCardViews = @[self.houseCard1, self.houseCard2, self.houseCard3, self.houseCard4, self.houseCard5];
    self.playerCardViews = @[self.playerCard1, self.playerCard2, self.playerCard3, self.playerCard4, self.playerCard5];
    [self resetViewsForNewRound];
    
    self.game = [[FISBlackjackGame alloc] init];
    
}

- (void)resetViewsForNewRound {
    
    self.houseScore.hidden = YES;
    
    for (UILabel *cardView in self.houseCardViews) {
        cardView.text = @"";
        cardView.hidden = YES;
    }
    for (UILabel *cardView in self.playerCardViews) {
        cardView.text = @"";
        cardView.hidden = YES;
    }
    
    self.winner.hidden = YES;
    
    self.houseStayed.hidden = YES;
    self.houseBusted.hidden = YES;
    self.playerStayed.hidden = YES;
    self.playerBusted.hidden = YES;
    
    self.hit.enabled = YES;
    self.stay.enabled = YES;
    self.playerScore.text = [NSString stringWithFormat:@"Score: 0"];
}

- (void)updateViews {
    [self showHouseCards];
    [self showPlayerCards];
    [self showAlteredStatusLabels];
    [self updatePlayerScoreLabel];
}

- (void)showHouseCards {
    for (NSUInteger i = 0; i < self.game.house.cardsInHand.count; i++) {
        UILabel *houseCardView = self.houseCardViews[i];
        FISCard *card = self.game.house.cardsInHand[i];
        
        if (i == 0) {
            houseCardView.text = @"❂";
        } else {
            houseCardView.text = card.cardLabel;
        }
    }
    for (UILabel *cardView in self.houseCardViews) {
        if (cardView.text.length > 0) {
            cardView.hidden = NO;
        }
    }
}

- (void)showPlayerCards {
    for (NSUInteger i = 0; i < self.game.player.cardsInHand.count; i++) {
        FISCard *card = self.game.player.cardsInHand[i];
        UILabel *playerCardView = self.playerCardViews[i];
        
        playerCardView.text = card.cardLabel;
    }
    for (UILabel *cardView in self.playerCardViews) {
        if (cardView.text.length > 0) {
            cardView.hidden = NO;
        }
    }
}

- (void)showAlteredStatusLabels {
    self.houseStayed.hidden = !self.game.house.stayed;
    self.houseBusted.hidden = !self.game.house.busted;
    self.houseBlackjack.hidden = !self.game.house.blackjack;

    self.playerStayed.hidden = !self.game.player.stayed;
    self.playerBusted.hidden = !self.game.player.busted;
    self.playerBlackjack.hidden = !self.game.player.blackjack;
}

- (void)updatePlayerScoreLabel {
    NSUInteger playerScore = self.game.player.handscore;
    self.playerScore.text = [NSString stringWithFormat:@"Score: %lu", playerScore];
}

- (IBAction)dealTapped:(id)sender {
    [self resetViewsForNewRound];
    [self playBlackjack];
}

- (void)playBlackjack {
    [self.game dealNewRound];
    [self updateViews];
}

- (void)processPlayerTurn {
    BOOL playerMayHit = !self.game.player.busted && !self.game.player.stayed && !self.game.player.blackjack;
    self.hit.enabled = playerMayHit;
    self.stay.enabled = playerMayHit;
    
    if (!playerMayHit || self.game.house.busted) {
        [self concludeRound];
    }
}

- (void)concludeRound {
    for (NSUInteger i = self.game.house.cardsInHand.count; i < 5; i++) {
        BOOL houseMayHit = !self.game.house.busted && !self.game.house.stayed && !self.game.house.blackjack;
        if (houseMayHit) {
            [self.game processHouseTurn];
        }
    }
    
    [self displayHouseHand];
    [self displayHouseScore];
    [self evaluateAndDisplayWinner];
    [self updateWinsAndLossesLabels];
}

- (void)displayHouseHand {
    FISCard *faceDownHouseCard = self.game.house.cardsInHand[0];
    self.houseCard1.text = faceDownHouseCard.cardLabel;
}

- (void)displayHouseScore {
    NSUInteger houseScore = self.game.house.handscore;
    self.houseScore.text = [NSString stringWithFormat:@"Score: %lu", houseScore];
    self.houseScore.hidden = NO;
}

- (void)evaluateAndDisplayWinner {
    BOOL houseWins = [self.game houseWins];
    [self.game incrementWinsAndLossesForHouseWins:houseWins];
    
    if (houseWins) {
        self.winner.text = @"You lost!";
    } else {
        self.winner.text = @"You win!";
    }
    self.winner.hidden = NO;
}

- (void)updateWinsAndLossesLabels {
    self.houseWins.text = [NSString stringWithFormat:@"Wins: %lu", self.game.house.wins];
    self.houseLosses.text = [NSString stringWithFormat:@"Losses: %lu", self.game.house.losses];
    self.playerWins.text = [NSString stringWithFormat:@"Wins: %lu", self.game.player.wins];
    self.playerLosses.text = [NSString stringWithFormat:@"Losses: %lu", self.game.player.losses];
}

- (IBAction)hitTapped:(id)sender {
    [self.game dealCardToPlayer];
    [self.game processHouseTurn];
    [self updateViews];
}

- (IBAction)stayTapped:(id)sender {
    self.game.player.stayed = YES;
    [self.game processHouseTurn];
    [self updateViews];
}

@end
