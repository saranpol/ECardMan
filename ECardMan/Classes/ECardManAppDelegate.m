//
//  ECardManAppDelegate.m
//  ECardMan
//
//  Created by saranpol on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECardManAppDelegate.h"
#import "ECardManViewController.h"

@implementation ECardManAppDelegate

@synthesize window;
@synthesize viewController;

// File Manager
@synthesize dataPath;
@synthesize filePath;



+ (ECardManAppDelegate *)core {
    return (ECardManAppDelegate *) [UIApplication sharedApplication].delegate;
}



#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch. 
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}








// ################
// File Management
// ################

#pragma mark -
#pragma mark File Management


void AlertWithError(NSError *error)
{
    printf("Error! %s %s", [[error localizedDescription] UTF8String], [[error localizedFailureReason] UTF8String]);
	
}

/*
 - (void) saveFile:(NSString *)fileName data:(char *)buf size:(NSInteger)size{
 
 //NSData *tmpData = [NSData dataWithBytesNoCopy:(void *)buf length:size];
 NSData *tmpData = [NSData dataWithBytes:(void *)buf length:size];
 
 [filePath release]; //release previous instance
 filePath = [[dataPath stringByAppendingPathComponent:fileName] retain];
 
 //if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO)
 
 printf("write %s\n", [filePath UTF8String]);
 [[NSFileManager defaultManager] createFileAtPath:filePath
 contents:tmpData
 attributes:nil];
 }
 */
- (void)saveFile:(NSString *)fileName data:(NSData *)tmpData{
	
	[filePath release]; //release previous instance
	filePath = [[dataPath stringByAppendingPathComponent:fileName] retain];
	
	printf("write %s\n", [filePath UTF8String]);
	[[NSFileManager defaultManager] createFileAtPath:filePath
											contents:tmpData
										  attributes:nil];
}


- (void) deleteFile:(NSString *)fileName{
	NSString *fName = [dataPath stringByAppendingPathComponent:fileName];
	if ([[NSFileManager defaultManager] fileExistsAtPath:fName]) {
		if (![[NSFileManager defaultManager] removeItemAtPath:fName error:&mError])
			AlertWithError(mError);
	}
}

- (void) deleteFileFormat:(NSString *)formatName{
	//NSArray *dirContents = [[NSFileManager defaultManager] directoryContentsAtPath:dataPath];
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:&mError];
	for (NSString *file in dirContents) {
		if ([[file pathExtension] isEqualToString:formatName]) {
			[self deleteFile:file];
		}
	}
}

- (int) countFileFormat:(NSString *)formatName{
	//NSArray *dirContents = [[NSFileManager defaultManager] directoryContentsAtPath:dataPath];
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:&mError];
	int count = 0;
	for (NSString *file in dirContents) {
		if ([[file pathExtension] isEqualToString:formatName]) {
			count++;
		}
	}
	return count;
}

- (void) setupDirectory
{
	/* create path to cache directory inside the application's Documents
	 directory */
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	self.dataPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"cache"];
	printf("dataPath = %s\n", [self.dataPath UTF8String]);
	
	/* check for existence of cache directory */
	if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
		return;
	}
	
	/* create a new cache directory */
	if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath
								   withIntermediateDirectories:NO
													attributes:nil
														 error:&mError]) {
		AlertWithError(mError);
		return;
	}
}

/* removes every file in the directory */

- (void) clearDirectory
{
	/* remove the cache directory and its contents */
	if (![[NSFileManager defaultManager] removeItemAtPath:dataPath error:&mError]) {
		AlertWithError(mError);
		return;
	}
	
	/* create a new cache directory */
	if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath
								   withIntermediateDirectories:NO
													attributes:nil
														 error:&mError]) {
		AlertWithError(mError);
		return;
	}
	
}

//#define TIME_CACHE 86400.0 // one day
#define TIME_CACHE 10.0

- (BOOL)is_old_file:(NSString *)fName
{
	NSDictionary* properties = [[NSFileManager defaultManager]
								attributesOfItemAtPath:fName
								error:&mError];
	if(!properties)
		return YES;
	
	NSDate* modDate = [properties objectForKey:NSFileModificationDate];
	
	//printf("\n\n\nxxxxx %s\n", [[modDate description] UTF8String]);
	//printf("file time %f \n", [modDate timeIntervalSinceNow]);
	
	if(fabs([modDate timeIntervalSinceNow]) > TIME_CACHE)
		return YES;
	else
		return NO;
}

//#define KFileCardNearMeList @"list.nml"
- (void)ClearCache
{
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:&mError];
	for (NSString *file in dirContents) {
		//if([self is_old_file:file]){
        [self deleteFile:file];
        printf("will delete file cache = %s\n", [file UTF8String]);
		//}
	}
}


- (BOOL)isFileExist:(NSString *)fName
{
	fName = [dataPath stringByAppendingPathComponent:fName];
	return [[NSFileManager defaultManager] fileExistsAtPath:fName];
}



- (NSData*)contentOfFile:(NSString *)fName
{
	fName = [dataPath stringByAppendingPathComponent:fName];
	return [NSData dataWithContentsOfFile:fName];
}







@end
