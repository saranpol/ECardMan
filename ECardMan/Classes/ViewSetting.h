//
//  ViewSetting.h
//  ECardMan
//
//  Created by MacBook Pro on 10/16/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DEFAULT_SUBMIT_URL @"http://203.150.224.154/~estee/eventlive/index.php/register/updateafter"
#define DEFAULT_LIST_URL @"http://203.150.224.154/~estee/eventlive/index.php/register/jsonlists"

@interface ViewSetting : UIViewController {
@public
    IBOutlet UITextField *mSubmitUrl;
	IBOutlet UITextField *mGetBeforePhotoUrl;
}

@property (nonatomic, retain) IBOutlet UITextField *mSubmitUrl;
@property (nonatomic, retain) IBOutlet UITextField *mGetBeforePhotoUrl;

- (IBAction)clickBack:(id)sender;
- (IBAction)clickSaveButton:(id)sender;
- (IBAction)clickDefaultButton:(id)sender;
- (IBAction)textFieldFinished:(id)sender;

@end
