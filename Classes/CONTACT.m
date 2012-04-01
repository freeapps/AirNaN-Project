//
//  CONTACT.m
//  AIRNAN
//
//  Created by class10_user on 2/26/11.
//  Copyright 2011 FreeApps Team. All rights reserved.
//

#import "CONTACT.h"


@implementation CONTACT

-(IBAction) Send{
	
	MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
		mail.mailComposeDelegate = self;
		if ([MFMailComposeViewController canSendMail]) {
			//Setting up the Subject, recipients, and message body.
			NSArray *sentTo=[NSArray arrayWithObjects:@"freeapps.team@gmail.com",nil];
			[mail setToRecipients:sentTo];
			NSString* subjectStr = [NSString stringWithFormat:@"Hi FreeApps Team!"];
            [mail setSubject:subjectStr];
			[mail setMessageBody:[NSString stringWithFormat:@"\n\n\nSent from AirNaN iPhone App (ver 1.0)"] isHTML:NO];
            // setting different than the default transition for the modal view controller   
			[mail setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];   
            //Present the mail view controller
	  	[self presentModalViewController:mail animated:YES];
		}
		//release the mail
		[mail release];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{    // hide the modal view controller
	[self dismissModalViewControllerAnimated:YES];
	if (result == MFMailComposeResultFailed) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message Failed!" message:@"Unable to send your Message" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	if (result == MFMailComposeResultSent) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message Sent!" message:@"Your Message has been sent! Thank you :)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

-(BOOL) textFieldShouldReturn:(UITextField*) theTextField{
	[theTextField resignFirstResponder];
	return YES;}

	/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
