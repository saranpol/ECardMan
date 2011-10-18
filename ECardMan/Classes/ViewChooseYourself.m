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
#import <QuartzCore/QuartzCore.h>

@implementation ViewChooseYourself

@synthesize mScrollView;
@synthesize mNextButton;
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
	list_url = [prefs objectForKey:@"mGetBeforePhotoUrl"];
	
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

- (void)deselectAllPhoto {
	for(AsyncImageView *a in mImageList){
		a.layer.borderWidth = 0.0f;
	}
}

- (IBAction)clickPhoto:(id)sender {
	[self deselectAllPhoto];
	// select photo
	AsyncImageView *asyncImage = (AsyncImageView*)sender;
	asyncImage.layer.borderColor = [UIColor redColor].CGColor;
	asyncImage.layer.borderWidth = 5.0f;
	
	NSDictionary *a = [mDataList objectAtIndex:asyncImage.tag];
	NSString *img = [a objectForKey:@"img"];
	NSString *register_id = [a objectForKey:@"register_id"];
	NSString *name = [a objectForKey:@"name"];
	NSString *email = [a objectForKey:@"email"];
	
	mCurrentItem = a;
	mCurrentImage = [asyncImage image];
	mNextButton.hidden = NO; 
	
	NSLog(@"select photo %@ %@ %@ %@", img, register_id, name, email);
}

- (void)receivedJson:(NSDictionary*)data {
	if(data == nil)
		return;
	BOOL success = [[data objectForKey:@"success"] boolValue];
	if(success){
		NSArray *list = [data objectForKey:@"data"];
		int x = 0;
		int y = 0;
		int width = 180;
		int i = 0;
		for(NSDictionary *a in list){
			NSString *img = [a objectForKey:@"img"];
		
			CGRect frame;
			frame.size.width=width; frame.size.height=135;
			frame.origin.x=(mPage-1)*mScrollView.frame.size.width+x; frame.origin.y=y;
			AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
			[mImageList addObject:asyncImage];
			asyncImage.tag = [mDataList count];
			[mDataList addObject:a];
			NSURL* url = [NSURL URLWithString:img];
			[asyncImage loadImageFromURL:url];
			[mScrollView addSubview:asyncImage];
			x += width+10;

			if(i == 4){
				x = 0;
				y = 250;
			}
			[asyncImage addTarget:self action:@selector(clickPhoto:) forControlEvents:UIControlEventTouchUpInside];
			i++;

		}
		
		if(i == 10){
			mShouldHaveNext = YES;
		}else {
			mShouldHaveNext = NO;
			int new_width = mScrollView.contentSize.width - mScrollView.frame.size.width;
			[mScrollView setContentSize:CGSizeMake(new_width, mScrollView.frame.size.height)];
		}

	}
		
}

- (void)refreshPhoto {
	mPage = 0;
	mShouldHaveNext = YES;
	for (AsyncImageView *v in mImageList) {
		[v removeFromSuperview];
	}
	[mScrollView setContentSize:CGSizeMake(mScrollView.frame.size.width, mScrollView.frame.size.height)];
	[mScrollView setContentOffset:CGPointMake(0, 0)];
	
	[mImageList removeAllObjects];
	[mDataList removeAllObjects];
	mNextButton.hidden = YES;
	
	[self shouldLoadData];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	mImageList = [[NSMutableArray alloc] init];
	mDataList = [[NSMutableArray alloc] init];
	[self refreshPhoto];
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
	[mNextButton release];
	[mImageList release];
	[mDataList release];
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
	[self refreshPhoto];
}

- (void)shouldLoadData {
	if((mScrollView.contentOffset.x >= (mScrollView.contentSize.width - mScrollView.frame.size.width))
	   && mShouldHaveNext){
		NSLog(@"Load new page");
		[self getListData:self size:NUM_PHOTO_PER_PAGE page:mPage];
		mPage += 1;
		int new_width = mScrollView.contentSize.width + mScrollView.frame.size.width;
		[mScrollView setContentSize:CGSizeMake(new_width, mScrollView.frame.size.height)];

	}
	
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSLog(@"content x %f",scrollView.contentOffset.x);
	[self shouldLoadData];
}

@end
