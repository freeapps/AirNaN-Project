//
//  MUSIC.m
//  AIRNAN
//
//  Created by class10_user on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUSIC.h"
#import "Reachability.h"

@implementation MUSIC

@synthesize play, PlayingTrack, buylink;
@synthesize niddle,vinyle,player,angle,timer, playTimer, btRewind, btPlay, btForward, btMore, center,direction, needleCover, trackName, isScratching,discContainer, playerLevelFader, downloadTrackIndex, isDownloading;

@synthesize responseData;

@synthesize TextTimer,MyScreen;

#pragma NIB Functions:

- (void)viewDidLoad {
    [super viewDidLoad];
    
    player = nil;
    isDownloading = false;
    
    // for the rotating Text:
        
    chooseMusic.minimumFontSize=17;
    MyScreen=[UIScreen mainScreen];
    
    // for the Srathcing:
    isScratching = NO;
    direction=0;
    [[self vinyle] setUserInteractionEnabled:YES];
    [[self center] setUserInteractionEnabled:YES];
    KTOneFingerRotationGestureRecognizer *rotation;
    rotation = [[KTOneFingerRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotating:)];
    [[self center] addGestureRecognizer:rotation];
    [rotation release];
    
}

- (void)viewDidAppear:(BOOL)animated{
    // The PLayer itself:
    if(!player)
    {
    player=[[musicPlayer alloc]initWithList];
    if(player){
        chooseMusic.text=[player GetTrack];
    }
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    if(self.tabBarController.selectedIndex == 0)
    {
        if([player.Aplayer isPlaying])
        {
            [self playPause:0];
        }
            [player.Aplayer release];
            [player release];
            player = nil;
    }
}

#pragma Player Interaction:

-(IBAction)upTrack{
    chooseMusic.text=[player GetTrackUp];
    if([player.Aplayer isPlaying]){
        [player playTrack:[player currentTrack]];
    }
 }

-(IBAction)downTrack{
    chooseMusic.text=[player GetTrackDown];
    if([player.Aplayer isPlaying]){
        [player playTrack:[player currentTrack]];
    }
}

-(void)handleTimer:(NSTimer *)timer
{
 
    if(!isScratching){ 
	if(angle==-1){//to make the rotation stop
		return;
	}
	angle += 0.01;
	if (angle > 6.283) { 
		angle = 0;
	}
	
	CGAffineTransform transform=CGAffineTransformMakeRotation(angle);	
	center.transform = transform;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:15];
	if(direction==0){
		CGAffineTransform vinynle_transform=CGAffineTransformMakeRotation(0.05);
		vinyle.transform=vinynle_transform;
		direction=1;	
	}
	else{
		CGAffineTransform vinynle_transform=CGAffineTransformMakeRotation(0);
		vinyle.transform=vinynle_transform;
		direction=0;	
	}					
	[UIView commitAnimations];
	}
	
}

// Handling the End of Track Event:

-(void) handleEndofTrack:(NSTimer *)trackTimer{

    if(play){
        [self playPause:0];

    }

}   

- (void) playPause:(id)sender{

    isScratching = NO;
    if(!play){
        if(![player playTrack:player.currentTrack]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The selected Track is Not Available"
                                                            message:@"Please Select a Track that is Available in the App..." delegate:nil 
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show]; 
            [alert release]; 

        }else{
        [btPlay setSelected:YES];
        [self setTrackNameText:[player GetTrackName]];
        play = YES;
        [self rotateVinyle];
        [self moveNiddle:(16/([player.tracks count])*(player.currentTrack+1))];
        TextTimer = [NSTimer scheduledTimerWithTimeInterval: 0.005 target: self selector:@selector(MoveText) userInfo: nil repeats: YES];

        }
    }else{
        [player playerStop];
        [btPlay setSelected:NO];
        play = NO;
        [self moveNiddle:(0)];
        [timer invalidate];
        timer=nil;
        [playTimer invalidate];
        playTimer = nil;
        [TextTimer invalidate];
        TextTimer=nil;
        [self setTrackNameText:@""];
    }
}
/*
-(void)stop{
    
    if(play){
        [player playerStop];
        [btPlay setSelected:NO];
        play = NO;
        [self moveNiddle:(0)];
        [timer invalidate];
        timer=nil;
        [playTimer invalidate];
        playTimer = nil;
        [TextTimer invalidate];
        TextTimer=nil;
        [self setTrackNameText:@""];
    }
    
    
}
*/
- (IBAction) VolumeChanged:(UISlider *)sender{
    
    if(play){
        
        [player.Aplayer setVolume:playerLevelFader.value];
        
    }
    
}

