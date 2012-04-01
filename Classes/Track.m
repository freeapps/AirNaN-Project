//
//  Track.m
//  AIRNAN
//
//  Created by class10_user on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Track.h"


@implementation Track
@synthesize trackFile, trackLink, trackName, trackType;


-(id) initWithRow:(NSString*) sRow{

    self = [super init];
    if(self){
    
        NSArray* strArray = [sRow componentsSeparatedByString:SEPARATOR];
        if(strArray){
            
            NSString* tempName = nil;
            NSString* tempType = nil;
            NSString* tempLink = nil;
            NSString* tempFile = nil;
            
            if([strArray count] >0){
                tempName = [strArray objectAtIndex:0];
            }
            if([strArray count] >1){
                tempType = [strArray objectAtIndex:1];
            }
            if([strArray count] >2){
                tempLink = [strArray objectAtIndex:2];
            }
            if([strArray count] >3){
                tempFile = [strArray objectAtIndex:3];
            }
            
            if(tempName){
                trackName = [[NSString alloc] initWithString:tempName];
            }else{
                trackName = [[NSString alloc] initWithString:@""];
            }
            if(tempType){
                trackType = [[NSString alloc] initWithString:tempType];
            }else{
                trackType = [[NSString alloc] initWithString:@""];
            }
            if(tempLink){
                trackLink = [[NSString alloc] initWithString:tempLink];
            }else{
                trackLink = [[NSString alloc] initWithString:@""];
            }
            if(tempFile){
                trackFile = [[NSString alloc] initWithString:tempFile];
            }else{
                trackFile = [[NSString alloc] initWithString:@""];
            }
    
        }
    
    }
    
    return self;

}

- (void)dealloc {
    
    [trackName release];
    [trackType release];
    [trackLink release];
    [trackFile release];
    [super dealloc];
    
}

@end
