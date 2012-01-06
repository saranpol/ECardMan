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
@synthesize mImageBg;
@synthesize mLabel;
@synthesize mName;
@synthesize mNameTextField;
@synthesize mEmailTextField;	
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

- (void)setup {
	if([ECardManAppDelegate core]->viewController->mViewChooseYourself->mCurrentItem){
		[mNameTextField setText:[[ECardManAppDelegate core]->viewController->mViewChooseYourself->mCurrentItem objectForKey:@"name"]];
		[mEmailTextField setText:[[ECardManAppDelegate core]->viewController->mViewChooseYourself->mCurrentItem objectForKey:@"email"]];
        [mName setText:[[ECardManAppDelegate core]->viewController->mViewChooseYourself->mCurrentItem objectForKey:@"name"]];
	}else{
		[mNameTextField setText:@""];
		[mEmailTextField setText:@""];
        [mName setText:@""];
	}
    
    
    
    NSString *s;
    switch ([ECardManAppDelegate core]->viewController->mCurrentColorIndex) {
        case 0:
            s = @"01";
            break;
        case 1:
            s = @"03";
            break;
        case 2:
            s = @"05";
            break;
        case 3:
            s = @"07";
            break;
        case 4:
            s = @"08";
            break;
        case 5:
            s = @"09";
            break;
        case 6:
            s = @"10";
            break;
        case 7:
            s = @"11";
            break;
        case 8:
            s = @"13";
            break;
        case 9:
            s = @"14";
            break;
        default:
            s = @"01";
            break;
    }
    
    s = [s stringByAppendingFormat:@"-%d.png", ([ECardManAppDelegate core]->viewController->mCurrentThemeId + 1)];
    [mImageBg setImage:[UIImage imageNamed:s]];

    if([ECardManAppDelegate core]->viewController->mCurrentThemeId > 1){
        CGRect f = mLabel.frame;
        f.origin.x += 40;
        f.size.width -= 40;
        [mLabel setFrame:f];
        
        f = mName.frame;
        f.origin.x = 71;
        [mName setFrame:f];
    }
    

    
}

- (void)textFieldDidChange:(id)sender {
    [mName setText:mNameTextField.text];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    [mImage setImage:[ECardManAppDelegate core]->viewController->mViewBeforeAfter.mAfterImage.image];
    [mTextView setDelegate:self];
    [mNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

	[[NSNotificationCenter defaultCenter] addObserver:self  
											 selector:@selector(keyboardShowNotification:)  
												 name:UIKeyboardDidShowNotification  
											   object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  
											 selector:@selector(keyboardHideNotification:)  
												 name:UIKeyboardWillHideNotification  
											   object:nil];
    
    [mName setFont:[UIFont fontWithName:@"KylesHand" size:30]];
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
    [mImageBg release];
    [mLabel release];
    [mName release];
	[mNameTextField release];
	[mEmailTextField release];
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
    
    if([ECardManAppDelegate core]->viewController->mCurrentName)
        [[ECardManAppDelegate core]->viewController->mCurrentName release];
    if([ECardManAppDelegate core]->viewController->mCurrentEmail)
        [[ECardManAppDelegate core]->viewController->mCurrentEmail release];
    [ECardManAppDelegate core]->viewController->mCurrentName = [mNameTextField.text copy];
    [ECardManAppDelegate core]->viewController->mCurrentEmail = [mEmailTextField.text copy];
}

- (IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewSelectTheme];
    
    [[ECardManAppDelegate core]->viewController->mViewPersonalize release];
    [ECardManAppDelegate core]->viewController->mViewPersonalize = nil;
}


- (void)textViewDidChange:(UITextView *)textView {
    [mLabel setText:mTextView.text];
}



@end