#pragma MORE TableView

- (void) More{
    btMore.enabled = NO;
    listMusic=[[UITableView alloc]initWithFrame:CGRectMake(20, 50, 300, 300)];
    listMusic.delegate = self;
	listMusic.dataSource = self;
    
    listMusic.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BoardTlist-1.png"]];
    CGPoint cent = [self.view center];
    cent.y += 20;
    listMusic.center = cent;

    listMusic.layer.cornerRadius=10;
    [listMusic.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [listMusic.layer setBorderWidth:2.0];
	[self.view addSubview: listMusic];
    
    close = [UIButton buttonWithType:UIButtonTypeCustom]; 	
    close.frame = CGRectMake(283, 78, 25, 25); 
	[close setImage:[UIImage imageNamed:@"CloseB4.png"]  forState:UIControlStateNormal];
    [close setImage:[UIImage imageNamed:@"CloseB3.png"]  forState:UIControlStateHighlighted];
    close.backgroundColor=[UIColor clearColor];  
    //close.layer.cornerRadius = 30;
    [close addTarget:self action:@selector(closeTable) forControlEvents: UIControlEventTouchUpInside];
    // close.imageView.image=[UIImage imageNamed:@"icone_delete.png"];
    [self.view addSubview:close ];
    [self.view insertSubview:close aboveSubview: listMusic];
}

-(void)closeTable{
    if(!isDownloading){
    close.enabled = true;
    btMore.enabled = YES;
    [listMusic removeFromSuperview];
    [close removeFromSuperview];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *MyIdentifier = @"MyIdentifier";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    
    // Setting the Texts:
    
    int trackIndex = 0;
    if(indexPath.section == 0){
        trackIndex = indexPath.row;
    }else if (indexPath.section == 1){
        trackIndex = ([player tracksForSection:0] + indexPath.row); 
    }else if(indexPath.section == 2){
        trackIndex = ([player tracksForSection:0] + [player tracksForSection:1] + indexPath.row);
    }
    Track* myTr = [player.tracks objectAtIndex:trackIndex];
   // NSLog(@"%@", myTr);
    if (myTr){
    cell.textLabel.text = myTr.trackName;
    cell.userInteractionEnabled=YES;
    cell.textLabel.font=[UIFont fontWithName:@"arial" size:14];
    }
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(player){
    return [player tracksForSection:section];
    }else{
        return 0;
    }
}  

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0){
        return @"Music in APP";
    }else if(section == 1)
        return @"Free Downloads";
    else{
        return @"Buy Now";
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(!isDownloading){
    // Calculate Index in tracks:
    int trackIndex = 0;
    if(indexPath.section == 0){
        trackIndex = indexPath.row;
    }else if (indexPath.section == 1){
        trackIndex = ([player tracksForSection:0] + indexPath.row); 
    }else if(indexPath.section == 2){
        trackIndex = ([player tracksForSection:0] + [player tracksForSection:1] + indexPath.row);
    }
    
    if (indexPath.section >0){
    
        // check for internet connection
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
        
        internetReachable = [[Reachability reachabilityForInternetConnection] retain];
        [internetReachable startNotifier];
        
        // check if a pathway to a random host exists
        hostReachable = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
        [hostReachable startNotifier];
        // now patiently wait for the notification
        
    } 

    
    switch (indexPath.section) {
		case 0:
            player.currentTrack = trackIndex;
            [self playPause:nil];
            if(![player.Aplayer isPlaying]){
                [self playPause:nil];
            }
            [self closeTable];
			break;
		case 1:
            [self DownloadAlert:trackIndex];
			break;
		case 2: 
            [self buyTrack:trackIndex];
            break;
        default:
			break;
	}
    }
    
}

#pragma mark - alert
// Warning the User About the Download!
- (void) alertView:(UIAlertView *)_actionSheet clickedButtonAtIndex:(NSInteger)_buttonIndex {
    if ([_actionSheet.title isEqualToString:@"Music Download"])
    {
        if (_buttonIndex == 0) //If the User Pressed OK We Update the Downloading Boolean.
        {
            [self download:downloadTrackIndex];
        } 
        
    }
}

#pragma mark - Downloading & Saving

- (void) DownloadAlert:(int) track{

    downloadTrackIndex = track;
    
    NSString* trackN = @"";
    Track* trackD = [player.tracks objectAtIndex:track];
    if(trackD){
        trackN = [NSString stringWithString:trackD.trackName];
    }
    NSString* Msg = [NSString stringWithFormat:@"You are About to Download: '%@'!", trackN];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Music Download" message:Msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    [alert show]; 
    [alert release]; 

}


- (BOOL)download:(int) track{
    
    isDownloading = true;
    close.enabled = false;
    
    progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(60, 364, 200, 20)];
    progressView.progress = 0;
    progressView.progressViewStyle=UIProgressViewStyleBar;
    [self.view addSubview:progressView];
    Track* trackLink = [player.tracks objectAtIndex:track];
    NSString *musicStr=[trackLink.trackLink stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: musicStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval: 30.0];
    // Create the connection and send the request
    NSURLConnection *connection =[NSURLConnection connectionWithRequest:request delegate:self];
    // Make sure that the connection is good ]
    if (connection) {
        // Instantiate the responseData data structure to store to response 
        self.responseData = [NSMutableData data]; 
    } else {
      //  NSLog (@"The connection failed");
        [progressView removeFromSuperview];
        return false;
    } 
    
    // The Download Suceeded:
        
        return true;
        
}

