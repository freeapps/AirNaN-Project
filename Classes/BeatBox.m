//
//  BeatBox.m
//  AIRNAN
//
//  Created by class10_user on 3/17/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import "BeatBox.h"
#import "MixerHostAudio.h"

@implementation BeatBox

@synthesize isPlaying;

@synthesize audioObject;

const Float64 kGraphSampleRate = 44100.0;

NSString *MixerHostAudioObjectPlaybackStateDidChangeNotification = @"MixerHostAudioObjectPlaybackStateDidChangeNotification";

- (id) init{
    self=[super init];
	if (self){
        
        MixerHostAudio *newAudioObject = [[MixerHostAudio alloc] init];
        self.audioObject = newAudioObject;
        [newAudioObject release];
        // MixerAudioHost Initialize:
        // Initialize mixer settings to UI
        for(int i=0; i<NUM_FILES; i++){
        [audioObject enableMixerInput:i isOn: YES];
        [audioObject setMixerInput:i gain: 0];
        }
        [audioObject setMixerOutputGain: 0.9];
            
    }
	return self;
}

- (id) initWithBufferParts:(int)bParts{

    self=[super init];
	if (self){
        
        MixerHostAudio *newAudioObject = [[MixerHostAudio alloc] initWithBufferParts:bParts];
        self.audioObject = newAudioObject;
        [newAudioObject release];
        
        // MixerAudioHost Initialize:
        // Initialize mixer settings to UI
        for(int i=0; i<NUM_FILES; i++){
            [audioObject enableMixerInput:i isOn: YES];
            [audioObject setMixerInput:i gain: 0];
        }
        [audioObject setMixerOutputGain: 0.9];
        
    }
	return self;

}

-(void)ToggleSound:(int)soundIndex{
    
    if(!isPlaying){   
        // Initializing AUGraph for Playback:
           [audioObject startAUGraph];
           [audioObject setMixerInput:soundIndex gain: 1];
            isPlaying = YES;
        
	}else{
        // Toggling Sound (Volume Switch):
        Float32 fVolume = [audioObject getMixertInoutGain:soundIndex];
        if(fVolume == 1){
            [audioObject setMixerInput:soundIndex gain: 0];
        }
        else{
            [audioObject setMixerInput:soundIndex gain: 1];
        }
	
    }

}

- (void)setOutputGain:(AudioUnitParameterValue) newGain{

    [audioObject setMixerOutputGain:newGain];
    
}

-(void)stopPlay{

    if(isPlaying){
        for(int i=0; i<NUMFILES; i++){
            [audioObject setMixerInput:i gain: 0];
        }
        [audioObject stopAUGraph];
        isPlaying = NO;
    }
    
}


- (void)dealloc {
    
    [self.audioObject release];
    self.audioObject = nil;
    [super dealloc];
    
}


@end
