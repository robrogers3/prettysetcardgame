//
//  SetCardGame.m
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/21/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "SetCardGame.h"
#import "SetCard.h"
@interface SetCardGame()
@property (nonatomic,readwrite) int score;
@property (nonatomic,readwrite) int lastScore;
@property (nonatomic,copy) NSMutableArray *cards;
@property (nonatomic,strong) Deck *deck;
@end

@implementation SetCardGame
@synthesize cards = _cards;

#pragma mark - Init
-(id)initWithCardCount: (NSUInteger) cardCount usingDeck: (Deck *) deck
{
    self = [super init];
    if (self) {
        self.deck = deck;
        for (int i = 0;i < cardCount;i++) {
            SetCard *card = (SetCard *)[self.deck drawRandomCard];
            if (card)
                self.cards[i] = card;
            else {
                self.cards[i] = nil;
                break;
            }
        }
    }
    return self;
}


#pragma mark - Properties

-(NSMutableArray *) cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

#pragma mark - Methods

-(NSUInteger)cardsInGame
{
    return [self.cards count];
/*    NSUInteger i = 0;
    for (Card *card in self.cards)
        if (!card.isUnplayable)
            i++;
    NSLog(@"Playable Card count: %d, self.cards count: %d", i, [self.cards count]);

    //return i;
 */
}
-(NSUInteger)addNCards:(NSUInteger)n
{
    NSUInteger k = 0;
    for (int i = 0;i<n;i++)
    {
        Card *card = [self.deck drawRandomCard];
        if (card) {
            k++;
            [self.cards addObject:card];
        } else {
            break;
        }
    }
    return k;
}
-(Card *)addCardToGame
{
    Card *card = [self.deck drawRandomCard];
    [self.cards addObject:card];
    return card;
}
-(NSUInteger)removeCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (card)
        [self.cards removeObjectAtIndex:index];
    else
        NSLog(@"Removing nil card; failure %d",index);
    return 1;
}
-(Card *)cardAtIndex:(NSUInteger) index {
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
-(NSUInteger)indexOfCard:(Card *) card
{
    return [self.cards indexOfObject:card];
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define SELCOST 1;

-(CardGameMove *)selectCardAtIndex:(NSUInteger) index
{
    SetCard *card = (SetCard *)[self cardAtIndex:index];
    
    if (!card || card.isUnplayable) {
        NSLog(@"Card is nil or Playing Unplayable??");
        return nil;
    }
    
    if (card.isSelected) { //deselecting
        card.selected = NO;
        return nil;
    }
    
    int scoreDelta = -SELCOST; //pay to play
    

    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    NSMutableArray *allCardsInPlay;
    int matchScore = 0;
    self.lastScore = 0;

    for (SetCard *c in self.cards) { //accumulate
        if ([otherCards count] == 2)
            break;
        if (!c.isUnplayable && c.isSelected) {
            [otherCards addObject:c];
        }
    }
    
    allCardsInPlay = [otherCards mutableCopy];
    [allCardsInPlay addObject:card];
    CardGameMove *move = nil;
    
    if ([allCardsInPlay count] == 3 ) {//majic number
        matchScore = [card match:otherCards];
        if (matchScore) {
            scoreDelta += matchScore * MATCH_BONUS;
            for (SetCard *c in otherCards) {
                c.unplayable = YES;
                c.selected = NO;
            }
            card.unplayable = YES;
            move = [[CardGameMove alloc] initWithMoveKind:MoveKindMatchForPoints
                                     CardsThatWereFlipped:allCardsInPlay
                                    scoreDeltaForThisMove:scoreDelta];
        } else {
            scoreDelta -= MISMATCH_PENALTY;
            for (SetCard *c in otherCards) {
                c.unplayable = NO;
                c.selected = NO;
            }
            move = [[CardGameMove alloc] initWithMoveKind:MoveKindMismatchForPenalty
                                     CardsThatWereFlipped:allCardsInPlay
                                    scoreDeltaForThisMove:scoreDelta];
        }
    } else {
        move = [[CardGameMove alloc] initWithMoveKind:MoveKindFlipUp
                                 CardsThatWereFlipped:allCardsInPlay
                                scoreDeltaForThisMove:scoreDelta];
    }
    
    [self.moveHistory addObject:move];
    self.lastScore = scoreDelta;
    self.score += scoreDelta;
    card.selected = !card.isSelected;
    return move;
}
@end