- (BOOL)buyTrack:(int) track{

    // Soon to Implement: InApp Purchases:
    
    /*            [listMusic removeFromSuperview];
     [close removeFromSuperview];
     buylink = [[UIWebView alloc] initWithFrame:self.view.bounds];
     NSURL *url = [[[NSURL alloc] initWithString: @"http://itunes.apple.com/gb/artist/airnan/id310628478"] autorelease];  
     NSURLRequest *request =[NSURLRequest requestWithURL:url];
     buylink.scalesPageToFit = YES;
     buylink.autoresizesSubviews = YES;
     buylink.autoresizingMask = (UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight);
     
     [buylink loadRequest:request];	
     [self.view addSubview:buylink];
     */
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming Soon..." message:@"Tracks for sale Available Soon!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show]; 
    [alert release]; 
    
    return false;
    
}

- (void)SaveData:(NSData *)data{
    
    //1) Create the full file path by appending the desired file name
    
    Track* mpTrack = [player.tracks objectAtIndex:downloadTrackIndex];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName=[NSString stringWithFormat:@"%@.mp3", mpTrack.trackFile];
    
    NSString *fullFileName = [documentsDirectory stringByAppendingPathComponent:fileName];

    [data writeToFile:fullFileName atomically:YES];
    
}

#pragma mark - URL connection

- (void) checkNetworkStatus:(NSNotification *)notice
{ 
	// called after network status changes
	
	NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
	NetworkStatus remoteHostStatus = [hostReachable currentReachabilityStatus];
	if(internetStatus == NotReachable && remoteHostStatus == NotReachable){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection!"
													 message:@"Please Connect to the Internet..." delegate:nil 
										   cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show]; 
		[alert release]; 
        
    }
    
}

