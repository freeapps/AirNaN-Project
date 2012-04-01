//
//  musicPlayer.m
//  AIRNAN
//
//  Created by Hernan Arber on 3/15/11.
//  Copyright 2011 FreeAppsTeam All rights reserved.
//

#import "musicPlayer.h"


@implementation musicPlayer

@synthesize Aplayer,tracks, currentTrack, FreeTrack, BuyTrack;

-(id)initWithList{
    
    self = [super init];
    
    if(self){
        
        currentTrack = 0;
        
        FreeTrack = 0;
        
        BuyTrack = 0;
        
        tracks = [[NSMutableArray alloc] init];    
        
        NSString* fullTrackListFile = [TRACKLISTFILE stringByAppendingString:@".txt"];
        
        NSArray* appPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString* docDirectory = [appPath objectAtIndex:0];
        
        NSString* fileName = [docDirectory stringByAppendingPathComponent:fullTrackListFile];
        
        NSFileManager* fileManager = [NSFileManager defaultManager];
        
        NSString* bundlePath = [[NSBundle mainBundle] pathForResource:TRACKLISTFILE ofType:@"txt"];
        
        NSArray* trackRows = nil;
        
        NSString* sRow = nil;
        
        NSError *error = nil;
        
        // Preparing the File:
        if(![fileManager fileExistsAtPath:fileName]){
            if (bundlePath) {
                [fileManager copyItemAtPath:bundlePath toPath:fileName error:nil];
            }
        }
        
        // We Should have the File By now, otherWise, We'll still load the tracks from the default:
        if(![fileManager fileExistsAtPath:fileName]){
            if (bundlePath) {
                sRow  = [NSString stringWithContentsOfFile:bundlePath encoding:NSUTF8StringEncoding error:&error];
            }
        }else{
            sRow = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:&error];
        }
        if (error) {
            // Some error has occurred. Handle it.
            //     NSLog(@"Error has Ocurred=%@",error);
        }
        
        // Reading the Tracks File:
        trackRows = [sRow componentsSeparatedByString:ENDOFLINE];
        
        //NSLog(@"trackRows=%@",trackRows);
        
        if([trackRows count]==0){
            
            // the Parsing of the File Failed:
            
            Track* myTrack = [[Track alloc] initWithRow:@"AirNaN - Electric Voice=APP=AppLibrary=Electric Voice"];
            if(myTrack){
                [tracks addObject:myTrack];
            }  
            
            [myTrack release];
            
        }else{
            
            for(int i = 0; i < [trackRows count]; i++){
                
                Track* myTrack = [[Track alloc] initWithRow:[trackRows objectAtIndex:i]];
                
                if(myTrack){
                    
                    if ([myTrack.trackType isEqualToString:@"FREE"]) {
                        if (FreeTrack == 0){
                            FreeTrack = [tracks count];
                           // NSLog(@"freeTrack=%d",FreeTrack);
                            //NSLog(@"buyTrack=%d",BuyTrack);
                        }
                    }
                    if ([myTrack.trackType isEqualToString:@"BUY"]) {
                        if (BuyTrack == 0){
                            BuyTrack = [tracks count];
                            // NSLog(@"freeTrack=%d",FreeTrack);
                         //   NSLog(@"buyTrack=%d",BuyTrack);
                        }
                    }
                    
                    if (![myTrack.trackLink isEqualToString:@""]){
                        [tracks addObject:myTrack];
                        //  NSLog(@"freeTrack=%d",FreeTrack);
                        //  NSLog(@"buyTrack=%d",BuyTrack);
                    }
                    
                    [myTrack release];
                }                  
                
            }
        }
        if (FreeTrack == 0){
            FreeTrack = 1;
        }
        if (BuyTrack == 0){
            BuyTrack = 1;
        }
        
    }
//    NSLog(@"freeTrack=%d",FreeTrack);
//    NSLog(@"buyTrack=%d",BuyTrack);
    return self;
    
}


- (bool)playTrack:(int)trackIndex{
    
    NSString* trackStr = nil;
    
    if(Aplayer){
        
        if([Aplayer isPlaying]){
            [Aplayer pause];
            //   [Aplayer release];
        }
        
    }
    
    if (trackIndex > 0){
        
        Track* playingTrack = [tracks objectAtIndex:trackIndex];
        
        if([playingTrack.trackType isEqualToString:@"APP"]){
            
            trackStr = [[NSString alloc] initWithString:playingTrack.trackFile];
            
        }else if([playingTrack.trackType isEqualToString:@"FREE"]){
            // Track for Download:
            return false;            
        }else if([playingTrack.trackType isEqualToString:@"BUY"]){
            // Buy Track:
            return false;
        }
        
    }else{
        
        trackStr=[[NSString alloc]initWithString:[[NSBundle mainBundle] pathForResource:@"Electric Voice" ofType:@"mp3"]];
        
    }
    
    NSURL* trackUrl=[[NSURL alloc]initFileURLWithPath:trackStr];
    
    [trackStr release];
    
    Aplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:trackUrl error:nil];
    [Aplayer setVolume:0.8];
    [Aplayer play];
    
    [trackUrl release];
    
    return true;
    
}

