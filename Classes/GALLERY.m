//
//  GALLERY.m
//  AIRNAN
//
//  Created by class10_user on 2/26/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import "GALLERY.h"
#pragma mark -
#define IMAGE_WIDTH   320
#define IMAGE_HEIGHT  416

//#define degreesToRadian(x) (M_PI * (x) / 180.0)

@implementation GALLERY
#pragma mark -

- (void)viewDidLoad {
    
	[super viewDidLoad];

}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated{

    //aScrollView = [[UIScrollView alloc] init];
    NSArray *photos=[NSArray arrayWithObjects: @"AirNaN_Bkg1_lo.png", @"AirNaN_A1_Title_lo.png", @"AirNaN_Face_lo.png", @"AirNaN_DJ1_lo.png", @"AirNaN_A22_lo.png", @"BreatheIn_CD_lo.png", nil];    
	// note that the view contains a UIScrollView in aScrollView
	int i=0;
	for ( NSString *image in photos )
	{
		UIImage *image = [UIImage imageNamed:[photos objectAtIndex:i]];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		imageView.contentMode = UIViewContentModeScaleAspectFit; 
        imageView.clipsToBounds = YES;
		imageView.frame = CGRectMake( IMAGE_WIDTH * i++, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
        [aScrollView addSubview:imageView];
		[imageView release];
	} 
	aScrollView.contentSize = CGSizeMake(IMAGE_WIDTH*i, IMAGE_HEIGHT);
    aScrollView.pagingEnabled = YES;
	aScrollView.delegate = self;
	
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    aScrollView.contentOffset = CGPointMake(0, 0);  

}

- (void)viewDidDisappear:(BOOL)animated{


}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {

    [super dealloc];
}

@end
