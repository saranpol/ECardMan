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
@synthesize mLoadingView;
@synthesize mFriendsLabel;

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

- (void)setup {
	NSString *text = @"";
	
	if(mEmail_1 && mEmail_1.length > 0)
		text = [text stringByAppendingFormat:@"%@", mEmail_1];
	if(mName_1 && mName_1.length > 0)
		text = [text stringByAppendingFormat:@" (%@)", mName_1];
	
	if(mEmail_2 && mEmail_2.length > 0)
		text = [text stringByAppendingFormat:@", %@", mEmail_2];
	if(mName_2 && mName_2.length > 0)
		text = [text stringByAppendingFormat:@" (%@)", mName_2];
	
	if(mEmail_3 && mEmail_3.length > 0)
		text = [text stringByAppendingFormat:@", %@", mEmail_3];
	if(mName_3 && mName_3.length > 0)
		text = [text stringByAppendingFormat:@" (%@)", mName_3];
	
	if(mEmail_4 && mEmail_4.length > 0)
		text = [text stringByAppendingFormat:@", %@", mEmail_4];
	if(mName_4 && mName_4.length > 0)
		text = [text stringByAppendingFormat:@" (%@)", mName_4];
	
	if(mEmail_5 && mEmail_5.length > 0)
		text = [text stringByAppendingFormat:@", %@", mEmail_5];
	if(mName_5 && mName_5.length > 0)
		text = [text stringByAppendingFormat:@" (%@)", mName_5];
	
	[mFriendsLabel setText:text];
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
	[mLoadingView release];
	[mFriendsLabel release];
	
	if(mEmail_1)
		[mEmail_1 release];
	if(mEmail_2)
		[mEmail_2 release];
	if(mEmail_3)
		[mEmail_3 release];
	if(mEmail_4)
		[mEmail_4 release];
	if(mEmail_5)
		[mEmail_5 release];

	if(mName_1)
		[mName_1 release];
	if(mName_2)
		[mName_2 release];
	if(mName_3)
		[mName_3 release];
	if(mName_4)
		[mName_4 release];
	if(mName_5)
		[mName_5 release];

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

- (void)sendEcardData:(id)listener name:(NSString*)name tel:(NSString*)tel email:(NSString*)email image:(UIImage*)image image2:(UIImage*)image2 {
	//NSMutableURLRequest *request = [self create_request:@"http://api.hlpth.com/test_upload/"];
	
	NSString *submit_url;
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	submit_url = [prefs objectForKey:@"mSubmitUrl"];
	if(!submit_url)
		submit_url = DEFAULT_SUBMIT_URL;
	
	NSString *register_id = [[ECardManAppDelegate core]->viewController->mViewChooseYourself->mCurrentItem objectForKey:@"register_id"];
	submit_url = [submit_url stringByAppendingFormat:@"/%@", register_id];
	
	NSMutableURLRequest *request = [self create_request:submit_url];
	
	
	m_http_request = [[[HttpRequest alloc] init] autorelease];
	m_http_request->mListener = listener;
	
	//[http_request cancel_connect];
	assert(m_http_request.connection == nil);
	
	NSMutableData *post_data = [NSMutableData data];
	
	NSMutableDictionary *post_data_arr = [NSMutableDictionary dictionaryWithCapacity:0];
	
	
	[post_data_arr setObject:mEmail_1 forKey:@"AfterForm[friend_1_email]"];
	[post_data_arr setObject:mEmail_2 forKey:@"AfterForm[friend_2_email]"];
	[post_data_arr setObject:mEmail_3 forKey:@"AfterForm[friend_3_email]"];
	[post_data_arr setObject:mEmail_4 forKey:@"AfterForm[friend_4_email]"];
	[post_data_arr setObject:mEmail_5 forKey:@"AfterForm[friend_5_email]"];

	[post_data_arr setObject:mName_1 forKey:@"AfterForm[friend_1_name]"];
	[post_data_arr setObject:mName_2 forKey:@"AfterForm[friend_2_name]"];
	[post_data_arr setObject:mName_3 forKey:@"AfterForm[friend_3_name]"];
	[post_data_arr setObject:mName_4 forKey:@"AfterForm[friend_4_name]"];
	[post_data_arr setObject:mName_5 forKey:@"AfterForm[friend_5_name]"];
    
    
    
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
    [post_data_arr setObject:s forKey:@"AfterForm[lip_no]"];
    
    [post_data_arr setObject:[ECardManAppDelegate core]->viewController->mCurrentEmail forKey:@"AfterForm[email]"];
    [post_data_arr setObject:[ECardManAppDelegate core]->viewController->mCurrentName forKey:@"AfterForm[name]"];
    
    
    //[post_data_arr setObject:s forKey:@"AfterForm[phone]"];
    
    
    
    
	
	//[post_data_arr setObject:@"true" forKey:@"is_web"];
	
	
	NSString *post_data_multipart = [self arrayToMultipart:post_data_arr boundary:BOUNDARY];
	NSData *image_data = UIImageJPEGRepresentation(image, 1.0);
	post_data_multipart = [post_data_multipart stringByAppendingFormat:@"--%@\r\n", BOUNDARY];
	post_data_multipart = [post_data_multipart stringByAppendingString:@"Content-Disposition: form-data; name=\"AfterForm[image]\"; filename=\"after.jpg\"\r\n"];
	post_data_multipart = [post_data_multipart stringByAppendingString:@"Content-Type: image/jpeg\r\n\r\n"];
	[post_data appendData:[post_data_multipart dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
	[post_data appendData:image_data];
	
	NSData *image_data2 = UIImageJPEGRepresentation(image2, 1.0);
	post_data_multipart = [NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDARY];
	post_data_multipart = [post_data_multipart stringByAppendingString:@"Content-Disposition: form-data; name=\"AfterForm[ecard]\"; filename=\"ecard.jpg\"\r\n"];
	post_data_multipart = [post_data_multipart stringByAppendingString:@"Content-Type: image/jpeg\r\n\r\n"];
	[post_data appendData:[post_data_multipart dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
	[post_data appendData:image_data2];
	
		
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
	
	
	m_http_request.connection = [NSURLConnection connectionWithRequest:request delegate:m_http_request];
	assert(m_http_request.connection != nil);
	
	// Tell the UI we're receiving.
    [m_http_request _receiveDidStart];
}



- (void)receivedJson:(NSDictionary*)data {
    // if data == nil error show
    
    [self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewThankYou];

    [[ECardManAppDelegate core]->viewController->mViewSend release];
    [ECardManAppDelegate core]->viewController->mViewSend = nil;
}


    
- (IBAction)clickSend:(id)sender {
	mLoadingView.hidden = NO;
	UIImage *before_image = [ECardManAppDelegate core]->viewController->mViewBeforeAfter.mAfterImage.image;
    [self sendEcardData:self name:@"Ecard" tel:@"111" email:@"asdf@asdf.com" image:before_image image2:mImage.image];
}

- (IBAction)clickBack:(id)sender {
	[m_http_request cancel_connect];
	
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewEmailFriend];
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend->mName1 setText:mName_1];
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend->mName2 setText:mName_2];
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend->mName3 setText:mName_3];
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend->mName4 setText:mName_4];
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend->mName5 setText:mName_5];

	[[ECardManAppDelegate core]->viewController->mViewEmailFriend->mEmail1 setText:mEmail_1];
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend->mEmail2 setText:mEmail_2];
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend->mEmail3 setText:mEmail_3];
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend->mEmail4 setText:mEmail_4];
    [[ECardManAppDelegate core]->viewController->mViewEmailFriend->mEmail5 setText:mEmail_5];
	
	
    [[ECardManAppDelegate core]->viewController->mViewSend release];
    [ECardManAppDelegate core]->viewController->mViewSend = nil;
}

@end
