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
#import "ViewSetting.h"

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
	ViewSetting *mViewSetting;
    
	UIImagePickerController *mImagePicker;
	UIPopoverController *mPopoverController;
    
    UIImage *mEcardImage;
	
	int mCurrentThemeId;

}
-(void)gotoViewHowToPlay;
-(void)gotoViewChooseYourself;
-(void)gotoViewCamera;
-(void)gotoViewBeforeAfter;
-(void)gotoViewSelectTheme;
-(void)gotoViewPersonalize;
-(void)gotoViewEmailFriend;
-(void)gotoViewSend;
-(void)gotoViewThankYou;
-(void)gotoViewSetting;


-(IBAction)clickStartNow:(id)sender;
-(IBAction)clickSetting:(id)sender;
@end

