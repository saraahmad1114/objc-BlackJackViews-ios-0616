//
//  FISBlackjackGame.h
//  BlackJack
//
//  Created by Al Tyus on 6/11/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISPlayingCardDeck.h"

@interface FISBlackjackGame : NSObject

@property (strong, nonatomic) FISPlayingCardDeck *playingCardDeck; // returns the playingCardDeck in use
@property (strong, nonatomic) NSNumber *handScore; // returns the total value of cards in the hand
@property (strong, nonatomic) NSMutableArray *hand;
@property (nonatomic) BOOL isBusted; // returns YES if handScore is more than 21
@property (nonatomic) BOOL isBlackjack; // returns YES if handScore is 21

- (id)init; // should initialize playingCardDeck with a new deck and set score and isBusted to default values
- (void)deal; // should deal 2 new cards, add the cards to the hand, and add the card's value to the handscore.
- (void)hit; // should deal one additional card, add the card to the hand, and add the card's value to the handscore. If an Ace (11) would bust the player, counts an ace as a 1.

@end
