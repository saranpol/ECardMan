//
//  ScrollViewPass.m
//  ECardMan
//
//  Created by MacBook Pro on 11/6/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "ScrollViewPass.h"

@implementation ScrollViewPass

@synthesize mScrollView;


- (void)dealloc {
	[mScrollView release];
	
    [super dealloc];
}

- (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
	if ([self pointInside:point withEvent:event]) {
		return mScrollView;
	}
	return nil;
}

@end
