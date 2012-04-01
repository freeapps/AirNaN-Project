//
//  FirstViewController.h
//  AIRNAN
//
//  Created by class10_user on 2/25/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeatBox.h"

@interface FirstViewController : UIViewController {
    
	BeatBox *AirnanBox;
	
	IBOutlet UIButton* b1;
	IBOutlet UIButton* b2;
	IBOutlet UIButton* b3;
	IBOutlet UIButton* b4;
	IBOutlet UIButton* b5;
	IBOutlet UIButton* b6;
	IBOutlet UIButton* b7;
	IBOutlet UIButton* b8;
	IBOutlet UIButton* b9;
	IBOutlet UIButton* b10;
	IBOutlet UIButton* b11;
	IBOutlet UIButton* b12;
	IBOutlet UIButton* b13;
	IBOutlet UIButton* b14;
	IBOutlet UIButton* b15;
	IBOutlet UIButton* b16;
    
    IBOutlet UIButton* StopPlay;
    
  //  IBOutlet UISlider *mixerOutputLevelFader;
    
    NSTimer *beatTimer;
    
    UIImageView *activityImageView;
    
    int bufferDivision;
	
    int warningsReceived;
    
}

@property int bufferDivision;

@property (nonatomic, retain) BeatBox *AirnanBox;
@property(nonatomic,retain)NSTimer *beatTimer;
@property (nonatomic, retain) UIViewController* splashView;

//@property (nonatomic, retain)    IBOutlet UISlider *mixerOutputLevelFader;

//- (IBAction) VolumeChanged:(UISlider *)sender;

- (IBAction)PressedButton:(id)sender;
- (IBAction)reset;
- (void)buttonLights;
- (void)turnLightsOff;

@end
