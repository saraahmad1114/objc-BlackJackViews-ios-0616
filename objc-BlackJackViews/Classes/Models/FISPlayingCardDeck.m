//
//  FISPlayingCardDeck.m
//  BlackJack
//
//  Created by Al Tyus on 6/11/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "FISPlayingCardDeck.h"
#import "FISPlayingCard.h"

@implementation FISPlayingCardDeck

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupPlayingCardDeck];
    }
    return self;
}

- (void)setupPlayingCardDeck
{
    for (NSString *suit in [FISPlayingCard validSuits])
    {
        for (NSUInteger rank = 1; rank <= [[FISPlayingCard maxRank] integerValue]; rank++)
        {
            [self addCard:[[FISPlayingCard alloc] initWithSuit:suit rank:@(rank)]];
        }
    }
}
@end
