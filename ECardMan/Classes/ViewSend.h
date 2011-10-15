//
//  ViewSend.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewSend : UIViewController {
@public
	IBOutlet UIImageView *mImage;
}

@property (nonatomic, retain) IBOutlet UIImageView *mImage;

- (IBAction)clickSend:(id)sender;
- (IBAction)clickBack:(id)sender;
- (void)receivedJson:(NSDictionary*)data;

@end
