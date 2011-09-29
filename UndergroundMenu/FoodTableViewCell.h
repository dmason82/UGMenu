//
//  FoodTableViewCell.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
{
    IBOutlet UIImageView* picture;
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* priceLabel;
    IBOutlet UILabel* descriptionLabel;
}
@property(nonatomic,retain)UIImageView* picture;
@property(nonatomic,retain)UILabel* nameLabel;
@property(nonatomic,retain)UILabel* priceLabel;
@property(nonatomic,retain)UILabel* descriptionLabel;
@end
