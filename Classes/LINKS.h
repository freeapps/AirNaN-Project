//
//  LINKS.h
//  AIRNAN
//
//  Created by class10_user on 2/25/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinkWeb.h"

@interface LINKS : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	
	IBOutlet UITableView* listView;
	NSArray* subscriptions;
    
    LinkWeb* linkView;
    
    UIViewController* myWeb;
    
    UIWebView* webView;
	
}

@property(nonatomic,retain)NSArray *subscriptions;
@property(nonatomic,retain)UITableView *listView;

@property(nonatomic,retain)LinkWeb* linkView;

@property(nonatomic,retain)UIViewController* myWeb;

@property (nonatomic, retain) UIWebView* webView;

@end
