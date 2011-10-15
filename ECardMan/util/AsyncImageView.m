//
//  AsyncImageView.m
//  Postcard
//
//  Created by markj on 2/18/09.
//  Copyright 2009 Mark Johnson. You have permission to copy parts of this code into your own projects for any use.
//  www.markj.net
//

#import "AsyncImageView.h"
#import "ImageUtil.h"
#import "ECardManAppDelegate.h"

// This class demonstrates how the URL loading system can be used to make a UIView subclass
// that can download and display an image asynchronously so that the app doesn't block or freeze
// while the image is downloading. It works fine in a UITableView or other cases where there
// are multiple images being downloaded and displayed all at the same time. 

@implementation AsyncImageView


- (void)insertActivityIndicator {
	for(UIView *v in [self subviews]){
		[v removeFromSuperview];
	}

	UIActivityIndicatorView* activity_indicator;
	if(self.frame.size.width > 50)
		activity_indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	else
		activity_indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
	
	activity_indicator.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
	[activity_indicator startAnimating];
	[self addSubview:activity_indicator];
	
	mAlreadyHaveImage = NO;
	
	//[activity_indicator setNeedsLayout];
	//[self setNeedsLayout];
}


- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self insertActivityIndicator];
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	[self insertActivityIndicator];
	return self;
}


- (void)dealloc {
	[connection cancel]; //in case the URL is still downloading
	[connection release];
	[data release]; 
    [super dealloc];
}

- (void)cancel_connection {
	[connection cancel]; //in case the URL is still downloading
	[connection release];
	[data release]; 
	connection = nil;
	data = nil;
}

- (void)showImage:(UIImageView*)image_view {
	image_view.alpha = 0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	image_view.alpha = 1.0;	
	[UIView commitAnimations];
}

- (void)loadImageFromURLCore:(NSURL*)url need_signed:(BOOL)need_signed {
	//if (connection!=nil) { [connection release]; } //in case we are downloading a 2nd image
	if (connection!=nil) { 	[self cancel_connection]; } //in case we are downloading a 2nd image
	if (data!=nil) { [data release]; data = nil;}
	
	if(mAlreadyHaveImage)
		[self insertActivityIndicator];
	
	mFileName = [NSString stringWithFormat:@"%@%@", [url host], [url path]];
	mFileName = [mFileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	mFileName = [[NSString alloc] initWithString:mFileName];
	
	
	
	if([[ECardManAppDelegate core] isFileExist:mFileName]){ // file is in cache directory ?
		NSData *image_data = [[ECardManAppDelegate core] contentOfFile:mFileName];

		/* not help speed 
		UIImage *img = [UIImage imageWithData:image_data];
		img = [ImageUtil resizeImage:img scaledToSize:CGSizeMake(self.frame.size.width*2, self.frame.size.height*2) scaleFactor:1.0 ox:0 oy:0];
		img = [UIImage imageWithCGImage:img.CGImage scale:2 orientation:img.imageOrientation]; 
		UIImageView* imageView = [[[UIImageView alloc] initWithImage:img] autorelease];
		imageView.contentMode = UIViewContentModeTopLeft;
		imageView.autoresizingMask = UIViewAutoresizingNone;
		*/
		
		//make an image view for the image
		UIImageView* imageView = [[[UIImageView alloc] initWithImage:[UIImage imageWithData:image_data]] autorelease];
		//make sizing choices based on your needs, experiment with these. maybe not all the calls below are needed.
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
		
		for (UIView *view in self.subviews)
			[view removeFromSuperview];
		[self addSubview:imageView];
		imageView.frame = self.bounds;
		[imageView setNeedsLayout];
		[self setNeedsLayout];
		mAlreadyHaveImage = YES;
		
		[mFileName release];
		[self showImage:imageView];
	}else{
        NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //notice how delegate set to 
	}
}


- (void)loadImageFromURLSigned:(NSURL*)url {
	[self loadImageFromURLCore:url need_signed:YES];
}


- (void)loadImageFromURL:(NSURL*)url {
	[self loadImageFromURLCore:url need_signed:FALSE];
}


//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; } 
	[data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	//so self data now has the complete image 
	[connection release];
	connection=nil;
	
	for(UIView *v in [self subviews]){
		[v removeFromSuperview];
	}
	
	printf("ddd %s\n", [mFileName UTF8String]);
	[[ECardManAppDelegate core] saveFile:mFileName data:data];
	[mFileName release];
	//printf("file = %s\n", [mFileName UTF8String]);
	
	
	//make an image view for the image
	UIImageView* imageView = [[[UIImageView alloc] initWithImage:[UIImage imageWithData:data]] autorelease];
	//make sizing choices based on your needs, experiment with these. maybe not all the calls below are needed.
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
	for (UIView *view in self.subviews)
		[view removeFromSuperview];
	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[imageView setNeedsLayout];
	[self setNeedsLayout];
	mAlreadyHaveImage = YES;
	
	[data release]; //don't need this any more, its in the UIImageView now
	data=nil;

	[self showImage:imageView];
}

//just in case you want to get the image directly, here it is in subviews
- (UIImage*) image {
	UIImageView* iv = [[self subviews] objectAtIndex:0];
	return [iv image];
}

@end