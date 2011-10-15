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
#import "HttpRequest.h"

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



#define BOUNDARY @"----239048230sdAaB03x"

-(NSString*)arrayToMultipart:(NSMutableDictionary*)data boundary:(NSString*)boundary {
	NSString *str = @"";
	for(NSString* key in data) {
		NSString *value = [data objectForKey:key];
		str = [str stringByAppendingFormat:@"--%@\r\n", boundary];
		str = [str stringByAppendingFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
		str = [str stringByAppendingString:@"\r\n"];
		str = [str stringByAppendingFormat:@"%@\r\n", value];
	}
	return str;
}

- (NSMutableURLRequest*)create_request:(NSString*)url_string{
	NSURL *url = [NSURL URLWithString:[url_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	printf("url = %s\n", [[url absoluteString] UTF8String]);
	return [NSMutableURLRequest requestWithURL:url];
}

- (void)sendEcardData:(id)listener name:(NSString*)name tel:(NSString*)tel email:(NSString*)email image:(UIImage*)image {
	//NSMutableURLRequest *request = [self create_request:@"http://api.hlpth.com/test_upload/"];
	
	NSString *submit_url;
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	submit_url = [prefs objectForKey:@"mSubmitUrl"];
	if(!submit_url)
		submit_url = DEFAULT_SUBMIT_URL;
	
	NSMutableURLRequest *request = [self create_request:submit_url];
	
	
	HttpRequest *http_request = [[[HttpRequest alloc] init] autorelease];
	http_request->mListener = listener;
	
	//[http_request cancel_connect];
	assert(http_request.connection == nil);
	
	NSMutableData *post_data = [NSMutableData data];
	
	NSMutableDictionary *post_data_arr = [NSMutableDictionary dictionaryWithCapacity:0];
	[post_data_arr setObject:name forKey:@"Register[name]"];
	[post_data_arr setObject:tel forKey:@"Register[phone]"];
	[post_data_arr setObject:email forKey:@"Register[email]"];
	[post_data_arr setObject:@"0" forKey:@"Register[hidden]"];	
	NSString *post_data_multipart = [self arrayToMultipart:post_data_arr boundary:BOUNDARY];
	NSData *image_data = UIImageJPEGRepresentation(image, 1.0);
	post_data_multipart = [post_data_multipart stringByAppendingFormat:@"--%@\r\n", BOUNDARY];
	post_data_multipart = [post_data_multipart stringByAppendingString:@"Content-Disposition: form-data; name=\"Register[image]\"; filename=\"save.jpg\"\r\n"];
	post_data_multipart = [post_data_multipart stringByAppendingString:@"Content-Type: image/jpeg\r\n\r\n"];
	[post_data appendData:[post_data_multipart dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
	[post_data appendData:image_data];
	NSString *end_str = [NSString stringWithFormat:@"\r\n--%@--", BOUNDARY];
	[post_data appendData:[end_str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
	

	
	[request setHTTPMethod:@"POST"];
	// Normal post
	//if(post_data_str){
	//	post_data = [NSMutableData data];
	//	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	//	NSString *postLength = [NSString stringWithFormat:@"%d", [post_data_str length]]; 
	//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
	//	[post_data appendData:[post_data_str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
	//}
	// Multipart post
	//else if(post_data){
	[request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=\"%@\"", BOUNDARY] forHTTPHeaderField:@"Content-Type"];
	NSString *postLength = [NSString stringWithFormat:@"%d", [post_data length]]; 
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
	//}
	
	[request setHTTPBody:post_data];
	
	
	http_request.connection = [NSURLConnection connectionWithRequest:request delegate:http_request];
	assert(http_request.connection != nil);
	
	// Tell the UI we're receiving.
    [http_request _receiveDidStart];
}



- (void)receivedJson:(NSDictionary*)data {
    // if data == nil error show
    
    [self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewThankYou];

    [[ECardManAppDelegate core]->viewController->mViewSend release];
    [ECardManAppDelegate core]->viewController->mViewSend = nil;
}


    
- (IBAction)clickSend:(id)sender {
    [self sendEcardData:self name:@"Ecard" tel:@"111" email:@"asdf@asdf.com" image:mImage.image];
}

- (IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewEmailFriend];
    
    [[ECardManAppDelegate core]->viewController->mViewSend release];
    [ECardManAppDelegate core]->viewController->mViewSend = nil;
}

@end
