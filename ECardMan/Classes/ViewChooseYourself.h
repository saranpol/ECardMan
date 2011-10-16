//
//  ViewChooseYourself.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewChooseYourself : UIViewController {
@public
	IBOutlet UIScrollView *mScrollView;
	NSMutableArray *mImageList;
}

@property (nonatomic, retain) IBOutlet UIScrollView *mScrollView;

-(IBAction)clickNext:(id)sender;
-(IBAction)clickBack:(id)sender;
-(IBAction)clickReload:(id)sender;
- (void)receivedJson:(NSDictionary*)data;
@end
