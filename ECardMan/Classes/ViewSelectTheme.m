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

- (IBAction)clickTheme:(id)sender {
    for(ViewTheme *v in mViewThemeArray)
        [v.view setBackgroundColor:[UIColor blackColor]];
    UIControl *v = (UIControl*)sender;
    NSLog(@"ssss %d", v.tag);
    [v setBackgroundColor:[UIColor blueColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mViewThemeArray = [[NSMutableArray alloc] init];
    
    for(int i=0; i<3; i++){
        for(int j=0; j<4; j++){
            ViewTheme *v = [[ViewTheme alloc] initWithNibName:@"ViewTheme" bundle:nil];
            [mViewThemeArray addObject:v];
            v.view.tag = i*4+j;
            [(UIControl*)v.view addTarget:self action:@selector(clickTheme:) forControlEvents:UIControlEventTouchDown];
            CGRect frame = v.view.frame;
            int x = 0;
            if(j==1 || j==3)
                x = 512;
            frame.origin.x = x+i*1024;
            if(j < 2)
                frame.origin.y = 0;
            else
                frame.origin.y = 300;
            
            v.view.frame = frame;
            [mScrollView addSubview:v.view];
            [v.mImage setImage:[ECardManAppDelegate core]->viewController->mViewBeforeAfter.mAfterImage.image];
        }
    }
    [mScrollView setContentSize:CGSizeMake(1024*3, mScrollView.frame.size.height)];
    
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



@end
