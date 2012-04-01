//
//  CONTACT.h
//  AIRNAN
//
//  Created by class10_user on 2/26/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface CONTACT : UIViewController <MFMailComposeViewControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate> {
}

-(IBAction) Send;

@end
