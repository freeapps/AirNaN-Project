//
//  musicPlayer.h
//  AIRNAN
//
//  Created by class10_user on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVFoundation/AVFoundation.h>
#import<AVFoundation/AVAudioPlayer.h>
#import "Track.h"

#define TRACKLISTFILE @"AirnanTrackList"

@interface musicPlayer : UITableViewCell {
	
    AVAudioPlayer* Aplayer;
	
    NSMutableArray* tracks;
    
    int currentTrack;
    
    int FreeTrack;
    
    int BuyTrack;
    
}

@property (nonatomic,retain) AVAudioPlayer* Aplayer;
@property (nonatomic,retain) NSMutableArray* tracks;
@property int currentTrack;
@property int FreeTrack;
@property int BuyTrack;

- (id)initWithList;

- (bool)playTrack:(int)trackIndex;

- (void)playerStop;         

- (void)fastFww;

- (void)fastRew;

- (bool)addTrackToLibrary:(int) track;

// We'll have to Sort the tracks after downloading or Buying:

- (bool) SaveDownloaded:(int) track;

- (NSString*) GetTrackName;

- (NSString*) GetTrackDown;
- (NSString*) GetTrackUp;
- (NSString*) GetTrack;

// to Know how many Tracks are in each Section:
- (int)tracksForSection:(int) section;

@end
