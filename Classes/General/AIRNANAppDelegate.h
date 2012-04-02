//
//  AIRNANAppDelegate.h
//  AIRNAN
//
//  Created by Hernan Arber on 2/25/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIRNANAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	
    UIWindow *window;
    UITabBarController *tabBarController;
    UIImageView *splashImageView;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
