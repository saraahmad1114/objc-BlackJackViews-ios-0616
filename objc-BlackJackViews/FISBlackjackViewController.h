//
//  FISBlackjackViewController.h
//  objc-BlackJackViews
//
//  Created by Flatiron School on 6/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISBlackjackGame.h"
#import "FISCard.h"
#import "FISCardDeck.h"

@interface FISBlackjackViewController : UIViewController

@property (nonatomic, strong) FISBlackjackGame *game;

@end
