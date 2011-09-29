//
//  LocationTableViewCell.m
//  UndergroundMenu
//
//  Created by Doug Mason on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationTableViewCell.h"

@implementation LocationTableViewCell
@synthesize nameLabel,addressLabel,distanceLabel,picture;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
