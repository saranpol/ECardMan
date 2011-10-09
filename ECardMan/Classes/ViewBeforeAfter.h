//
//  ViewBeforeAfter.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewBeforeAfter : UIViewController {
@public
	IBOutlet UIImageView *mBeforeImage;
	IBOutlet UIImageView *mAfterImage;
}

@property (nonatomic, retain) IBOutlet UIImageView *mBeforeImage;
@property (nonatomic, retain) IBOutlet UIImageView *mAfterImage;

- (IBAction)clickNext:(id)sender;

@end
