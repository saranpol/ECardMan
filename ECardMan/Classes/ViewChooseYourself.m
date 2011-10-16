    //
//  ViewChooseYourself.m
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewChooseYourself.h"
#import "ECardManAppDelegate.h"
#import "ECardManViewController.h"
#import "HttpRequest.h"
#import "AsyncImageView.h"

@implementation ViewChooseYourself

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

- (NSMutableURLRequest*)create_request:(NSString*)url_string{
	NSURL *url = [NSURL URLWithString:[url_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	printf("url = %s\n", [[url absoluteString] UTF8String]);
	return [NSMutableURLRequest requestWithURL:url];
}

- (void)getListData:(id)listener size:(int)size page:(int)page {
	NSString *list_url;
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	list_url = [prefs objectForKey:@"mListUrl"];
	if(!list_url)
		list_url = DEFAULT_LIST_URL;

	NSString *call_url = [NSString stringWithFormat:@"%@?size=%d&page=%d", list_url, size, page];
	NSMutableURLRequest *request = [self create_request:call_url];
	HttpRequest *http_request = [[[HttpRequest alloc] init] autorelease];
	http_request->mListener = listener;
	
	assert(http_request.connection == nil);

	[request setHTTPMethod:@"GET"];
	http_request.connection = [NSURLConnection connectionWithRequest:request delegate:http_request];
	assert(http_request.connection != nil);
	
    [http_request _receiveDidStart];
}

- (IBAction)clickPhoto:(id)sender {
	// select photo
	NSLog(@"select photo");
}

- (void)receivedJson:(NSDictionary*)data {
	if(data == nil)
		return;
	BOOL success = [[data objectForKey:@"success"] boolValue];
	if(success){
		NSArray *list = [data objectForKey:@"data"];
		int x = 0;
		int y = 0;
		int width = 300;
		int i = 0;
		for(NSDictionary *a in list){
			NSString *img = [a objectForKey:@"img"];
			NSString *register_id = [a objectForKey:@"register_id"];
			NSString *name = [a objectForKey:@"name"];
			NSString *email = [a objectForKey:@"email"];
			
			CGRect frame;
			frame.size.width=width; frame.size.height=200;
			frame.origin.x=x; frame.origin.y=y;
			AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
			[mImageList addObject:asyncImage];
			asyncImage.tag = i;
			NSURL* url = [NSURL URLWithString:img];
			[asyncImage loadImageFromURL:url];
			[mScrollView addSubview:asyncImage];
			x += width+10;

			if(x > 1024-width){
				x = 0;
				y = 300;
			}
			[asyncImage addTarget:self action:@selector(clickPhoto:) forControlEvents:UIControlEventTouchUpInside];
			i++;

		}
	}
		
}

- (void)viewDidLoad {
    [super viewDidLoad];
	mImageList = [[NSMutableArray alloc] init];
	[self getListData:self size:10 page:0];
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
	[mImageList release];
    [super dealloc];
}


-(IBAction)clickNext:(id)sender{
	[[ECardManAppDelegate core]->viewController gotoViewCamera];
}

-(IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewHowToPlay];
}

-(IBAction)clickReload:(id)sender {
	for (AsyncImageView *v in mImageList) {
		[v removeFromSuperview];
	}
	[mImageList removeAllObjects];
	[self getListData:self size:10 page:0];
}


@end
