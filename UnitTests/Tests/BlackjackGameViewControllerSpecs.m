//
//  AppDelegateTests.m
//  objc-BlackJackViews
//
//  Created by Al Tyus on 6/16/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import <Expecta.h>
#import "FISAppDelegate.h"
#import <KIF/KIF.h>
#import "FISBlackjackGameViewController.h"
#import "FISPlayingCard.h"


SpecBegin(FISBlackjackGameViewController)

__block FISBlackjackGameViewController *bjgVC;

describe(@"FISAppDelegate", ^{
    
    beforeEach(^{
        FISAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        
        bjgVC = (FISBlackjackGameViewController *)appDelegate.window.rootViewController;
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
                FISPlayingCard *aceSpades = [[FISPlayingCard alloc] initWithSuit:@"♠️" rank:@1];
                FISPlayingCard *aceDiamonds = [[FISPlayingCard alloc] initWithSuit:@"♦️" rank:@1];
                
                bjgVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[aceDiamonds, aceSpades]];
                [bjgVC updateUI];
                
                [tester tapViewWithAccessibilityLabel:@"hitButton"];
                expect([bjgVC.blackjackGame.hand count]).to.equal(3);
                expect(((UILabel *)[tester waitForViewWithAccessibilityLabel:@"card3"]).isHidden).to.beFalsy();
                [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
                [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
            }
        });
        
        it(@"should not hit if blackjack", ^{
            FISPlayingCard *aceSpades = [[FISPlayingCard alloc] initWithSuit:@"♠️" rank:@1];
            FISPlayingCard *kingDiamonds = [[FISPlayingCard alloc] initWithSuit:@"♦️" rank:@13];
            
            bjgVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[aceSpades, kingDiamonds]];
            [bjgVC updateUI];
            
            [tester tapViewWithAccessibilityLabel:@"hitButton"];
            
            [tester waitForViewWithAccessibilityLabel:@"card1"];
            [tester waitForViewWithAccessibilityLabel:@"card2"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card3"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card4"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"card5"];
        });
        
        it(@"should not hit if busted", ^{
            FISPlayingCard *kingDiamonds = [[FISPlayingCard alloc] initWithSuit:@"♦️" rank:@13];
            FISPlayingCard *kingSpades = [[FISPlayingCard alloc] initWithSuit:@"♠️" rank:@13];
            FISPlayingCard *kingHearts = [[FISPlayingCard alloc] initWithSuit:@"♥️" rank:@13];
            
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
            FISPlayingCard *kingDiamonds = [[FISPlayingCard alloc] initWithSuit:@"♦️" rank:@13];
            FISPlayingCard *kingSpades = [[FISPlayingCard alloc] initWithSuit:@"♠️" rank:@13];
            FISPlayingCard *kingHearts = [[FISPlayingCard alloc] initWithSuit:@"♥️" rank:@13];
            
            bjgVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[kingDiamonds, kingHearts, kingSpades]];
            [bjgVC updateUI];

            UILabel *scoreLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"scoreLabel"];
            
            expect(scoreLabel.text).to.equal(@"30");
        });
        
    });
    
    describe(@"resultLabel", ^{
        it(@"should show Blackjack! in resultLabel if blackjack", ^{
            FISPlayingCard *aceSpades = [[FISPlayingCard alloc] initWithSuit:@"♠️" rank:@1];
            FISPlayingCard *kingDiamonds = [[FISPlayingCard alloc] initWithSuit:@"♦️" rank:@13];
            
            bjgVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[aceSpades, kingDiamonds]];
            [bjgVC updateUI];
            
            UILabel *resultLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"resultLabel"];
            expect(resultLabel.text).to.equal(@"Blackjack!");
        });
        
        it(@"should show Busted! in resultLabel if busted", ^{
            FISPlayingCard *kingDiamonds = [[FISPlayingCard alloc] initWithSuit:@"♦️" rank:@13];
            FISPlayingCard *kingSpades = [[FISPlayingCard alloc] initWithSuit:@"♠️" rank:@13];
            FISPlayingCard *kingHearts = [[FISPlayingCard alloc] initWithSuit:@"♥️" rank:@13];
            
            bjgVC.blackjackGame.hand = [NSMutableArray arrayWithArray:@[kingDiamonds, kingHearts, kingSpades]];
            [bjgVC updateUI];
            
            UILabel *resultLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"resultLabel"];
            
            expect(resultLabel.text).to.equal(@"Busted!");
        });
    });
});

SpecEnd
