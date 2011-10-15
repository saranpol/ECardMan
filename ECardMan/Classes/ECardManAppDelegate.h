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
    
    // File Manager
	NSError *mError;
	NSString *dataPath;
	NSString *filePath;
	
}

+ (ECardManAppDelegate *)core;

// File Manager
@property (nonatomic, copy) NSString *dataPath;
@property (nonatomic, copy) NSString *filePath;


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ECardManViewController *viewController;


// File Manager
- (void)saveFile:(NSString *)fileName data:(NSData *)tmpData;
- (void)clearDirectory;
- (void)ClearCache;
- (BOOL)isFileExist:(NSString *)fName;
- (NSData*)contentOfFile:(NSString *)fName;
- (void) setupDirectory;


@end

