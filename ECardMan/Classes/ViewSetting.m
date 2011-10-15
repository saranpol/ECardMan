//
//  ViewSetting.m
//  ECardMan
//
//  Created by MacBook Pro on 10/16/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "ViewSetting.h"

@implementation ViewSetting

@synthesize mSubmitUrl;

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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *url = [prefs objectForKey:@"mSubmitUrl"];
	if(!url)
		mSubmitUrl.text = DEFAULT_SUBMIT_URL;
	else
		mSubmitUrl.text = url;
    
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

- (IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
}

- (IBAction)clickSaveButton:(id)sender {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:mSubmitUrl.text forKey:@"mSubmitUrl"];
	[prefs synchronize];
}

- (IBAction)clickDefaultButton:(id)sender {
	mSubmitUrl.text = DEFAULT_SUBMIT_URL;
	[self clickSaveButton:nil];
}



- (void)dealloc {
	[mSubmitUrl release];
    [super dealloc];
}

- (IBAction)textFieldFinished:(id)sender {
	[sender resignFirstResponder];
}




@end
