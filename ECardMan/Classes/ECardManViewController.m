//
//  ECardManViewController.m
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECardManViewController.h"

@implementation ECardManViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	mImagePicker = [[UIImagePickerController alloc] init];
	[mImagePicker setAllowsEditing:NO];
    [mImagePicker setDelegate:self];

	
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight) || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mImagePicker release];
	if(mPopoverController)
		[mPopoverController release];

	if(mViewHowToPlay)
		[mViewHowToPlay release];
	if(mViewChooseYourself)
		[mViewChooseYourself release];
	if(mViewBeforeAfter)
		[mViewBeforeAfter release];
	if(mViewSelectTheme)
		[mViewSelectTheme release];
	if(mViewPersonalize)
		[mViewPersonalize release];
	if(mViewEmailFriend)
		[mViewEmailFriend release];
	if(mViewSend)
		[mViewSend release];
	if(mViewThankYou)
		[mViewThankYou release];
    
    if(mEcardImage)
        [mEcardImage release];
	
    [super dealloc];
}




- (UIImage*)rotateImage:(UIImage*)img byOrientationFlag:(UIImageOrientation)orient
{
	CGImageRef          imgRef = img.CGImage;
	CGFloat             width = CGImageGetWidth(imgRef);
	CGFloat             height = CGImageGetHeight(imgRef);
	CGAffineTransform   transform = CGAffineTransformIdentity;
	CGRect              bounds = CGRectMake(0, 0, width, height);
	CGSize              imageSize = bounds.size;
	CGFloat             boundHeight;
	
	switch(orient) {
			
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;
			
		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationLeft: //EXIF = 6
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRight: //EXIF = 8
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		default:
			// image is not auto-rotated by the photo picker, so whatever the user
			// sees is what they expect to get. No modification necessary
			transform = CGAffineTransformIdentity;
			break;
			
	}
	
	UIGraphicsBeginImageContext(bounds.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if ((orient == UIImageOrientationDown) || (orient == UIImageOrientationRight) || (orient == UIImageOrientationUp)){
		// flip the coordinate space upside down
		CGContextScaleCTM(context, 1, -1);
		CGContextTranslateCTM(context, 0, -height);
	}
	
	CGContextConcatCTM(context, transform);
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageCopy;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[mImagePicker dismissModalViewControllerAnimated:YES];
	[mViewChooseYourself.view removeFromSuperview];
	[self gotoViewBeforeAfter];
	
	UIImage *original_image =[info objectForKey:UIImagePickerControllerOriginalImage];
	[mViewBeforeAfter.mAfterImage setImage:[self rotateImage:original_image byOrientationFlag:original_image.imageOrientation]];
	if(mViewChooseYourself->mCurrentImage)
		[mViewBeforeAfter.mBeforeImage setImage:mViewChooseYourself->mCurrentImage];
	else {
		[mViewBeforeAfter.mBeforeImage setImage:[UIImage imageNamed:@"choose_yourself_default.png"]];
	}


}






-(void)gotoViewCamera {
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[mImagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
		mImagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
		[self presentModalViewController:mImagePicker animated:YES];
    }else{
		[mImagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			if(!mPopoverController)
				mPopoverController = [[UIPopoverController alloc] initWithContentViewController: mImagePicker];
			[mPopoverController presentPopoverFromRect:CGRectMake(0, 0, 1024, 768) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		}else 
			[self presentModalViewController:mImagePicker animated:YES];
	}
}


-(void)gotoViewHowToPlay {
	if(!mViewHowToPlay)
		mViewHowToPlay = [[ViewHowToPlay alloc] initWithNibName:@"ViewHowToPlay" bundle:nil];
	[self.view addSubview:mViewHowToPlay.view];
}	

-(void)gotoViewChooseYourself {
	if(!mViewChooseYourself)
		mViewChooseYourself = [[ViewChooseYourself alloc] initWithNibName:@"ViewChooseYourself" bundle:nil];
	[self.view addSubview:mViewChooseYourself.view];
}	

-(void)gotoViewBeforeAfter {
	if(!mViewBeforeAfter)
		mViewBeforeAfter = [[ViewBeforeAfter alloc] initWithNibName:@"ViewBeforeAfter" bundle:nil];
	[self.view addSubview:mViewBeforeAfter.view];
}

-(void)gotoViewSelectTheme {
	if(!mViewSelectTheme)
		mViewSelectTheme = [[ViewSelectTheme alloc] initWithNibName:@"ViewSelectTheme" bundle:nil];
	[self.view addSubview:mViewSelectTheme.view];
}

-(void)gotoViewPersonalize {
	if(!mViewPersonalize)
		mViewPersonalize = [[ViewPersonalize alloc] initWithNibName:@"ViewPersonalize" bundle:nil];
	[self.view addSubview:mViewPersonalize.view];
	[mViewPersonalize setup];
}

-(void)gotoViewEmailFriend {
	if(!mViewEmailFriend)
		mViewEmailFriend = [[ViewEmailFriend alloc] initWithNibName:@"ViewEmailFriend" bundle:nil];
	[self.view addSubview:mViewEmailFriend.view];
}

-(void)gotoViewSend {
	if(!mViewSend)
		mViewSend = [[ViewSend alloc] initWithNibName:@"ViewSend" bundle:nil];
	[self.view addSubview:mViewSend.view];
}

-(void)gotoViewThankYou {
	if(!mViewThankYou)
		mViewThankYou = [[ViewThankYou alloc] initWithNibName:@"ViewThankYou" bundle:nil];
	[self.view addSubview:mViewThankYou.view];
}

-(void)gotoViewSetting {
	if(!mViewSetting)
		mViewSetting = [[ViewSetting alloc] initWithNibName:@"ViewSetting" bundle:nil];
	[self.view addSubview:mViewSetting.view];
}


-(IBAction)clickStartNow:(id)sender{
	[self gotoViewHowToPlay];
}
-(IBAction)clickSetting:(id)sender{
    [self gotoViewSetting];
}

@end
