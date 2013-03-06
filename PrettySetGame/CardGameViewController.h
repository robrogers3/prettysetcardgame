//
//  ViewController.h
//  PrettySetGame
//
//  Created by Rob Rogers on 3/2/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "SetCardGame.h"
@interface CardGameViewController : UIViewController

-(Deck *)createDeck;//abstrack
@property (nonatomic) NSUInteger startingCardCount;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (strong,nonatomic) SetCardGame *game;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card;//abstract
-(void)updateStatus:(UIView *)view withMove:(CardGameMove *)move; // abstract
-(void)clearStatus:(UIView *)view;
@end
