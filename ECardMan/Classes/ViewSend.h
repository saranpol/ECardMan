//
//  ViewSend.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequest.h"

@interface ViewSend : UIViewController {
@public
	IBOutlet UIImageView *mImage;
	IBOutlet UIView *mLoadingView;

	NSString *mEmail_1;
	NSString *mEmail_2;
	NSString *mEmail_3;
	NSString *mEmail_4;	
	NSString *mEmail_5;
	
	NSString *mName_1;
	NSString *mName_2;
	NSString *mName_3;
	NSString *mName_4;	
	NSString *mName_5;

	HttpRequest *m_http_request;
}


@property (nonatomic, retain) IBOutlet UIImageView *mImage;
@property (nonatomic, retain) IBOutlet UIView *mLoadingView;

- (IBAction)clickSend:(id)sender;
- (IBAction)clickBack:(id)sender;
- (void)receivedJson:(NSDictionary*)data;

@end
