//
//  ECardManViewController.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewHowToPlay.h"
#import "ViewChooseYourself.h"
#import "ViewBeforeAfter.h"
#import "ViewSelectTheme.h"
#import "ViewPersonalize.h"
#import "ViewEmailFriend.h"
#import "ViewSend.h"
#import "ViewThankYou.h"

@interface ECardManViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
@public
	ViewHowToPlay *mViewHowToPlay;
	ViewChooseYourself *mViewChooseYourself;
	ViewBeforeAfter	*mViewBeforeAfter;
	ViewSelectTheme *mViewSelectTheme;
	ViewPersonalize *mViewPersonalize;
	ViewEmailFriend *mViewEmailFriend;
	ViewSend *mViewSend;
	ViewThankYou *mViewThankYou;
	
	UIImagePickerController *mImagePicker;
	UIPopoverController *mPopoverController;
    
    UIImage *mEcardImage;

}

-(void)gotoViewChooseYourself;
-(void)gotoViewCamera;
-(void)gotoViewBeforeAfter;
-(void)gotoViewSelectTheme;
-(void)gotoViewPersonalize;
-(void)gotoViewEmailFriend;
-(void)gotoViewSend;
-(void)gotoViewThankYou;


-(IBAction)clickStartNow:(id)sender;

@end

