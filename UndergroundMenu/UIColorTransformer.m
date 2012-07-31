//
//  UIColorTransformer.m
//  UndergroundMenu
//
//  Created by Doug Mason on 8/27/11.
//  Copyright 2011 Doug Mason

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

#import "UIColorTransformer.h"

@implementation UIColorTransformer
+(Class)transformedValueClass
{
    return [NSData class];
}
+(BOOL)allowsReverseTransformation
{
    return YES;
}
-(id)transformedValue:(id)value
{
    UIColor* color =(UIColor*) value;
    const CGFloat* components = CGColorGetComponents(color.CGColor);
    
    NSString* result = [NSString stringWithFormat:@"%f,%f,%f",components[0],components[1],components[2]];
    return [result dataUsingEncoding:NSUTF8StringEncoding];
}

-(id)reverseTransformedValue:(id)value
{
    NSString* string = [(NSString*)[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
    NSArray* components = [string componentsSeparatedByString:@","];
    CGFloat red = [[components objectAtIndex:0] floatValue];
    CGFloat green = [[components objectAtIndex:1] floatValue];
    CGFloat blue = [[components objectAtIndex:2] floatValue];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
