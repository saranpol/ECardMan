    //
//  ViewPersonalize.m
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewPersonalize.h"
#import "ECardManAppDelegate.h"
#import "ECardManViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewPersonalize

@synthesize mImage;
@synthesize mLabel;
@synthesize mTextView;
@synthesize mView;

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


// fix problem mTextView Content Offset Changed
- (void)keyboardShowNotification:(NSNotification*)notification {  
    if(self.view.frame.origin.y == 0){
        CGRect frame = self.view.frame;
        frame.origin.y = -200;
        self.view.frame = frame;
    }
} 

- (void)keyboardHideNotification:(NSNotification*)notification {  
    if(self.view.frame.origin.y != 0){
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }
} 


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    [mImage setImage:[ECardManAppDelegate core]->viewController->mViewBeforeAfter.mAfterImage.image];
    [mTextView setDelegate:self];

	[[NSNotificationCenter defaultCenter] addObserver:self  
											 selector:@selector(keyboardShowNotification:)  
												 name:UIKeyboardDidShowNotification  
											   object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  
											 selector:@selector(keyboardHideNotification:)  
												 name:UIKeyboardWillHideNotification  
											   object:nil];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	
    [mImage release];
    [mLabel release];
    [mTextView release];
    [mView release];
    [super dealloc];
}

- (IBAction)clickNext:(id)sender {
    UIGraphicsBeginImageContext(mView.bounds.size);
    [mView.layer renderInContext:UIGraphicsGetCurrentContext()];
    if([ECardManAppDelegate core]->viewController->mEcardImage)
        [[ECardManAppDelegate core]->viewController->mEcardImage release];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [ECardManAppDelegate core]->viewController->mEcardImage = [image copy];
    UIGraphicsEndImageContext();

    [self.view removeFromSuperview];
	[[ECardManAppDelegate core]->viewController gotoViewEmailFriend];
        
    [[ECardManAppDelegate core]->viewController->mViewPersonalize release];
    [ECardManAppDelegate core]->viewController->mViewPersonalize = nil;
}


- (void)textViewDidChange:(UITextView *)textView {
    [mLabel setText:mTextView.text];
}



@end
