//
//  ViewChooseYourself.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NUM_PHOTO_PER_PAGE 10
@interface ViewChooseYourself : UIViewController <UIScrollViewDelegate> {
@public
	IBOutlet UIScrollView *mScrollView;
	IBOutlet UIButton *mNextButton;
	NSMutableArray *mImageList;
	NSMutableArray *mLabelList;
	NSMutableArray *mDataList;
	int mPage;
	BOOL mShouldHaveNext;
	NSDictionary *mCurrentItem;
	UIImage *mCurrentImage;
}

@property (nonatomic, retain) IBOutlet UIScrollView *mScrollView;
@property (nonatomic, retain) IBOutlet UIButton *mNextButton;

-(IBAction)clickNext:(id)sender;
-(IBAction)clickBack:(id)sender;
-(IBAction)clickReload:(id)sender;
- (void)receivedJson:(NSDictionary*)data;
- (void)shouldLoadData;
@end
