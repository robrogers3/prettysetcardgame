//
//  CardGameMove.m
//  PrettySetGame
//
//  Created by Rob Rogers on 3/3/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "CardGameMove.h"
#import "Card.h"

@implementation CardGameMove
-(id)initWithMoveKind:(MoveKindType) moveKind
 CardsThatWereFlipped:(NSArray*)cardsFlipped
scoreDeltaForThisMove:(int)scoreDelta
{
    self = [super init];
    if (self) {
        _scoreDelta = scoreDelta;
        _cardsFlipped = cardsFlipped;
        _moveKind = moveKind;
    }
    return self;
}

-(NSString *)descriptionOfMove {
    NSString *description;

    if (self.moveKind == MoveKindFlipUp) {
        description = [NSString stringWithFormat:@"Flipped Up %@",[[self.cardsFlipped lastObject] contents]];
    }
    else
    {
        if (self.moveKind == MoveKindMatchForPoints) {
            description = @"Matched ";
            for (NSUInteger i = 0;i<[self.cardsFlipped count]-1;i++) {
                Card *card = [self.cardsFlipped objectAtIndex:i];
                description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ & ",card.contents]];
            }
            Card *card = [self.cardsFlipped lastObject];
            description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ for %d points",card.contents,self.scoreDelta]];
        }
        else if (self.moveKind == MoveKindMismatchForPenalty)
        {
            description = [[NSString alloc] init];
            for (NSUInteger i = 0;i<[self.cardsFlipped count]-1;i++) {
                Card *card = [self.cardsFlipped objectAtIndex:i];
                description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ & ", card.contents]];
            }
            Card *card = [self.cardsFlipped lastObject];
            description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ don't match! %d penalty.", card.contents, self.scoreDelta]];
        }
        else
        {
            description = @"Unknown move! Impossible. Do Assert??";
        }
            
    }
    return description;
}
-(NSString *)description {
    return [self descriptionOfMove];
}

@end
