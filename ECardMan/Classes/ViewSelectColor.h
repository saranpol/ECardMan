//
//  ViewSelectColor.h
//  ECardMan
//
//  Created by MacBook Pro on 11/6/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewSelectColor : UIViewController{
@public
	IBOutlet UIScrollView *mScrollView;
    //NSMutableArray *mViewThemeArray;
}

@property (nonatomic, retain) IBOutlet UIScrollView *mScrollView;


- (IBAction)clickNext:(id)sender;
- (IBAction)clickBack:(id)sender;

@end
