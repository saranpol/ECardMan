//
//  ViewSelectColor.m
//  ECardMan
//
//  Created by MacBook Pro on 11/6/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "ViewSelectColor.h"
#import "ECardManAppDelegate.h"
#import "ECardManViewController.h"

@implementation ViewSelectColor

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (IBAction)clickNext:(id)sender {
	[self.view removeFromSuperview];
	[[ECardManAppDelegate core]->viewController gotoViewSelectTheme];
    
    [[ECardManAppDelegate core]->viewController->mViewSelectColor release];
    [ECardManAppDelegate core]->viewController->mViewSelectColor = nil;
}

- (IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewBeforeAfter];
    
    [[ECardManAppDelegate core]->viewController->mViewSelectColor release];
    [ECardManAppDelegate core]->viewController->mViewSelectColor = nil;
}



@end
