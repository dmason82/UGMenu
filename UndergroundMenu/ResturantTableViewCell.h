//
//  ResturantTableViewCell.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResturantTableViewCell : UITableViewCell
{
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* descriptionLabel;
    IBOutlet UIImageView* picture;
}
@property(nonatomic,retain)UILabel* nameLabel;
@property(nonatomic,retain)UILabel* descriptionLabel;
@property(nonatomic,retain)UIImageView* picture;
@end
