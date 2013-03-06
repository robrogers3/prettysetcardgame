//
//  SetCardGame.h
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/21/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCardDeck.h"
#import "CardGameMove.h"

@interface SetCardGame : NSObject
@property (nonatomic,readonly) int score;
@property (nonatomic,readonly) int lastScore;
@property (nonatomic,strong) NSMutableArray *moveHistory;
-(id)initWithCardCount: (NSUInteger) cardCount usingDeck: (Deck *) deck;
-(CardGameMove *)selectCardAtIndex:(NSUInteger) index;
-(Card *)cardAtIndex:(NSUInteger) index;
-(NSUInteger)cardsInGame;
-(NSUInteger)removeCardAtIndex:(NSUInteger)index;
-(NSUInteger)addNCards:(NSUInteger)n;
-(NSUInteger)indexOfCard:(Card *)card;
@end
