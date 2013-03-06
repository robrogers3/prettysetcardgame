//
//  SetCardView.m
//  PrettySetCard
//
//  Created by Rob Rogers on 2/28/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//
#import "SetCardView.h"
@implementation SetCardView

#pragma mark - Properties
enum {RECT = 1, OVAL, DIAMOND};
enum {PURPLE = 1, RED, GREEN};
enum {NO_FILL = 1, OPAQUE_FILL, SHADED_FILL};
-(void)setCount:(int)count {
    _count = count;
    [self setNeedsDisplay];
}
-(void)setShape:(int)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}
-(void)setColor:(int)color
{
    _color = color;
    [self setNeedsDisplay];
}
-(void)setFill:(int)fill
{
    _fill = fill;
    [self setNeedsDisplay];
}
-(void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

#pragma mark - Drawing
#define RECT_RADIUS 0.12
#define LINE_WIDTH_SCALE 0.025
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:RECT_RADIUS*self.bounds.size.width];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    if (self.selected)
        roundedRect.lineWidth = self.bounds.size.width * LINE_WIDTH_SCALE * 10;
    else
        roundedRect.lineWidth = self.bounds.size.width * LINE_WIDTH_SCALE;
    [[UIColor blackColor] setStroke];
    [roundedRect fill];
    [roundedRect stroke];
    [self drawShapes];
}
#define MARGIN_SCALE 0.10
#define SYMBOL_LINE_WIDTH 0.02
-(void)drawShapes
{
    CGPoint pt;
    pt.x = MARGIN_SCALE * self.bounds.size.width;
    pt.y = self.bounds.size.height/2;
    if (self.count == 1) {
        [self drawShapeAtPoint:pt];
    } else if (self.count == 2) {
        float dy = ([self calcShapeHeight] + MARGIN_SCALE * self.bounds.size.height)/2;
        [self drawShapeAtPoint:CGPointMake(pt.x,pt.y - dy)];
        [self drawShapeAtPoint:CGPointMake(pt.x,pt.y + dy)];
        
    } else {//3
        float dy = [self calcShapeHeight] + (MARGIN_SCALE * self.bounds.size.height);
        [self drawShapeAtPoint:pt];
        [self drawShapeAtPoint:CGPointMake(pt.x,pt.y - dy)];
        [self drawShapeAtPoint:CGPointMake(pt.x,pt.y + dy)];
    }
}
-(void) drawShapeAtPoint:(CGPoint) pt
{
    if (self.shape == RECT)
        [self drawRectAtPoint:pt];
    else if (self.shape == OVAL)
        [self drawOvalAtPoint:pt];
    else //diamond
        [self drawDiamondAtPoint:pt];
}
-(void)drawOvalAtPoint:(CGPoint) pt
{
    float h = [self calcShapeHeight];
    float dy  = h/2;
    CGRect rect = CGRectMake(pt.x,pt.y-dy,[self calcShapeWidth],h);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [self fillShape:path];
    [[self uiColor] setStroke];
    [path stroke];
}
-(void)drawRectAtPoint:(CGPoint) pt;
{
    float h = [self calcShapeHeight];
    float w = [self calcShapeWidth];
    float dy = h/2.0;
    CGRect rect = CGRectMake(pt.x,pt.y-dy,w,h);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:RECT_RADIUS*h];
    [self fillShape:path];
    [[self uiColor] setStroke];
    [path stroke];
}
-(void)drawDiamondAtPoint:(CGPoint)pt;
{
    float h = [self calcShapeHeight];
    float w = [self calcShapeWidth];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(pt.x,pt.y)];
    [path addLineToPoint:CGPointMake(pt.x + w/2,pt.y - h/2)];
    [path addLineToPoint:CGPointMake(pt.x + w,pt.y)];
    [path addLineToPoint:CGPointMake(pt.x + w/2,pt.y + h/2)];
    [path closePath];
    [self fillShape:path];
    [[self uiColor] setStroke];
    [path stroke];
}
-(void)fillShape:(UIBezierPath *)path
{
    path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
    UIColor *color = [self uiColor];
    if (self.fill == NO_FILL) {
        [[UIColor clearColor] setFill];
    } else if (self.fill == OPAQUE_FILL) {
        [color setFill];
    } else { //shaded
        color = [color colorWithAlphaComponent:0.35];
        [color setFill];
    }
    [path fill];
}

#pragma mark - Helpers
-(UIColor *)uiColor
{
    switch (self.color) {
        case PURPLE:
            return [UIColor purpleColor];
            break;
        case RED:
            return [UIColor redColor];
            break;
        case GREEN:
            return [UIColor greenColor];
            break;
        default:
            return [UIColor orangeColor];//bad color
            break;
    }
}
-(float)calcShapeWidth
{
    return self.bounds.size.width - (MARGIN_SCALE * self.bounds.size.width * 2);
}
-(float)calcShapeHeight
{
    return (self.bounds.size.height - (MARGIN_SCALE * self.bounds.size.height * 4))/3.0;
}
#pragma mark - init
-(void)setup
{
    //do init;does nothing
}
-(void)awakeFromNib{
    [self setup];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self setup];
    return self;
}
@end
