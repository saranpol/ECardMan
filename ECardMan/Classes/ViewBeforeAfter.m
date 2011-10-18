    //
//  ViewBeforeAfter.m
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewBeforeAfter.h"
#import "ECardManAppDelegate.h"
#import "ECardManViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewBeforeAfter

@synthesize mBeforeImage;
@synthesize mAfterImage;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mBeforeImage release];
	[mAfterImage release];
	
    [super dealloc];
}


- (IBAction)clickNext:(id)sender {
	[self.view removeFromSuperview];
	[[ECardManAppDelegate core]->viewController gotoViewSelectTheme];
}

- (IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewChooseYourself];
}

- (void)effectImage {
	mBeforeImage.layer.shadowOffset = CGSizeMake(0, -1); 
	mBeforeImage.layer.shadowOpacity = 1; 
	mBeforeImage.layer.shadowColor = [UIColor whiteColor].CGColor; 
	CALayer *layer = mBeforeImage.layer;
	CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
	rotationAndPerspectiveTransform.m34 = 1.0 / -500;
	rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 20.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
	layer.transform = rotationAndPerspectiveTransform;

	
	mAfterImage.layer.shadowOffset = CGSizeMake(0, -1); 
	mAfterImage.layer.shadowOpacity = 1; 
	mAfterImage.layer.shadowColor = [UIColor whiteColor].CGColor; 
	CALayer *layer2 = mAfterImage.layer;
	CATransform3D rotationAndPerspectiveTransform2 = CATransform3DIdentity;
	rotationAndPerspectiveTransform2.m34 = 1.0 / -500;
	rotationAndPerspectiveTransform2 = CATransform3DRotate(rotationAndPerspectiveTransform2, -20.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
	layer2.transform = rotationAndPerspectiveTransform2;
	
}

@end
