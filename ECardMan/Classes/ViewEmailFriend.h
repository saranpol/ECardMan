//
//  ViewEmailFriend.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewEmailFriend : UIViewController {
@public
	IBOutlet UIImageView *mImage;
	
	IBOutlet UITextField *mName1;
	IBOutlet UITextField *mName2;
	IBOutlet UITextField *mName3;
	IBOutlet UITextField *mName4;
	IBOutlet UITextField *mName5;

	IBOutlet UITextField *mEmail1;
	IBOutlet UITextField *mEmail2;
	IBOutlet UITextField *mEmail3;
	IBOutlet UITextField *mEmail4;
	IBOutlet UITextField *mEmail5;
	
	
}

@property (nonatomic, retain) IBOutlet UIImageView *mImage;
@property (nonatomic, retain) IBOutlet UITextField *mName1;
@property (nonatomic, retain) IBOutlet UITextField *mName2;
@property (nonatomic, retain) IBOutlet UITextField *mName3;
@property (nonatomic, retain) IBOutlet UITextField *mName4;
@property (nonatomic, retain) IBOutlet UITextField *mName5;

@property (nonatomic, retain) IBOutlet UITextField *mEmail1;
@property (nonatomic, retain) IBOutlet UITextField *mEmail2;
@property (nonatomic, retain) IBOutlet UITextField *mEmail3;
@property (nonatomic, retain) IBOutlet UITextField *mEmail4;
@property (nonatomic, retain) IBOutlet UITextField *mEmail5;

- (IBAction)clickNext:(id)sender;
- (IBAction)clickBack:(id)sender;

@end
