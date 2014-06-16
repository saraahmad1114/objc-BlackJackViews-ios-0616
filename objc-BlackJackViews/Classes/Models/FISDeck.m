//
//  FISDeck.m
//  BlackJack
//
//  Created by Al Tyus on 6/11/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "FISDeck.h"

@interface FISDeck()

@property (nonatomic) NSMutableArray *mutableCards;

@end

@implementation FISDeck

- (NSMutableArray *)mutableCards
{
    if (!_mutableCards)
    {
        _mutableCards = [[NSMutableArray alloc] init];
    }
    return _mutableCards;
}

- (NSArray *)cards
{
    return [self.mutableCards copy];
}

- (FISCard *)drawRandomCard
{
    FISCard *randomCard = [[FISCard alloc] init];
    
    if (self.cards.count)
    {
        int index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.mutableCards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

- (void)addCard:(FISCard *)card
{
    [self.mutableCards addObject:card];
}

@end
