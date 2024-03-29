    //
//  ViewEmailFriend.m
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewEmailFriend.h"
#import "ECardManAppDelegate.h"
#import "ECardManViewController.h"

@implementation ViewEmailFriend
@synthesize mImage;

@synthesize mName1;
@synthesize mName2;
@synthesize mName3;
@synthesize mName4;
@synthesize mName5;

@synthesize mEmail1;
@synthesize mEmail2;
@synthesize mEmail3;
@synthesize mEmail4;
@synthesize mEmail5;

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
        frame.origin.y = -170;
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


- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self  
											 selector:@selector(keyboardShowNotification:)  
												 name:UIKeyboardDidShowNotification  
											   object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  
											 selector:@selector(keyboardHideNotification:)  
												 name:UIKeyboardWillHideNotification  
											   object:nil];
	

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
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
    [mImage release];
	
	[mName1 release];
	[mName2 release];
	[mName3 release];
	[mName4 release];
	[mName5 release];
	
	[mEmail1 release];
	[mEmail2 release];
	[mEmail3 release];
	[mEmail4 release];
	[mEmail5 release];
	
	
    [super dealloc];
}

- (IBAction)clickNext:(id)sender {
	[self.view removeFromSuperview];
	[[ECardManAppDelegate core]->viewController gotoViewSend];
    
	[ECardManAppDelegate core]->viewController->mViewSend->mName_1 = [mName1.text copy];
	[ECardManAppDelegate core]->viewController->mViewSend->mName_2 = [mName2.text copy];	
	[ECardManAppDelegate core]->viewController->mViewSend->mName_3 = [mName3.text copy];
	[ECardManAppDelegate core]->viewController->mViewSend->mName_4 = [mName4.text copy];	
	[ECardManAppDelegate core]->viewController->mViewSend->mName_5 = [mName5.text copy];	

	[ECardManAppDelegate core]->viewController->mViewSend->mEmail_1 = [mEmail1.text copy];
	[ECardManAppDelegate core]->viewController->mViewSend->mEmail_2 = [mEmail2.text copy];	
	[ECardManAppDelegate core]->viewController->mViewSend->mEmail_3 = [mEmail3.text copy];
	[ECardManAppDelegate core]->viewController->mViewSend->mEmail_4 = [mEmail4.text copy];	
	[ECardManAppDelegate core]->viewController->mViewSend->mEmail_5 = [mEmail5.text copy];	
	[[ECardManAppDelegate core]->viewController->mViewSend setup];	
	
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend release];
    [ECardManAppDelegate core]->viewController->mViewEmailFriend = nil;
}

- (IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewPersonalize];
    
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend release];
    [ECardManAppDelegate core]->viewController->mViewEmailFriend = nil;
}


@end