#pragma mark - NSURL Request Delegate

// Called when a redirect will cause the URL of the request to change 
- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    return request;
}


// Called when the connection has enough data to create an NSURLResponse 
- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response 
{
    [self.responseData setLength:0];
    filesize = [[NSNumber numberWithLong: [response expectedContentLength] ] retain];
}

// Called each time the connection receives a chunk of data 
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the received data to our responseData property 
    [self.responseData appendData:data];
    NSNumber* curLength = [NSNumber numberWithLong:[responseData length] ];
    float progress = [curLength floatValue] / [filesize floatValue] ;
    progressView.progress = progress;
}

// Called when the connection has successfully received the complete response 
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    // Convert the data to a string and log the response string 
    [self SaveData:self.responseData];    
     progressView.progress =1;
    [progressView removeFromSuperview];
    // Updating Our Status:
    isDownloading = false;
    close.enabled = true;
    // Remove the List:
    [self closeTable];
    // Save and Play the Downloaded Track:
    if(self.responseData){ 
    //2) For the trackList:
        if([player SaveDownloaded:downloadTrackIndex]){
            [self playPause:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Download Failed..." message:@"The Track was not Found, please Try Again Later!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show]; 
            [alert release]; 
         }
    }
    self.responseData = nil;
}

// Called when an error occurs in loading the response 
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
   // NSLog (@"connection:didFailWithError:");
   // NSLog (@"%@",[error localizedDescription]);
        isDownloading = false;
        close.enabled = true;
    
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error connection" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
    [errorAlert release];
    [progressView removeFromSuperview];
    
}



#pragma mark - Vynil Rotation

//activate the timer that call handletimer every interval
-(void)rotateVinyle{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:15];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	if (timer != nil) {
		
		[timer invalidate];
        timer = nil;
		
	}	
    if (playTimer != nil) {
		
		[playTimer invalidate];
        playTimer = nil;
		
	}
	timer = [NSTimer scheduledTimerWithTimeInterval: 0.0001 target: self selector:@selector(handleTimer:) userInfo: nil repeats: YES];
    playTimer = [NSTimer scheduledTimerWithTimeInterval: player.Aplayer.duration target: self selector:@selector(handleEndofTrack:) userInfo: nil repeats: NO];
	angle=0;//so the rotation will start again if we press again
	[UIView commitAnimations];
	
}

//rotating the niddle acording to the given angle
-(void)moveNiddle:(float)rotation_angle{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2];
	CGAffineTransform cgCTM=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(rotation_angle));
    needleCover.transform=cgCTM;
	[UIView commitAnimations];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

//rotating the center and moving the vinyle

- (void)rotating:(KTOneFingerRotationGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){
        isScratching = NO;
    }else{
        isScratching = YES;
        UIView *view = [recognizer view];
        [view setTransform:CGAffineTransformRotate([view transform], [recognizer rotation])];
   
            if([recognizer rotation] > 0){
                
              //  [player fastFww];
                
            }else{
                
             //   [player fastRew];
            }
    }
    
}

#pragma mark - Rotating Text

-(void)setTrackNameText:(NSString*)strtrackName{
    [trackName setTextColor:[UIColor whiteColor]];
    [trackName setText:strtrackName];
    
}

-(void)MoveText{
    
    CGRect rect=chooseMusic.frame;
    rect.origin.x--;
    chooseMusic.frame=rect;
    if(chooseMusic.frame.origin.x<0-MyScreen.bounds.size.width){
        rect.origin.x=MyScreen.bounds.size.width;
        chooseMusic.frame=rect;
    }
    
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    
    [player release];
    [super viewDidUnload];

}


- (void)dealloc {
    
	[player.Aplayer release];
	[player release];
    [super dealloc];
    
}

@end
