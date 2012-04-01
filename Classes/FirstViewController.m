//
//  FirstViewController.m
//  AIRNAN
//
//  Created by class10_user on 2/25/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import "FirstViewController.h"

#define MemoryWarningsLevel1 2

@implementation FirstViewController

@synthesize AirnanBox, beatTimer, splashView, bufferDivision;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
    
    
-(void)viewDidDisappear:(BOOL)animated{

    if(AirnanBox){
        [AirnanBox stopPlay];
    }
        [self turnLightsOff];
 //       AirnanBox = nil;
}

-(void)viewDidAppear:(BOOL)animated
{
    bufferDivision = 4;
    warningsReceived = 0;
    beatTimer = [NSTimer scheduledTimerWithTimeInterval: 0.230 target: self selector:@selector(buttonLights) userInfo: nil repeats: YES]; 
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
     AirnanBox = [[BeatBox alloc] init];
	
}


-(void)buttonLights{
    if(AirnanBox){ 
    if([AirnanBox isPlaying]){
  //  if(StopPlay.selected) StopPlay.highlighted = !StopPlay.highlighted;
    if(b16.selected) b16.highlighted = !b16.highlighted;
    if(b1.selected) b1.highlighted = !b1.highlighted;
    if(b2.selected) b2.highlighted = !b2.highlighted;
    if(b3.selected) b3.highlighted = !b3.highlighted;
    if(b4.selected) b4.highlighted = !b4.highlighted;
    if(b5.selected) b5.highlighted = !b5.highlighted;
    if(b6.selected) b6.highlighted = !b6.highlighted;
    if(b7.selected) b7.highlighted = !b7.highlighted;
    if(b8.selected) b8.highlighted = !b8.highlighted;
    if(b9.selected) b9.highlighted = !b9.highlighted;
    if(b10.selected) b10.highlighted = !b10.highlighted;
    if(b11.selected) b11.highlighted = !b11.highlighted;
    if(b12.selected) b12.highlighted = !b12.highlighted;
    if(b13.selected) b13.highlighted = !b13.highlighted;
    if(b14.selected) b14.highlighted = !b14.highlighted;
    if(b15.selected) b15.highlighted = !b15.highlighted;

        }
    }
    
}

-(void)turnLightsOff{

    StopPlay.selected = StopPlay.highlighted = NO;
    
    b1.selected = b1.highlighted = NO;
    b2.selected = b2.highlighted = NO;
    b3.selected = b3.highlighted = NO;
    b4.selected = b4.highlighted = NO;
    b5.selected = b5.highlighted = NO;
    b6.selected = b6.highlighted = NO;
    b7.selected = b7.highlighted = NO;
    b8.selected = b8.highlighted = NO;
    b9.selected = b9.highlighted = NO;
    b10.selected = b10.highlighted = NO;
    b11.selected = b11.highlighted = NO;
    b12.selected = b12.highlighted = NO;
    b13.selected = b13.highlighted = NO;
    b14.selected = b14.highlighted = NO;
    b15.selected = b15.highlighted = NO;
    b16.selected = b16.highlighted = NO;
    
}

- (IBAction)PressedButton:(id)sender{
       if(AirnanBox){ 
    if(![AirnanBox isPlaying]){
        [StopPlay setSelected:YES];
    }
    
	[AirnanBox ToggleSound:[sender tag] -1];
           
    }
    
	UIButton *btn = (UIButton*) sender;    
    
    if(!btn.selected){
        [btn setSelected:YES];
    }else{
        [btn setSelected:NO];
    }
    
}
/*
- (IBAction) VolumeChanged:(UISlider *)sender{
    
    if(AirnanBox){

    if([AirnanBox isPlaying]){
    
     [AirnanBox setOutputGain: (AudioUnitParameterValue)mixerOutputLevelFader.value];
    }
        
    }
    
}
*/
- (IBAction)reset{
    
    if(AirnanBox){
        [AirnanBox stopPlay];
        [self turnLightsOff];
    }
    
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

-(void)viewWillAppear:(BOOL)animated{


}

- (void)didReceiveMemoryWarning {
    
    
    // Before we Call The SUPER Warning method, we'll deallocae used mamoery for the BeatBox:
    
    warningsReceived++;
    
    NSLog(@"Memory WARNING Number: %d", warningsReceived);
    
    if(warningsReceived > MemoryWarningsLevel1){
        if(AirnanBox){
            [AirnanBox release];
            AirnanBox = nil;
        }
        // Well, We Did Our Best, if we Can't Even Load 2 beats, then We Will Not Play the Beat Box;    
        //Optional Warning to the User:
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"BeatBox Unavailable" 
                              message:@"Your device needs more memory to play the BeatBox sounds..." 
                              delegate:nil 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];	
        
        warningsReceived = 0;
    }
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {

    
}


- (void)dealloc {

    AirnanBox = nil;
    [super dealloc];
}

@end
