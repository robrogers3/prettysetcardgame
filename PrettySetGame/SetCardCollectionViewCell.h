//
//  SetCardCollectionViewCell.h
//  PrettySetGame
//
//  Created by Rob Rogers on 3/2/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardView.h"
@interface SetCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SetCardView *setcardView;

@end
