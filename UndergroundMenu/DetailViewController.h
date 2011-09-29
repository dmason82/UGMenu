//
//  DetailViewController.h
//  UndergroundMenu
//
//  Created by Doug Mason on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UITextView *detailIngredientsText;
@property (strong, nonatomic) IBOutlet UILabel *detailNameLabel;
@property (strong,nonatomic) IBOutlet UILabel *detailCalorieLabel;
@property (strong,nonatomic) IBOutlet UIImageView* detailPicture;
@property (strong,nonatomic) IBOutlet UILabel *detailPriceLabel;
@property (strong,nonatomic) IBOutlet UIScrollView* detailInfoView;
@property (strong,nonatomic) IBOutlet UIView* detailTitlePicView;
@end