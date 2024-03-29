//
//  ViewPersonalize.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewPersonalize : UIViewController <UITextViewDelegate> {
@public
	IBOutlet UIImageView *mImage;
    IBOutlet UIImageView *mImageBg;
    IBOutlet UILabel *mLabel;
    IBOutlet UILabel *mName;
    IBOutlet UITextView *mTextView;
	IBOutlet UITextField *mNameTextField;
	IBOutlet UITextField *mEmailTextField;	
    IBOutlet UIView *mView;
}

@property (nonatomic, retain) IBOutlet UIImageView *mImage;
@property (nonatomic, retain) IBOutlet UIImageView *mImageBg;
@property (nonatomic, retain) IBOutlet UILabel *mLabel;
@property (nonatomic, retain) IBOutlet UILabel *mName;
@property (nonatomic, retain) IBOutlet UITextField *mNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *mEmailTextField;	
@property (nonatomic, retain) IBOutlet UITextView *mTextView;
@property (nonatomic, retain) IBOutlet UIView *mView;

- (IBAction)clickNext:(id)sender;
- (IBAction)clickBack:(id)sender;
- (void)setup;

@end
