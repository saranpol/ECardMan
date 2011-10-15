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
}

@property (nonatomic, retain) IBOutlet UIImageView *mImage;

- (IBAction)clickNext:(id)sender;
- (IBAction)clickBack:(id)sender;

@end
