//
//  BeatBox.h
//  AIRNAN
//
//  Created by class10_user on 3/17/11.
//  Copyright 2011 FreeApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioPlayer.h>

#import <AudioToolbox/AudioToolbox.h>

@class MixerHostAudio;

#define MAXBUFS  16
#define NUMFILES 16

@interface BeatBox : NSObject {
	
    bool isPlaying;
    
    // New Implemented MixerHost
    MixerHostAudio  *audioObject;
    		
}

@property (nonatomic, retain)    MixerHostAudio              *audioObject;

@property bool isPlaying;

- (id)init;

- (void)setOutputGain:(AudioUnitParameterValue) newGain;

-(void)ToggleSound:(int)soundIndex;
-(void)stopPlay;

// For the Buffer Division:

- (id) initWithBufferParts: (int) bParts;

@end
