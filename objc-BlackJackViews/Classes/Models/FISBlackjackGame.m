//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Al Tyus on 6/11/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"
#import "FISPlayingCard.h"

@implementation FISBlackjackGame

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _playingCardDeck = [[FISPlayingCardDeck alloc] init];
        _handScore = @0;
        _hand = [[NSMutableArray alloc] init];
    }

    return self;
}
- (void)deal
{
    self.playingCardDeck = [[FISPlayingCardDeck alloc] init]; 
    self.handScore = @0;
    self.hand = [[NSMutableArray alloc] init];
    
    for (NSInteger x = 0; x < 2; x++)
    {
        [self.hand addObject:[self.playingCardDeck drawRandomCard]];
    }
}
- (void)hit
{
    if ([self.hand count] && !self.isBusted && !self.isBlackjack)
    {
        [self.hand addObject:[self.playingCardDeck drawRandomCard]];
    }
}

- (BOOL)isBusted
{
    return [self.handScore integerValue] > 21;
}

- (BOOL)isBlackjack
{
    return [self.handScore integerValue] == 21;
}

- (NSNumber *)handScore
{
    NSInteger score = 0;
    for (FISPlayingCard *card in self.hand)
    {
        score += [card.score integerValue];
    }
    
    for (NSInteger x = 0; x < [self numberOfAces]; x++)
    {
        if (score + 10 <= 21)
        {
            score += 10; 
        }
    }
    
    return @(score);
}

- (NSInteger)numberOfAces
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.rank == 1"];
    
    return (NSInteger)[[self.hand filteredArrayUsingPredicate:predicate] count];
}

@end
