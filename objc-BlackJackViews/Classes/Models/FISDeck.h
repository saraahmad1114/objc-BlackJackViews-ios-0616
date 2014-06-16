//
//  FISDeck.h
//  BlackJack
//
//  Created by Al Tyus on 6/11/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISCard.h"

@interface FISDeck : NSObject

//@property (strong, nonatomic) NSMutableArray *cards; // the cards in the deck

- (FISCard *)drawRandomCard;
- (void)addCard:(FISCard *)card;

- (NSArray *)cards;
@end
