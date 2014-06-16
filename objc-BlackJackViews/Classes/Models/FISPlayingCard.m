//
//  FISPlayingCard.m
//  BlackJack
//
//  Created by Al Tyus on 6/11/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "FISPlayingCard.h"

@implementation FISPlayingCard

- (NSString *)description
{
    NSString * rankString= [self rankString];
    
    return [NSString stringWithFormat:@"%@ %@", rankString, self.suit];
}

- (NSNumber *)score
{
    NSString *rankString = [self rankString];
    return [[self class] scoreDictionary][rankString];
}

- (NSString *)rankString
{
    return [[self class] rankStrings][[self.rank integerValue]];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self = [self initWithSuit:@"" rank:@0];
    }
    return self;
}

- (instancetype)initWithSuit:(NSString *)suit
                        rank:(NSNumber *)rank
{
    self = [super init];
    if (self)
    {
        _suit = [FISPlayingCard validateSuit:suit];
        _rank = [FISPlayingCard validateRank:rank];
    }
    return self;
}

- (void)setRank:(NSNumber *)rank
{
    if ([rank integerValue] <= [[FISPlayingCard maxRank] integerValue])
    {
        _rank = rank;
    }
}

+ (NSNumber *)validateRank:(NSNumber *)rank
{
    if( [rank integerValue] < [[FISPlayingCard rankStrings] count])
    {
        return rank;
    }
    else return @0;
}

+ (NSString *)validateSuit:(NSString *)suit
{
    if ([[FISPlayingCard validSuits] containsObject: suit])
    {
        return suit;
    }
    else return @"";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+ (NSDictionary *)scoreDictionary
{
    return @{[[self class] rankStrings][0]: @0,
             [[self class] rankStrings][1]: @1,
             [[self class] rankStrings][2]: @2,
             [[self class] rankStrings][3]: @3,
             [[self class] rankStrings][4]: @4,
             [[self class] rankStrings][5]: @5,
             [[self class] rankStrings][6]: @6,
             [[self class] rankStrings][7]: @7,
             [[self class] rankStrings][8]: @8,
             [[self class] rankStrings][9]: @9,
             [[self class] rankStrings][10]: @10,
             [[self class] rankStrings][11]: @10,
             [[self class] rankStrings][12]: @10,
             [[self class] rankStrings][13]: @10};
}

+ (NSNumber *)maxRank
{
    return @([self rankStrings].count -1);
}

+ (NSArray *)validSuits
{
    return @[@"♠️",@"♥️",@"♣️",@"♦️"];
}

@end
