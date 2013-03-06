//
//  SetCardDeck.m
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/18/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"
@implementation SetCardDeck
-(id) init
{
    self = [super init];
    if (self) {
//        NSMutableDictionary *props = [[NSMutableDictionary alloc] init];
        for (NSNumber *shape in [SetCard validShapes]) {
            for (NSNumber *color in [SetCard validColors]) {
                for (NSNumber *count in [SetCard validCounts]) {
                    for (NSNumber *fill in [SetCard validFills]) {
//                        [props setValue:shape forKey:@"shape"];
//                        [props setValue:color forKey:@"color"];
//                        [props setValue:count forKey:@"count"];
//                        [props setValue:fill forKey:@"fill"];
                        SetCard *sc = [[SetCard alloc] init];
                        sc.shape = [shape intValue];
                        sc.color = [color intValue];
                        sc.count = [count intValue];
                        sc.fill = [fill intValue];
                        [self addCard:sc atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}
@end
