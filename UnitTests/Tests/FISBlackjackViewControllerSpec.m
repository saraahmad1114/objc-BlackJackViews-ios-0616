//  FISBlackjackViewControllerSpec.m

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"
#import "FISBlackjackViewController.h"
#import "FISCard.h"


SpecBegin(FISBlackjackViewController)

describe(@"FISBlackjackViewController", ^{
    
    __block FISBlackjackViewController *blackjackVC;
    
    beforeEach(^{
        
        blackjackVC = (FISBlackjackViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    });
    
    describe(@"Initial View", ^{
        it(@"should deal two cards when view did load", ^{
            
            [tester waitForViewWithAccessibilityLabel:@"card1"];
            [tester waitForViewWithAccessibilityLabel:@"card2"];
        });
        
        it(@"should hide cards 3 4 and 5 in the initial view", ^{                        [tester tapViewWithAccessibilityLabel:@"dealButton"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card3"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
        });
    });
    
    describe(@"Hit", ^{
        it(@"should add a new card when hit button is pressed", ^{
            [tester waitForTappableViewWithAccessibilityLabel:@"hitButton"];
            
            for (int x = 0; x < 5; x++)
            {
                FISCard *aceSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@1];
                FISCard *aceDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@1];
                
                blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[aceDiamonds, aceSpades]];
                [blackjackVC updateUI];
                
                [tester tapViewWithAccessibilityLabel:@"hitButton"];
                expect([blackjackVC.blackjackGame.hand count]).to.equal(3);
                expect(((UILabel *)[tester waitForViewWithAccessibilityLabel:@"card3"]).isHidden).to.beFalsy();
                [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
                [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
            }
        });
        
        it(@"should not hit if blackjack", ^{
            FISCard *aceSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@1];
            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
            
            blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[aceSpades, kingDiamonds]];
            [blackjackVC updateUI];
            
            [tester tapViewWithAccessibilityLabel:@"hitButton"];
            
            [tester waitForViewWithAccessibilityLabel:@"card1"];
            [tester waitForViewWithAccessibilityLabel:@"card2"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card3"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
        });
        
        it(@"should not hit if busted", ^{
            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
            FISCard *kingSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@13];
            FISCard *kingHearts = [[FISCard alloc] initWithSuit:@"♥️" rank:@13];
            
            bjgVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[kingDiamonds, kingHearts, kingSpades]];
            [bjgVC updateUI];
            
            [tester tapViewWithAccessibilityLabel:@"hitButton"];
            [tester waitForViewWithAccessibilityLabel:@"card1"];
            [tester waitForViewWithAccessibilityLabel:@"card2"];
            [tester waitForViewWithAccessibilityLabel:@"card3"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
            
        });
    });
    describe(@"deal", ^{
        it(@"Should deal two new cards and hide cards 3-5", ^{
    
            [tester tapViewWithAccessibilityLabel:@"dealButton"];
            
            [tester waitForViewWithAccessibilityLabel:@"card1"];
            [tester waitForViewWithAccessibilityLabel:@"card2"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card3"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
        });
    });
    
    describe(@"scoreLabel", ^{
        it(@"should update scoreLabel with the current score", ^{
            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
            FISCard *kingSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@13];
            FISCard *kingHearts = [[FISCard alloc] initWithSuit:@"♥️" rank:@13];
            
            blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[kingDiamonds, kingHearts, kingSpades]];
            [blackjackVC updateUI];

            UILabel *scoreLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"scoreLabel"];
            
            expect(scoreLabel.text).to.equal(@"30");
        });
        
    });
    
    describe(@"resultLabel", ^{
        it(@"should show Blackjack! in resultLabel if blackjack", ^{
            FISCard *aceSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@1];
            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
            
            blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[aceSpades, kingDiamonds]];
            [blackjackVC updateUI];
            
            UILabel *resultLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"resultLabel"];
            expect(resultLabel.text).to.equal(@"Blackjack!");
        });
        
        it(@"should show Busted! in resultLabel if busted", ^{
            FISCard *kingDiamonds = [[FISCard alloc] initWithSuit:@"♦️" rank:@13];
            FISCard *kingSpades = [[FISCard alloc] initWithSuit:@"♠️" rank:@13];
            FISCard *kingHearts = [[FISCard alloc] initWithSuit:@"♥️" rank:@13];
            
            blackjackVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[kingDiamonds, kingHearts, kingSpades]];
            [blackjackVC updateUI];
            
            UILabel *resultLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"resultLabel"];
            
            expect(resultLabel.text).to.equal(@"Busted!");
        });
    });
});

SpecEnd
