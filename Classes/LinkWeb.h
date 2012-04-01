//
//  LinkWeb.h
//  AIRNAN
//
//  Created by class11_user on 13/03/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;

@interface LinkWeb : UIViewController {
    IBOutlet UIWebView* linkpage;
	NSString *link;
	Reachability* internetReachable;
    Reachability* hostReachable;
    IBOutlet UIBarButtonItem* BackBtn;
    
    IBOutlet UIActivityIndicatorView *activity;
    
    NSTimer *t;
    
}

@property (nonatomic, retain) UIWebView* linkpage;
@property (nonatomic, retain) 	NSString *link;
@property (nonatomic, retain) UIBarButtonItem* BackBtn;


- (void) checkNetworkStatus:(NSNotification *)notice;

- (id) initWithLink:(NSString *)linkStr;

-(IBAction) Back;

@end