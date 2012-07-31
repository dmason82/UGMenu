//
//  FoodTableViewCell.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/20/11.
//  Copyright 2011 Doug Mason
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

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
