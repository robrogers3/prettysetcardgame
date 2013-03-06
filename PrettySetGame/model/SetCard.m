//
//  SetCard.m
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/18/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "SetCard.h"
@interface SetCard()
@end

@implementation SetCard
-(int) match:(NSArray *) otherCards
{
    int score = 0;
    if ([otherCards count] == 2) {
        SetCard *c2 = [otherCards objectAtIndex:0];
        SetCard *c3 = [otherCards objectAtIndex:1];
        int shapeMatch = (self.shape + c2.shape + c3.shape) % 3;
        int colorMatch = (self.color + c2.color + c3.color) % 3;
        int countMatch = (self.count + c2.count + c3.count) % 3;
        int fillMatch  = (self.fill + c2.fill + c3.fill) % 3;
        score = (shapeMatch + colorMatch + countMatch + fillMatch) == 0 ? 1 : 0;
    } else {
        NSLog(@"Setcard match: wrong number of cards passed %d", [otherCards count]);
    }
    return score;
}
//-(NSDictionary *) properties {
//    
//    NSDictionary *p = @{@"shape" : @self.shape, @"color" : @self.color, @"count" : @self.count, @"fill" : @self.fill};
//    return p;
//}
//-(void)setProperties: (NSDictionary *) props
//{
//    self.shape = [props[@"shape"] intValue];
//    self.color = props[@"color"];
//    self.count = props[@"count"];
//    self.fill = props[@"fill"];
//    //self.properties = @{@"shape": shape, @"color": aColor, @"count": [NSNumber numberWithInt:num],
//    //@"filled": [NSNumber numberWithInt:fill], @"isShaded": [NSNumber numberWithInt:shade]};
//}
+(NSArray *) validShapes
{
    return @[@(RECT),@(OVAL),@(DIAMOND)];
}
+(NSArray *) validColors
{
    return @[@(PURPLE),@(RED),@(GREEN)];
}
+(NSArray *) validFills
{
    return @[@(OPAQUE_FILL),@(NO_FILL),@(SHADED_FILL)];
}
+(NSArray *)validCounts
{
    return @[@(1),@(2),@(3)];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"SetCard: %d %d %d %d",self.count,self.shape,self.fill,self.color];
}
-(NSString *)contents {
    return [self description];
}
@end
