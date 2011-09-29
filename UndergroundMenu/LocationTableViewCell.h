//
//  LocationTableViewCell.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTableViewCell : UITableViewCell
{
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* addressLabel;
    IBOutlet UILabel* distanceLabel;
    IBOutlet UIImageView* picture;
}
@property(nonatomic, retain) UILabel* nameLabel;
@property(nonatomic, retain) UILabel* addressLabel;
@property(nonatomic,retain)UILabel* distanceLabel;
@property(nonatomic,retain)UIImageView* picture;

@end
