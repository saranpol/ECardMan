    //
//  ViewSend.m
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewSend.h"
#import "ECardManAppDelegate.h"
#import "ECardManViewController.h"

@implementation ViewSend

@synthesize mImage;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [mImage setImage:[ECardManAppDelegate core]->viewController->mEcardImage];
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
    [mImage release];
    [super dealloc];
}

- (IBAction)clickSend:(id)sender {
	[self.view removeFromSuperview];
	[[ECardManAppDelegate core]->viewController gotoViewThankYou];
    
    [[ECardManAppDelegate core]->viewController->mViewSend release];
    [ECardManAppDelegate core]->viewController->mViewSend = nil;
}

- (IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewEmailFriend];
    
    [[ECardManAppDelegate core]->viewController->mViewSend release];
    [ECardManAppDelegate core]->viewController->mViewSend = nil;
}

@end
