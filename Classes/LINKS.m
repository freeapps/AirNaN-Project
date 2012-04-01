//
//  LINKS.m
//  AIRNAN
//
//  Created by class10_user on 2/25/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import "LINKS.h"

@implementation LINKS

@synthesize listView, subscriptions, linkView, myWeb, webView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    // Initializing Background:
    
	UIImageView *bkg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    
 	// Initializing the Link List:
    
    listView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	listView.delegate = self;
	listView.dataSource = self;
	listView.backgroundView=bkg;
	listView.autoresizesSubviews = YES;
    
    //Assigning the Link Subscriptions:
    
	subscriptions = [[NSArray alloc] initWithObjects:@"FaceBook", @"SoundCloud", @"Breathe In CD", @"YouTube", @"ReverbNation", @"MySpace", @"Twitter",@"Summer Vibes",@"Making Progress", nil];
	
	self.navigationItem.title = @"Links";
	self.view = listView;
    
    webView = [[UIWebView alloc] init];
    
	[bkg release];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *MyIdentifier = @"MyIdentifier";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    cell.textLabel.text = [subscriptions objectAtIndex:indexPath.row];
    UIImage *image0 = [UIImage imageNamed:@"facebook-logo.png"] ;
    UIImage *image1 = [UIImage imageNamed:@"soundcloud_logoNew.png"] ;
	UIImage *image2 = [UIImage imageNamed:@"Breath-in-Icon.png"] ;
	UIImage *image3 = [UIImage imageNamed:@"youtube-logo.png"] ;
	UIImage *image4 = [UIImage imageNamed:@"revnation-logo.png"] ;
	UIImage *image5 = [UIImage imageNamed:@"myspace-logo.png"] ;
	UIImage *image6 = [UIImage imageNamed:@"twitter_icon.png"] ;
	UIImage *image7 = [UIImage imageNamed:@"summervibes_Icon.png"] ;
    UIImage *image8 = [UIImage imageNamed:@"Making_Progress_Logo.png"] ;
    
	switch (indexPath.row) {
		case 0:
			cell.imageView.image = image0;
			break;
		case 1:
			cell.imageView.image = image1;
			break;
		case 2:
			cell.imageView.image = image2;
			break;
		case 3:
			cell.imageView.image = image3;
			break;
		case 4:
			cell.imageView.image = image4;
			break;
		case 5:
			cell.imageView.image = image5;
			break;
        case 6:
			cell.imageView.image = image6;
			break;
        case 7:
			cell.imageView.image = image7;
			break;
        case 8:
			cell.imageView.image = image8;
			break;
		default:
			break;
	}
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [subscriptions count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // We Initialize the Link with the Row and Activate the LinkView Controller and then present it.
    NSString *link = [NSString stringWithFormat:@"%d", indexPath.row];
   	LinkWeb *fvController = [[LinkWeb alloc] initWithNibName:@"LinkWeb" bundle:[NSBundle mainBundle]];
	fvController.link = link;
    [self presentModalViewController: fvController animated:YES];
    [fvController release];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [self.view removeFromSuperview];
    
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
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
	[listView release];
	[subscriptions release];
	[super dealloc];
}

@end
