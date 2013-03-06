//
//  SetCard.h
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/18/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

enum {RECT = 1, OVAL, DIAMOND};
enum {PURPLE = 1, RED = 2 , GREEN = 3};
enum {NO_FILL = 1, OPAQUE_FILL, SHADED_FILL};

@interface SetCard : Card
@property (nonatomic) int shape;
@property (nonatomic) int count;
@property (nonatomic) int fill;
@property (nonatomic) int color;
//@property (nonatomic) NSDictionary *properties;
@property (nonatomic,getter=isSelected) int selected;
+(NSArray *) validShapes;
+(NSArray *) validColors;
+(NSArray *) validFills;
+(NSArray *) validCounts;
@end
