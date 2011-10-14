//
//  ViewSelectTheme.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewSelectTheme : UIViewController {
@public
	IBOutlet UIScrollView *mScrollView;
    NSMutableArray *mViewThemeArray;
}

@property (nonatomic, retain) IBOutlet UIScrollView *mScrollView;

- (IBAction)clickNext:(id)sender;


@end
