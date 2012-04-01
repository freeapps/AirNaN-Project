//
//  AIRNANAppDelegate.m
//  AIRNAN
//
//  Created by class10_user on 2/25/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import "AIRNANAppDelegate.h"
#import "MUSIC.h"
#import "BeatBox.h"

#define VERSION @"1.5"

@implementation AIRNANAppDelegate

@synthesize window, tabBarController;

#pragma mark 
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 

    // Add the tab bar controller's view to the window and display.
   // [window addSubview:tabBarController.view];
	[window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default_Airnan"]];
	splashImageView.frame = CGRectMake(0, 0, 320, 480);
    splashImageView.alpha=0;
	[window addSubview:splashImageView];

    [UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:1.75];        // sets animation duration
	[UIView setAnimationDelegate:self];        // sets delegate for this block
	[UIView setAnimationDidStopSelector:@selector(removeSplash)];   // calls the finishedFading method when the animation is done (or done fading out)	
    splashImageView.alpha = 1;
    // Fades the alpha channel of this view to "0.0" over the animationDuration of "0.75" seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
    
	BOOL hasrunBefore = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstRun"];
    
    if(!hasrunBefore){
        
        //NSString* TitleStr = [[NSString alloc] init];
        
        NSString* TitleStr = [NSString stringWithFormat:@"Welcome to the AirNaN APP %@!", VERSION]; 
    
        UIAlertView *firstRun = [[UIAlertView alloc] initWithTitle:TitleStr message:@"Create your Own AirNaN RMX by pressing BeatBox Buttons, Play AirNaN Tracks, visit us Online, And don't Forget to RATE US! Enjoy :D" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [firstRun show];
        
        [firstRun release];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstRun"];
        
      //  [TitleStr release];
        
    }
    
	tabBarController.delegate = self;
    
    // disable idle timer
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    return YES;
}

- (void)removeSplash
{
	[splashImageView removeFromSuperview];
    [window addSubview:tabBarController.view]; 
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // enable idle timer
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods
/*

// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)_tabBarController didSelectViewController:(UIViewController *)viewController {

switch (_tabBarController.selectedIndex) {
	case 0:{
        MUSIC *vPlayer = (MUSIC*)viewController;
        if(vPlayer.player.Aplayer.playing){
            
          //  [vPlayer.player playerStop];           
            
        }
	}break;
	default:
		break;
    }
 
}

*/

// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)_tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    
/*    if(_tabBarController.selectedIndex == 0){
    
        MUSIC *musicTab = (MUSIC*)[viewControllers objectAtIndex:1];
        
        [musicTab 
    
    }
 */
}



#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
/*
    UIViewController *viewcontroller = [self.tabBarController.navigationController.viewControllers objectAtIndex:0];
    
    [viewcontroller release];
  */  
    //  [vPlayer.player playerStop]; 

}

- (void)dealloc {
    [splashImageView release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