- (NSString*) GetTrackDown{
    
    Track* curTrack = nil;
    int tempIndex = currentTrack;
    
    if (currentTrack<[tracks count]) {
        tempIndex++;
    }
    else{
        tempIndex = 0;
    }
    
    curTrack = [tracks objectAtIndex:tempIndex]; 
    if ([curTrack.trackType isEqualToString:@"APP"]){
        // If the Track is Available in the App:
        currentTrack = tempIndex;
        return curTrack.trackName;
    }
    // if the Track Isn't Availbale for playing, we return te Name of the Current Track:
    return [self GetTrack];
    
}

- (NSString*) GetTrackUp{
    
    Track* curTrack = nil;
    int tempIndex = currentTrack;
    
    if (currentTrack>0) {
        tempIndex--;
    }
    else{
        tempIndex = [tracks count]-1;
    }
    
    curTrack = [tracks objectAtIndex:tempIndex]; 
    if ([curTrack.trackType isEqualToString:@"APP"]){
        // If the Track is Available in the App:
        currentTrack = tempIndex;
        return curTrack.trackName;
    }
    // if the Track Isn't Availbale for playing, we return te Name of the Current Track:
    return [self GetTrack];
    
}

- (NSString*) GetTrack{
    
    if([tracks count] >0){
        Track* curTrack = [tracks objectAtIndex:currentTrack];
        return curTrack.trackName;  
    }
    
    return @"";
}


-(void)fastFww{
    //    Aplayer.currentTime+=0.005;
    //   [Aplayer setCurrentTime:(Aplayer.currentTime + 0.2)];
}

-(void)fastRew{
    //  Aplayer.currentTime-=0.005;
    // [Aplayer setCurrentTime:(Aplayer.currentTime - 0.2)];
}

- (void)playerStop{
    
    [Aplayer pause];
    //  [Aplayer release];
    
} 

- (NSString*) GetTrackName{
    
    Track* trkName = [tracks objectAtIndex:currentTrack];
    if(trkName){
        
        return trkName.trackName;    
        
    }else{
        
        return @"";
    }
    
}

- (int) tracksForSection:(int)section{
    int AppTracks = 0;
    int freeTracks = 0;
    int buyTracks = 0;
    
    for(int i = 0; i < [tracks count]; i++){
        
        Track* myTrack = [tracks objectAtIndex:i];
        
        if(myTrack){
            if([myTrack.trackType isEqualToString:@"APP"]) {
                AppTracks++;
            }else if ([myTrack.trackType isEqualToString:@"FREE"]) {
                freeTracks++;
            }else if ([myTrack.trackType isEqualToString:@"BUY"]) {
                buyTracks++;
            }
        }
    }                  
    
    switch (section) {	
        case 0:
            return AppTracks;
            break;
        case 1:
            return freeTracks;
            break;
        case 2:
            return buyTracks;
            break;
        default:
            return 0;
            break;
            
    }
    return 0;
}

// to Save the Downloaded Track:

- (bool) SaveDownloaded:(int) track{
    
    Track* trkSaved = [tracks objectAtIndex:track];
    
    if(trkSaved){
        
        Track* newTrack = [[Track alloc] init];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSArray* tmpArray = [trkSaved.trackLink componentsSeparatedByString:@"/"];
        
        NSString *fileName = [tmpArray objectAtIndex:[tmpArray count] -1];
        
        newTrack.trackFile = [documentsDirectory stringByAppendingPathComponent:fileName];

        newTrack.trackType = [NSString stringWithString:@"APP"];
        
        newTrack.trackName = trkSaved.trackName;
        
        newTrack.trackLink = trkSaved.trackLink;
        
        if([trkSaved.trackType isEqualToString:@"FREE"]){
            FreeTrack++;  
        }else if([newTrack.trackType isEqualToString:@"BUY"]){
            BuyTrack++;
        }
        
        [tracks removeObjectAtIndex:track];
        [tracks insertObject:newTrack atIndex:1];
        
        [newTrack release];

        if([self addTrackToLibrary:1]){
            currentTrack = 1;
            return true;
        }else{
            return false;
        }
        
    }else{
        
        return false;
        
    }
    
    return true;
}

- (bool)addTrackToLibrary:(int) track{
    NSMutableString* newTrackList = [[NSMutableString alloc] initWithString:@""];
    Track* trkWrite = nil;
    for(int i=0; i < [tracks count]; i++){
        trkWrite = [tracks objectAtIndex:i];
//        NSLog(@"%@", trkWrite);
        NSString* localString = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@%@%@", trkWrite.trackName, SEPARATOR, trkWrite.trackType, SEPARATOR, trkWrite.trackLink, SEPARATOR, trkWrite.trackFile, ENDOFLINE];
        [newTrackList appendString:localString];
        [localString release];
    }
    
    NSString* tempString=[newTrackList substringToIndex:[newTrackList length] -1];
    
    [newTrackList release];
    
    NSString *txtTracks = [TRACKLISTFILE stringByAppendingString:@".txt"];
    NSArray *Dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [Dirpaths objectAtIndex:0];
    NSString *filePathmusicName=[documentsDirectory stringByAppendingPathComponent:txtTracks]; 
    // 4) We Finally Update the TrackList.txt
    if([tempString writeToFile:filePathmusicName atomically:YES encoding:NSUTF8StringEncoding error:nil])
    {
        
        return true;
    }else
    {
        return false;
    }    
    return false;
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    
}

- (void)dealloc {
    
    [tracks release];
    [super dealloc];
    
}

@end        
