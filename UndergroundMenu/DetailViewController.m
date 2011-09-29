//
//  DetailViewController.m
//  UndergroundMenu
//
//  Created by Doug Mason on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Food.h"
#import "Menu.h"
@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailIngredientsText = _detailIngredientsText;
@synthesize detailPicture = __detailPicture;
@synthesize detailCalorieLabel = __detailCalorieLabel;
@synthesize detailNameLabel = __detailNameLabel;
@synthesize detailPriceLabel = __detailPriceLabel;
@synthesize detailInfoView;
@synthesize detailTitlePicView;
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

  if (self.detailItem) {
        if ([self.detailItem class] == [Food class])
        {
            Food* theFood = (Food*)self.detailItem;
            self.detailNameLabel.text = theFood.name;
            NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            [formatter setMinimumFractionDigits:2];
            [formatter setMaximumFractionDigits:2];
            self.detailPriceLabel.text = [formatter stringFromNumber:theFood.price];
            self.detailCalorieLabel.text = [theFood.calories stringValue];
            self.detailIngredientsText.text = theFood.ingredients;
            [self.detailPicture setImage:[UIImage imageWithData:theFood.picture]];
            [self.detailPicture setOpaque:YES];
            [self.detailInfoView setContentSize:self.detailInfoView.frame.size];
            self.detailNameLabel.backgroundColor = self.navigationController.navigationBar.tintColor;
            self.detailNameLabel.textColor = [self.navigationController.navigationBar.titleTextAttributes valueForKey:UITextAttributeTextColor];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
