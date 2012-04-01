//
//  MUSIC.h
//  AIRNAN
//
//  Created by class10_user on 2/25/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "musicPlayer.h"
#import <QuartzCore/QuartzCore.h>
#import "KTOneFingerRotationGestureRecognizer.h"

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

#define SECTIONAPP 0;
#define SECTIONFREE 1;
#define SECTIONBUY 2;

@class Reachability;
@interface MUSIC : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    
	IBOutlet UIButton* btRewind;
	IBOutlet UIButton* btPlay;
	IBOutlet UIButton* btForward;
    IBOutlet UIButton* btMore;
    
	IBOutlet UIImageView* vinyle;
	IBOutlet UIImageView* center;
	IBOutlet UIImageView* niddle;
    
    IBOutlet UIView* needleCover;
    
    IBOutlet UILabel* trackName;
    
    IBOutlet UIView* discContainer;
    
    IBOutlet UISlider *playerLevelFader;
    
	musicPlayer* player;
	NSTimer *timer;
    NSTimer *playTimer;
	float angle;
	bool play;
	int direction;
    
    bool isScratching;
    
    // for Downloading:
    int downloadTrackIndex;
    
    int PlayingTrack;
	
    
    IBOutlet UIButton* btUp;
    IBOutlet UIButton* btDown;
    IBOutlet UILabel* chooseMusic;
    
    UITableView *listMusic;
    
    UIButton *close;
    
	Reachability* internetReachable;
    Reachability* hostReachable;
    
    // For Downloading TracK:
    int id_free;
    bool isDownloading;
    
    // Traks for Sale:
    int id_buy;
    
    // Id of Selected Track:
    
    int id_SelectedTrack;
    
    NSMutableData *responseData;//data downloading
    UIProgressView *progressView;
    NSNumber *filesize;
    
    UIWebView* buylink;
    
    // For the Rotating Text:
    
    NSTimer* TextTimer;
    UIScreen* MyScreen;
    
}

@property bool isDownloading;

@property(nonatomic, retain) UIWebView* buylink;

@property(nonatomic,retain)  UIImageView* vinyle;
@property(nonatomic,retain)  UIImageView* center;
@property(nonatomic,retain)  UIImageView* niddle;
@property(nonatomic,retain)  musicPlayer* player;
@property(nonatomic,retain)  UIButton* btRewind;
@property(nonatomic,retain)  UIButton* btPlay;
@property(nonatomic,retain)  UIButton* btForward;
@property(nonatomic,retain)  UIButton* btMore;
@property(nonatomic,retain)NSTimer *timer;
@property(nonatomic,retain)NSTimer *playTimer;
@property(nonatomic,retain)IBOutlet UIView* discContainer;

@property (nonatomic, retain)    IBOutlet UISlider *playerLevelFader;

@property bool play;
@property float angle;
@property int direction;

@property int PlayingTrack;

@property(nonatomic,retain) UIView* needleCover;
@property(nonatomic, retain) UILabel* trackName;

@property bool isScratching;

@property int downloadTrackIndex;

// For Downloading:
@property (nonatomic,retain) NSMutableData *responseData;

/// for the Rotating Text:

@property(nonatomic, retain) UIScreen* MyScreen;
@property(nonatomic,retain) NSTimer* TextTimer;

//-(IBAction)play:(id)sender;
-(IBAction)playPause:(id)sender;

- (IBAction) VolumeChanged:(UISlider *)sender;

-(IBAction)More;

-(void)handleTimer:(NSTimer *)timer;
-(void)handleEndofTrack:(NSTimer *)trackTimer;
-(void)rotateVinyle;
-(void)moveNiddle:(float)rotation_angle;
-(void)setTrackNameText:(NSString*)strtrackName;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
-(void)rotating:(KTOneFingerRotationGestureRecognizer *)recognizer;

-(IBAction)upTrack;
-(IBAction)downTrack;

- (BOOL)buyTrack:(int) track;
- (BOOL)download:(int) track;
- (void) DownloadAlert:(int) track;
- (void)SaveData:(NSData *)data;

/// for the Rotating Text:

-(void)MoveText;

@end

