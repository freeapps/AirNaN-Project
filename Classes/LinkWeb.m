//
//  LinkWeb.m
//  AIRNAN
//
//  Created by class11_user on 13/03/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import "LinkWeb.h"
#import "Reachability.h"

@implementation LinkWeb
@synthesize linkpage, link, BackBtn;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	    t=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loading) userInfo:nil repeats:YES];
}

-(void)loading{
    if(!linkpage.loading)
        [activity stopAnimating];
    else [activity startAnimating];
}


- (id) initWithLink:(NSString *)linkStr{
    
    self = [super init];
    if(self){
        self.link = linkStr;
    }
    return self; 
}

-(void) viewWillAppear:(BOOL)animated
{	
	// check for internet connection
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
	
	internetReachable = [[Reachability reachabilityForInternetConnection] retain];
	[internetReachable startNotifier];
	
	// check if a pathway to a random host exists
	hostReachable = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	[hostReachable startNotifier];
	
	// now patiently wait for the notification
	
	
	int i=[link intValue];
	NSURL *url;
	// Here we Are Creating a URL Request out of a new URL and loading it into linkpage which is our IBOutlet assigned to our UIWebView.
	switch (i) {
		case 0://FaceBook
			url = [[[NSURL alloc] initWithString: @"http://m.facebook.com/pages/AirNaN/89381350968"] autorelease];
			break;
		case 1://SoundCloud
			url = [[[NSURL alloc] initWithString:  @"http://www.soundcloud.com/airnan"] autorelease];
			break;
		case 2://disk
			url = [[[NSURL alloc] initWithString: @"http://www.psyshop.com/shop/CDs/fan/fan1cd005.html"] autorelease];
			break;
		case 3://YouTUbe
			url = [[[NSURL alloc] initWithString: @"http://www.youtube.com/freeanceworld"] autorelease];
			break;
		case 4://Reverbnation
			url = [[[NSURL alloc] initWithString: @"http://www.reverbnation.com/freeance"] autorelease];
			break;
		case 5://Myspace
			url = [[[NSURL alloc] initWithString: @"http://www.myspace.com/freeance"] autorelease];
			break;
		case 6://twitter
			url = [[[NSURL alloc] initWithString: @"http://www.twitter.com/freeance"] autorelease];
			break;
		case 7://Summer Vibes @ CDBaby
			url = [[[NSURL alloc] initWithString: @"http://www.cdbaby.com/cd/freeancerecords"] autorelease];
            break;
		case 8://Making Progress @ CDBaby
			url = [[[NSURL alloc] initWithString: @"http://www.cdbaby.com/cd/airnan"] autorelease];
            break;
		default:
            url = [[[NSURL alloc] initWithString: @""] autorelease];
			break;
	}
	NSURLRequest *request =[NSURLRequest requestWithURL:url];
	linkpage.scalesPageToFit = YES;
    linkpage.autoresizesSubviews = YES;
	linkpage.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	[linkpage loadRequest:request];	
    
}


- (void) checkNetworkStatus:(NSNotification *)notice
{ 
	// called after network status changes
	
	NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
	NetworkStatus remoteHostStatus = [hostReachable currentReachabilityStatus];
	if(internetStatus == NotReachable && remoteHostStatus == NotReachable)
		
	{UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection!"
													 message:@"Please Connect to the Internet..." delegate:nil 
										   cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show]; 
		[alert release]; 
    }
}

- (void) viewWillDisappear:(BOOL)animated{	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction) Back{
    
    [self dismissModalViewControllerAnimated:YES];
    
}




#pragma mark UIWebView delegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	// starting the load, show the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [link release];
    [linkpage release];
    [super dealloc];
}


@end