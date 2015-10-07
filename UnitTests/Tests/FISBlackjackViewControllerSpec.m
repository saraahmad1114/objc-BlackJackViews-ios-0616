//  FISBlackjackViewControllerSpec.m

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"
#import "FISBlackjackViewController.h"
#import "FISCard.h"


SpecBegin(FISBlackjackViewController)

describe(@"FISBlackjackViewController", ^{
    
    __block FISCard *queenOfHearts;
    __block FISCard *aceOfSpades;
    __block FISCard *aceOfClubs;
    __block FISCard *twoOfClubs;
    __block FISCard *tenOfDiamonds;
    
    beforeAll(^{
        queenOfHearts = [[FISCard alloc] initWithSuit:@"♥" rank:@"Q"];
        aceOfSpades = [[FISCard alloc] initWithSuit:@"♠" rank:@"A"];
        aceOfClubs = [[FISCard alloc] initWithSuit:@"♣" rank:@"A"];
        twoOfClubs = [[FISCard alloc] initWithSuit:@"♣" rank:@"2"];
        tenOfDiamonds = [[FISCard alloc] initWithSuit:@"♦" rank:@"10"];
    });
    
    __block FISBlackjackViewController *blackjackVC;
    
    beforeEach(^{
        
        blackjackVC = [[FISBlackjackViewController alloc] init];
        
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        blackjackVC = [main instantiateViewControllerWithIdentifier:@"blackjackVC"];
        
    });
    
    describe(@"initial view", ^{
        it(@"should hide all of the house's card views", ^{
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"houseCard1"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"houseCard2"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"houseCard3"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"houseCard4"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"houseCard5"];
        });
        it(@"should hide all of the player's card views", ^{
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"playerCard1"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"playerCard2"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"playerCard3"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"playerCard4"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"playerCard5"];
        });
    });
    
    describe(@"deal button", ^{
        it(@"should unhide at least the first two card views for the house and the player", ^{
            [tester tapViewWithAccessibilityLabel:@"deal"];
            
            [tester waitForViewWithAccessibilityLabel:@"houseCard1"];
            [tester waitForViewWithAccessibilityLabel:@"houseCard2"];
            [tester waitForViewWithAccessibilityLabel:@"playerCard1"];
            [tester waitForViewWithAccessibilityLabel:@"playerCard2"];
        });
        
        it(@"should show the card labels in the card views", ^{
            [tester tapViewWithAccessibilityLabel:@"deal"];
            
            FISCard *cardHouse2 = blackjackVC.game.house.cardsInHand[1];
            FISCard *cardPlayer1 = blackjackVC.game.player.cardsInHand[0];
            FISCard *cardPlayer2 = blackjackVC.game.player.cardsInHand[1];
            
            expect(blackjackVC.houseCard2.text).to.equal(cardHouse2.cardLabel);
            expect(blackjackVC.playerCard1.text).to.equal(cardPlayer1.cardLabel);
            expect(blackjackVC.playerCard2.text).to.equal(cardPlayer2.cardLabel);
        });

        
        it(@"should update the player's score label to show the current score", ^{
            [tester tapViewWithAccessibilityLabel:@"deal"];
            
            NSString *playerScore = [NSString stringWithFormat:@"%lu", blackjackVC.game.player.handscore];
            
            expect(blackjackVC.playerScore.text).to.endWith(playerScore);
        });
    });
    
//    describe(@"Hit", ^{
//        it(@"should add a new card when hit button is pressed", ^{
//            [tester waitForTappableViewWithAccessibilityLabel:@"hitButton"];
//            
//            for (int x = 0; x < 5; x++)
//            {
//                FISCard *aceSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@1];
//                FISCard *aceDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@1];
//                
//                blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[aceDiamonds, aceSpades]];
//                [blackjackVC updateUI];
//                
//                [tester tapViewWithAccessibilityLabel:@"hitButton"];
//                expect([blackjackVC.blackjackGame.hand count]).to.equal(3);
//                expect(((UILabel *)[tester waitForViewWithAccessibilityLabel:@"card3"]).isHidden).to.beFalsy();
//                [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
//                [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
//            }
//        });
//        
//        it(@"should not hit if blackjack", ^{
//            FISCard *aceSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@1];
//            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
//            
//            blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[aceSpades, kingDiamonds]];
//            [blackjackVC updateUI];
//            
//            [tester tapViewWithAccessibilityLabel:@"hitButton"];
//            
//            [tester waitForViewWithAccessibilityLabel:@"card1"];
//            [tester waitForViewWithAccessibilityLabel:@"card2"];
//            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card3"];
//            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
//            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
//        });
//        
//        it(@"should not hit if busted", ^{
//            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
//            FISCard *kingSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@13];
//            FISCard *kingHearts = [[FISCard alloc] initWithSuit:@"♥️" rank:@13];
//            
//            bjgVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[kingDiamonds, kingHearts, kingSpades]];
//            [bjgVC updateUI];
//            
//            [tester tapViewWithAccessibilityLabel:@"hitButton"];
//            [tester waitForViewWithAccessibilityLabel:@"card1"];
//            [tester waitForViewWithAccessibilityLabel:@"card2"];
//            [tester waitForViewWithAccessibilityLabel:@"card3"];
//            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
//            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
//            
//        });
//    });
//    describe(@"deal", ^{
//        it(@"Should deal two new cards and hide cards 3-5", ^{
//    
//            [tester tapViewWithAccessibilityLabel:@"dealButton"];
//            
//            [tester waitForViewWithAccessibilityLabel:@"card1"];
//            [tester waitForViewWithAccessibilityLabel:@"card2"];
//            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card3"];
//            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
//            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
//        });
//    });
//    
//    describe(@"scoreLabel", ^{
//        it(@"should update scoreLabel with the current score", ^{
//            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
//            FISCard *kingSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@13];
//            FISCard *kingHearts = [[FISCard alloc] initWithSuit:@"♥️" rank:@13];
//            
//            blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[kingDiamonds, kingHearts, kingSpades]];
//            [blackjackVC updateUI];
//
//            UILabel *scoreLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"scoreLabel"];
//            
//            expect(scoreLabel.text).to.equal(@"30");
//        });
//        
//    });
//    
//    describe(@"resultLabel", ^{
//        it(@"should show Blackjack! in resultLabel if blackjack", ^{
//            FISCard *aceSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@1];
//            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
//            
//            blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[aceSpades, kingDiamonds]];
//            [blackjackVC updateUI];
//            
//            UILabel *resultLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"resultLabel"];
//            expect(resultLabel.text).to.equal(@"Blackjack!");
//        });
//        
//        it(@"should show Busted! in resultLabel if busted", ^{
//            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
//            FISCard *kingSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@13];
//            FISCard *kingHearts = [[FISCard alloc] initWithSuit:@"♥️" rank:@13];
//            
//            blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[kingDiamonds, kingHearts, kingSpades]];
//            [blackjackVC updateUI];
//            
//            UILabel *resultLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"resultLabel"];
//            
//            expect(resultLabel.text).to.equal(@"Busted!");
//        });
//    });
    
//    afterEach(^{
//        [blackjackVC viewDidLoad];
//    });
    
});

SpecEnd
