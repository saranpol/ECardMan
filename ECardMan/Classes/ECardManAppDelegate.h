//
//  ECardManAppDelegate.h
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECardManViewController;

@interface ECardManAppDelegate : NSObject <UIApplicationDelegate> {
@public
    UIWindow *window;
    ECardManViewController *viewController;
}

+ (ECardManAppDelegate *)core;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ECardManViewController *viewController;

@end

