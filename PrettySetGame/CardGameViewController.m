//
//  ViewController.m
//  PrettySetGame
//
//  Created by Rob Rogers on 3/2/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "CardGameViewController.h"
#import "SetCardGame.h" //need to change to abstract class
#import "CardGameMove.h"

@interface CardGameViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation CardGameViewController

#pragma mark - UICollectionViewDataSource Delegate Signup

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    //abstract
}

#pragma mark - Properties

-(SetCardGame *)game {
    if (!_game)
        _game = [[SetCardGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
    return _game;
                 
}
-(Deck *)createDeck
{
    return nil;//abstract
}
#pragma mark - implementation

-(void)updateStatus:(UIView *)view withMove:(CardGameMove *)move
{
    ;//abstract
}
-(void)clearStatus:(UIView *)view
{
    for (UIView *subview in [view subviews])
        [subview removeFromSuperview];
}
-(void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}
#pragma mark - actions

- (IBAction)selectCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        CardGameMove *move = [self.game selectCardAtIndex:indexPath.item];
        [self clearStatus:self.statusView];
        //NSLog(@"%@",move);
        if (move) {
            [self updateStatus:self.statusView withMove:move];
            if (move.moveKind == MoveKindMatchForPoints)
            {
                NSMutableArray *ipa = [[NSMutableArray alloc] init];
                for (Card *card in move.cardsFlipped)
                {
                    NSIndexPath *ip = [NSIndexPath indexPathForItem:[self.game indexOfCard:card] inSection:0];
                    [ipa addObject:ip];
                }
                for (Card *card in move.cardsFlipped) {
                    [self.game removeCardAtIndex:[self.game indexOfCard:card]];
                }
                [self.cardCollectionView deleteItemsAtIndexPaths:ipa];
            }
        }
        //before call to update UI need to:
        //- display played cards: say in 0-3 setcardviews. or before in statusView
        //- display play result: SCORE, PENALTY, Selected Card in above
        //- upon match -- remove cards from game.
        // NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        //- upon match -- delete something from uicollection view? [self.collectionView deleteItemsAtIndexPaths:]?
        [self updateUI];
    }
}
- (IBAction)deal:(UIButton *)sender {
    self.game = nil;
    self.statusLabel.text = @"New Deal";
    [self clearStatus:self.statusView];
    [self.cardCollectionView reloadData];
    [self updateUI];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.statusLabel.text = @"Your Play!";
}
@end
