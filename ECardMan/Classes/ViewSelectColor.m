//
//  ViewSelectColor.m
//  ECardMan
//
//  Created by MacBook Pro on 11/6/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "ViewSelectColor.h"
#import "ECardManAppDelegate.h"
#import "ECardManViewController.h"

@implementation ViewSelectColor

@synthesize mScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



#define OBJ_WIDTH 120
#define OBJ_WIDTH_HALF 500
- (void)setZoomView {
	CGFloat offset = mScrollView.contentOffset.x;
    
    // save position
    [ECardManAppDelegate core]->viewController->mCurrentColorIndex = (int)(offset/OBJ_WIDTH);
    //printf("ssss %d\n", [ECardManAppDelegate core]->viewController->mCurrentColorIndex);
    
	UIView *view = nil;
	NSArray *subviews = [mScrollView subviews];
	int index = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIView class]] && view.tag > 0)
		{
            index++;
			float far = fabs(offset - OBJ_WIDTH*(index-1));
			float scale = 0.7f;
			if(far <= OBJ_WIDTH_HALF)
				scale = (OBJ_WIDTH_HALF - far)/OBJ_WIDTH_HALF;
			if(scale < 0.7f)
				scale = 0.7f;
			CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
			view.transform = transform; 
            
            for(UIView *l in [view subviews]){
                if(l.tag == 2){
                    float a = scale;
                    if(a < 0.9f)
                        a = 0;
                    else{
                        a = (a-0.9f)/0.1f;
                    }
                        
                    [l setAlpha:a];
                }
            }
		}
	}
}


- (void)addLip:(NSString*)name x:(int)x num:(NSString*)num text:(NSString*)text {
    
    UIView *v = [[[UIView alloc] initWithFrame:CGRectMake(x, 0, OBJ_WIDTH, 600)] autorelease];
    
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setFrame:CGRectMake(0, 0, OBJ_WIDTH, 427)];
    [b setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [v addSubview:b];
    
    UILabel *l = [[[UILabel alloc] init] autorelease];
    [l setFrame:CGRectMake(0, 430, OBJ_WIDTH, 60)];
    [l setText:num];
    [l setFont:[UIFont fontWithName:@"Optima" size:(40.0)]];
    [l setTextAlignment:UITextAlignmentCenter];
    [l setBackgroundColor:[UIColor clearColor]];
    [l setTextColor:[UIColor whiteColor]];
    [v addSubview:l];
    
    
    l = [[[UILabel alloc] init] autorelease];
    [l setFrame:CGRectMake(-100, 470, OBJ_WIDTH+200, 60)];
    [l setText:text];
    [l setFont:[UIFont fontWithName:@"Optima" size:(32.0)]];
    [l setTextAlignment:UITextAlignmentCenter];
    [l setBackgroundColor:[UIColor clearColor]];
    [l setTextColor:[UIColor whiteColor]];
    [l setTag:2];
    [v addSubview:l];
    
    [v setTag:1];
    [mScrollView addSubview:v];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    int x = 0;
    int w = OBJ_WIDTH;
    [self addLip:@"lip_01.png" x:x num:@"01" text:@"NUDE AFFAIR"]; x+=w;
    [self addLip:@"lip_03.png" x:x num:@"03" text:@"SENSUOUS NUDE"]; x+=w;
    [self addLip:@"lip_05.png" x:x num:@"05" text:@"ENTICING FUCHSIA"]; x+=w;
    [self addLip:@"lip_07.png" x:x num:@"07" text:@"BLOSSOM TEASE"]; x+=w;
    [self addLip:@"lip_08.png" x:x num:@"08" text:@"PINK SEDUCTION"]; x+=w;
    [self addLip:@"lip_09.png" x:x num:@"09" text:@"LAVISH QUARTZ"]; x+=w;
    [self addLip:@"lip_10.png" x:x num:@"10" text:@"ORCHID SURRENDER"]; x+=w;
    [self addLip:@"lip_11.png" x:x num:@"11" text:@"WISTFUL WISTERIA"]; x+=w;
    [self addLip:@"lip_13.png" x:x num:@"13" text:@"PEACH PLEASURE"]; x+=w;
    [self addLip:@"lip_14.png" x:x num:@"14" text:@"CURVACEOUS CORA"]; x+=w;
        
    
    [mScrollView setContentSize:CGSizeMake(w*10, 427)];
    
    [self setZoomView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (void)dealloc {
	[mScrollView release];	
    [super dealloc];
}


- (IBAction)clickNext:(id)sender {
	[self.view removeFromSuperview];
	[[ECardManAppDelegate core]->viewController gotoViewSelectTheme];
    
    [[ECardManAppDelegate core]->viewController->mViewSelectColor release];
    [ECardManAppDelegate core]->viewController->mViewSelectColor = nil;
}

- (IBAction)clickBack:(id)sender {
	[self.view removeFromSuperview];
    [[ECardManAppDelegate core]->viewController gotoViewBeforeAfter];
    
    [[ECardManAppDelegate core]->viewController->mViewSelectColor release];
    [ECardManAppDelegate core]->viewController->mViewSelectColor = nil;
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	[self setZoomView];
}



@end
