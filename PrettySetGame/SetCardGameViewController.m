//
//  SetCardGameVIewControllerViewController.m
//  PrettySetGame
//
//  Created by Rob Rogers on 3/2/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetcardGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardCollectionViewCell.h"
#import "CardGameMove.h"

@implementation SetCardGameViewController
-(SetCardDeck *)createDeck
{
    return [[SetCardDeck alloc] init];
}
-(NSUInteger)startingCardCount
{
    return 12;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [self.game cardsInGame];
}
- (IBAction)deal3MoreCards {
    NSUInteger k = [self.game addNCards:3];
    if (k != 3) {
        NSString *m = [NSString stringWithFormat:@"Empty Deck: %d cards added",k];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deck Empty!"
                                                        message:m
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        self.deal3Button.enabled = NO;
        self.deal3Button.alpha = 0.4;
    }
    [self.cardCollectionView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.cardCollectionView numberOfItemsInSection:0]-1 inSection:0];
    [self.cardCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setcardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *Setcard = (SetCard *)card;
            setCardView.selected = Setcard.selected;
            setCardView.shape = Setcard.shape;
            setCardView.color = Setcard.color;
            setCardView.count = Setcard.count;
            setCardView.fill = Setcard.fill;
            setCardView.alpha = Setcard.isUnplayable ? 0.3 : 1.0;
        }
    }
}
-(void)updateStatus:(UIView *)view withMove:(CardGameMove *)move
{
    CGFloat xOffset = 0;
    [self clearStatus:view];
    CGFloat miniCardWidth = view.bounds.size.width * 0.15f;
    if (move.moveKind == MoveKindFlipUp)
    {
        NSString *flippedUp = @"Flipped up: ";
        CGFloat widthOfLabel = 75.0f;
        UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0,0, widthOfLabel,view.bounds.size.height)];
        labelView.adjustsFontSizeToFitWidth = YES;
        labelView.backgroundColor = [UIColor clearColor];
        labelView.text = flippedUp;
        [view addSubview:labelView];
        xOffset += labelView.bounds.size.width;
    }
    for (SetCard *card in [move cardsFlipped])
    {
        if ([card isKindOfClass:[SetCard class]])
        {
            CGFloat miniCardHeight = miniCardWidth * 1.57;
            SetCardView *setCardView = [[SetCardView alloc] initWithFrame:CGRectMake(xOffset,0,miniCardWidth,miniCardHeight)];
            setCardView.opaque = NO;
            setCardView.selected = NO;
            setCardView.count = card.count;
            setCardView.shape = card.shape;
            setCardView.color = card.color;
            setCardView.fill = card.fill;
            [view addSubview:setCardView];
            xOffset += setCardView.bounds.size.width + 10;
        }
    }
    if (move.moveKind == MoveKindMatchForPoints || move.moveKind == MoveKindMismatchForPenalty)
    {
        UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(xOffset,0,view.bounds.size.width-xOffset,view.bounds.size.height)];
        labelView.adjustsFontSizeToFitWidth = YES;
        labelView.backgroundColor = [UIColor clearColor];
        labelView.numberOfLines = 3;
        if (move.moveKind == MoveKindMatchForPoints) {
            labelView.text = [NSString stringWithFormat:@"✅ Match for %d points!",move.scoreDelta];

        } else
        {
            labelView.numberOfLines = 5;
            labelView.text = [NSString stringWithFormat:@"❌ don't match! %d point penalty!", abs(move.scoreDelta)];
        }
        [view addSubview:labelView];
        xOffset += labelView.bounds.size.width;
    }
}
@end
