//
//  ViewSelectTheme.m
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewSelectTheme.h"
#import "ECardManAppDelegate.h"
#import "ECardManViewController.h"
#import "ViewTheme.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewSelectTheme

@synthesize mScrollView;

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

- (void)deselectAllTheme {
	for(ViewTheme *v in mViewThemeArray)
        v.view.layer.borderWidth = 0.0f;
}

- (IBAction)clickTheme:(id)sender {
	[self deselectAllTheme];
    UIControl *v = (UIControl*)sender;
	v.layer.borderColor = [UIColor colorWithRed:237.0/255.0 green:195.0/255.0 blue:119.0/255.0 alpha:1.0].CGColor;
	v.layer.borderWidth = 5.0f;
	[ECardManAppDelegate core]->viewController->mCurrentThemeId = v.tag;
    NSLog(@"ssss %d", v.tag);
}


#define THEME_PAGE 1
//#define THEME_PAGE 3

- (void)viewDidLoad {
    [super viewDidLoad];
    mViewThemeArray = [[NSMutableArray alloc] init];
    
    
    for(int i=0; i<THEME_PAGE; i++){
        for(int j=0; j<4; j++){
            ViewTheme *v = [[ViewTheme alloc] initWithNibName:@"ViewTheme" bundle:nil];
            [mViewThemeArray addObject:v];
            v.view.tag = i*4+j;
            [(UIControl*)v.view addTarget:self action:@selector(clickTheme:) forControlEvents:UIControlEventTouchDown];
            CGRect frame = v.view.frame;
            int x = 70;
            if(j==1 || j==3)
                x = 512+30;
            frame.origin.x = x+i*1024;
            if(j < 2)
                frame.origin.y = 0;
            else
                frame.origin.y = 300;
            
            v.view.frame = frame;
            [mScrollView addSubview:v.view];
            [v.mImage setImage:[ECardManAppDelegate core]->viewController->mViewBeforeAfter.mAfterImage.image];
            
            //[ECardManAppDelegate core]->viewController->mCurrentColorIndex
            // XXX set background image
            
        }
    }
    
    [mScrollView setContentSize:CGSizeMake(1024*THEME_PAGE, mScrollView.frame.size.height)];
    
    ViewTheme *first_theme = [mViewThemeArray objectAtIndex:0];
    [self clickTheme:first_theme.view];
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
    [mScrollView release];
    for(ViewTheme *v in mViewThemeArray)
        [v release];
    [mViewThemeArray release];
    
    [super dealloc];
}


- (IBAction)clickNext:(id)sender {
	[self.view removeFromSuperview];
	[[ECardManAppDelegate core]->viewController gotoViewPersonalize];
    
    [[ECardManAppDelegate core]->viewController->mViewSelectTheme release];
    [ECardManAppDelegate core]->viewController->mViewSelectTheme = nil;
}

- (IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewBeforeAfter];

    [[ECardManAppDelegate core]->viewController->mViewSelectTheme release];
    [ECardManAppDelegate core]->viewController->mViewSelectTheme = nil;
}

@end
