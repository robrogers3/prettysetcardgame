//
//  CardGameMove.h
//  PrettySetGame
//
//  Created by Rob Rogers on 3/3/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, MoveKindType) {
    MoveKindFlipUp,
    MoveKindMatchForPoints,
    MoveKindMismatchForPenalty
};

@interface CardGameMove : NSObject

//designated initializer
-(id)initWithMoveKind:(MoveKindType) moveKind
 CardsThatWereFlipped:(NSArray*)cardsFlipped
scoreDeltaForThisMove:(int)scoreDelta;

-(NSString *)descriptionOfMove;
-(NSString *)description;

@property (nonatomic,strong) NSArray *cardsFlipped;
@property (nonatomic) int scoreDelta;
@property (nonatomic) MoveKindType moveKind;

@end
